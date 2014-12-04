#!usr/bin/perl

$start_run = time();

#open stop words file
open STOP, "Dad_stop_words.txt" or die;

$stops = <STOP>;
chomp($stops);
@stop_array = split(/ /, $stops);

close STOP;

#open sentence file
open SENT, "Dad_sentences_trial.txt" or die;

%freq_hash = (); #stores frequency of words
$word_count = 0; #stores total number of words
@sentence_array = (); #stores everything
$k = 0; #counts arrays (lines)
while($line = <SENT>) { #pass line to temporary variable
	chomp($line);
	
	# print "1 ", $line, "\n";
	foreach $stop_lm (@stop_array){ #weed out stops
		$line =~ s/\s$stop_lm+\s/ /g; #current $stop_lm
		$line =~ s/\s$stop_lm\Z//g; #end
		$line =~ s/\A$stop_lm\s//g; #beginning
	}
	$line =~ s/\[.+\]//g; #[words]
	# print "2 ", $line, "\n";
	
	@temp_array = split(/ /, $line); #pass words to array within array
	for ($i=0; $i<scalar(@temp_array); $i++) { #frequency analysis
		chomp($temp_array[$i]);
		if ($temp_array[$i] ne "") {
			$freq_hash{$temp_array[$i]}++; #new key is created (if it does not already exist) and its value incremented
		}
		#print $temp_array[$i], "=", $freq_hash{$temp_array[$i]}, "\n";
	}
	$word_count += scalar(@temp_array);
	@{$sentence_array[$k]} = @temp_array;
	$k++;
	print $k, "\n";
}
$line_count = $k;

close SENT;

#organize hash

open OUT, ">Dad_ouput_file_diagnostics.html" or die; #open for write, html format

print OUT "<html>\n";
print OUT "<title>Frequency Diagnostic</title>\n";

print OUT "<table border='1'>\n";
	print OUT "<tr>\n";
	print OUT "   <td><b>Word</b></td>\n"; 
	print OUT "   <td><b>Frequency</b></td>\n";
	print OUT "   <td><b>Density</b></td>\n";
	print OUT "   <td><b>Per Line</b></td>\n";
	print OUT "</tr>\n";
while (($key,$value) = each(%freq_hash)) {
	print OUT "<tr>\n";
	print OUT "   <td>", $key, "</td>\n"; 
	print OUT "   <td>", $value, "</td>\n";
	print OUT "   <td>", ($value)/($word_count), "</td>\n";
	print OUT "   <td>", ($value)/($line_count), "</td>\n";
	print OUT "</tr>\n";
}
print OUT "</table>\n";

close OUT;

#categorize

#1. go through hash
#2. pick out words that have value/line_count greater than 0.1

@category_array = (); #stores category titles and the numbers of lines which they apply to
$highest_value = 0;
while (($key,$value) = each(%freq_hash)) { #search hash
	if (($value)/($line_count) >= 0.1) { #if greater than 0.1
		push(@category_array, $key);
	}
	if ($value>$highest_value) { #find highest value for later
		$highest_value = $value;
	}
}

@category_array_save = @category_array;

#3. write these to a table as headers
#4. find lines in @words that contain even the first few letters of the category title (change, changed, changing, etc.)

foreach $category (@category_array) {
	chop($category); #remove last letter to fit better
	for ($i=0; $i<scalar(@sentence_array); $i++) { #search through sentences
		if (grep(/$category/, @{$sentence_array[$i]})) { 
			push(@{$category}, $i);
		}
	}
}

#5. each line can be in more than one category
#6. Print table to file

open OUT, ">>Dad_ouput_file_diagnostics.html" or die; #open for append, html format

print OUT "<p>\n";

print OUT "<table border='1'>\n";

$columns = scalar(@category_array);
print OUT "<tr>\n";
for ($p=0; $p<$columns; $p++) {
	print OUT "   <td>", $category_array_save[$p],"</td>\n";
}
print OUT "</tr>\n";
for ($j=0; $j<($highest_value-1); $j++) { #$j counts 
	print OUT "<tr>\n";
	for ($lm=0; $lm<$columns; $lm++){
		if ($category_array[$lm][$j] != "\s") {
			print OUT "   <td>", $category_array[$lm][$j],"</td>\n"; 
		} else {
			print OUT "   <td>Empty</td>\n";
		}
	}
	print OUT "</tr>\n";
}

print OUT "</table>\n";
print OUT "</html>";

close OUT;

#run time

$end_run = time();
$run_time = $end_run - $start_run;
print "run time = ", $run_time, " seconds or ", ($run_time)/3600," hours\n";