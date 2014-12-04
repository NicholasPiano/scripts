#!usr/bin/perl

#Frequency analysis

#filename input

#print "Enter source file: ";
$source_file = "gchq_raw.txt";#<STDIN>; #Get filename
#print "Enter storage file: ";
$output_file = "gchq_freq.txt";#<STDIN>; #Get filename
#print "Enter split parameter: ";
$plit = "\s";#<STDIN>; #Get filename
#chop($source_file); #chop filename
#chop($output_file); #chop filename
#chop($plit); #chop filename

#1. Open file

open(FILE, "<$source_file") or die "Failed: file may not exist.\n"; #open file or die
@file_lines = <FILE>;#<FILE>; #pass lines to @array
close(FILE);

#2. Parse file

foreach (@file_lines) {
    @lm_array = split(/([\W])/, $_); #split by predefined parameter
    foreach $lm (@lm_array) {
	$lm_hash{$lm}++; #create entry if !exist and increment when found
    }
}

#3. Store and display results

open(OUT, ">$output_file") or die "Cannot open output file"; #open for write
print OUT "#Frequency analysis output\n";
while (($key,$value) = each(%lm_hash)) {
    print OUT $key, "=", $value, "\n";
}
close(OUT);
