#!usr/bin/perl
use bytes;

$input_file = "Declaration_of_independence.txt";
$stopwords_file = "Dad_stop_words.txt";
$output_file = "Dad_ouput_file_diagnostics.html";

$time_start = time();

#open stop words file
#open(STOP, $stopwords_file) or die "Cannot open stop words file";

#$stops = <STOP>;
#chomp($stops);
@stop_array = ("the","and","a","an","but","these","this","of","to","with","by","\t"); #split(/ /, $stops);

#close STOP;

#open sentence file
open(SENT, $input_file) or die "Cannot open input file";

%freq_hash = (); #stores frequency of words
$word_count = 0; #stores total number of words
@sentence_array = (); #stores everything
$k = 0; #counts arrays (lines)
@file_lines = (<SENT>);

close SENT;

foreach $line (@file_lines) { #pass line to temporary variable
    $time_foreach = time();
    chomp($line);
    lc($line); #lower case everything
    $line =~ s/[\,\.\:\;\(\)\[\]\d\"\'\?\!\/\t\\\&\n\r]//g; #take out non-word characters
    @temp_array = split(/ /, $line); #pass words to temporary array
    for $i (0 .. $#temp_array) { #frequency analysis
	$time_for = time();
	@freq_array = keys(%freq_hash); #stores keys of %freq_hash
	$short_temp = substr($temp_array[$i], 0, 4);
	lc($temp_array[$i]); #lower case everything
	if ($temp_array[$i] eq "") {
	    delete($temp_array[$i]);
	} elsif (grep(/^$temp_array[$i]/, @stop_array)) { #if stop word
	    delete($temp_array[$i]);
	} elsif (grep(/^$short_temp/, @freq_array)) { #if word exists. not quite enough (substr method)
	    @match_array = grep(/^$short_temp/, @freq_array);
	    $freq_hash{$match_array[0]}++;
	    #print $temp_array[$i];
	    #<STDIN>;
	} else { #does not exist
	    $freq_hash{$temp_array[$i]}++; #new key is created (if it does not already exist) and its value incremented
	    #print $temp_array[$i];
	    #<STDIN>;
	}
	#$average_time_for += time()/($#temp_array); 
    }
    $word_count += $#temp_array;
    @{$sentence_array[$k]} = @temp_array;
    $k++; #counts lines
    
    $average_time_foreach += time();
    if ($k % 100 == 0) {
	print $k, " out of ", $#file_lines, "\n";
    }
}
$line_count = $k;
$cut_off_value = 0.005;#0.04 - 0.01*(1.00001**($k)); ############ DEFINE CUT_OFF_VALUE ###############

#exit filehandle with one compund array and one hash: 
#-----------@sentence_array, each element = array of each line ----> scrubbed of stop words and other blemishes (the time consuming part) 
#-----------%freq_hash, words found and the number of times they occur in the whole file (fairly quick: grep is an efficient search method).

#categorize sentences

#define most common words
@category_array = (); #stores category titles and the numbers of lines which they apply to
$highest_value = 0; #most common word
while (($key, $value) = each(%freq_hash)) { #search hash
	if ($value>$highest_value) {
		unshift(@category_array, $key); #put on beginning
		$highest_value = $value; #also finds highest value for later
	} else {
		push(@category_array, $key); #put on end
	}
}
@category_array = @category_array[0 .. 4];
#output: @category_array ----> categories sorted by the highest first

#1. push id-number of sentence onto corresponding arrays
#2. make a note of multiple categories by adding string of numbers onto end of line number (1356, 4,3,1) -> (1356-431)

%sentence_hash = (); #stores sentence number + id
%category_hash = (); #stores different categories
for $i (0 .. $k-1) { #counts through sentences
	for $j (0 .. $#category_array) {
		$cut = substr($category_array[$j], 0, -2);
		if (grep(/^$cut/, @{$sentence_array[$i]})) {
			$sentence_hash{"$i"} = $sentence_hash{"$i"}.$j;
		}
	}
	$number = $sentence_hash{"$i"};
	$category_hash{"$number"}++;
}
@category_array_numbers = keys(%category_hash);
shift(@category_array_numbers);
for $lm (0 .. $#category_array_numbers) {
	$uber_category_array[$lm][0] = $category_array_numbers[$lm];
}
$columns = $#category_array_numbers;

#highest value
@temp_array = values(%category_hash);
$highest_value = 0;
foreach $lm (@temp_array) {
	if ($lm>$highest_value) {
		$highest_value = $lm;
	}
}

while (($key,$value)=each(%sentence_hash)) { 
	for $i (0 .. $columns) {
		if ($value eq $uber_category_array[$i][0]) {
			push(@{$uber_category_array[$i]}, $key);
		}
	}
}
@freq_hash_array = keys(%freq_hash);


#run time
$time_end = time();
$time_total = $time_end - $time_start;
print "run time = ", $time_total, " seconds or ", ($time_total)/3600," hours\n"; #in seconds and hours
print "cut off value = ", $cut_off_value, "\n";

####################### PRINTING TO FILE ##########################

open(OUT, ">$output_file") or die "Cannot open output file"; #open for write, html format

print OUT "<html>\n";
print OUT "<script src='sorttable.js'></script>\n";
print OUT "<title>Frequency Diagnostic</title>\n";

print OUT "<table border='1' class='sortable'>\n";
	print OUT "<tr>\n";
	foreach $column_header ("Word","Frequency","Density","Per Line") {
		print OUT "   <td><b>", $column_header,"</b></td>\n"; #define columns
	}
	print OUT "</tr>\n";
while (($key,$value) = each(%freq_hash)) {
	print OUT "<tr>\n";
	foreach $column_value ($key,$value,($value)/($word_count),($value)/($line_count)) {
		print OUT "   <td><b>", $column_value,"</b></td>\n"; #define columns
	}
	print OUT "</tr>\n";
}
print OUT "</table>\n";
print OUT "<p>\n"; #separate

###### SECOND TABLE ######
print OUT "<table border='1' style='WORD-WRAP:'>\n";
print OUT "<tr>\n"; #headers
while(($key,$value)=each(%category_hash)) {
	if ($key ne "") {
		print OUT "   <td><b>";
		@values = split(//, $key);
		foreach $lm (@values) {
			print OUT $category_array[$lm], " ";
		}
		print OUT "</b></td>\n";
	}
}
print OUT "</tr>\n";
for ($j=1; $j<($highest_value-1); $j++) { #table body (rows), cycle through compound array (two loops) 
	print OUT "<tr>\n";
	for $lm (0 .. $columns){ #columns
		if ($uber_category_array[$lm][$j] != "\s") { #only print when no space
			$number = $uber_category_array[$lm][$j];
			$element = join(" ", @{$sentence_array[$number]});
			print OUT "   <td>", $uber_category_array[$lm][$j]," ", $element,"</td>\n"; #
		} else { #if space
			print OUT "   <td>-</td>\n";
		}
	}
	print OUT "</tr>\n";
}

print OUT "</table>\n"; #end second table
print OUT "</html>"; #end HTML file

close OUT;
##################### //PRINTING TO FILE ##########################
