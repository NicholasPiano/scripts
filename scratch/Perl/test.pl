#!usr/bin/perl

@array = ("45","34","64","12","41");
@array = @array[0 .. 2];
print @array;

# @array = [
	# ["red","green","blue"],
	# ["yellow","purple","black","red"],
	# ["white","blue","orange"],
	# ["blue","red","black"],
# ];

# $str = "blue-red";
# @str_array = split(/\-/, $str);
# foreach $lm (@str_array) {
	# print $lm, "\n";
# }

# @union = @intersection = @difference = ();
# %count = ();
# foreach $element (@array1, @array2) { 
	# $count{$element}++;
# }
# foreach $element (keys %count) {
	# push @union, $element;
	# push @{ $count{$element} > 1 ? \@intersection : \@difference }, $element;
# } 

# my @sentence_array_clone = @sentence_array;
# my %sentence_hash = (); #key = sentence number, vaule = category
# my @uber_category_array = ();
# my $i; #counts through category_array
# my $j; #counts through sentence_array_clone
# for ($j=0; $j<$#sentence_array_clone; $j++) { #search through sentences
	# for($i=0; $i<$#category_array; $i++) {
		# my $short = substr($category_array[$i], 0, 4);
		# if (grep(/^$short/, @{$sentence_array_clone[$j]})) { #grep for category name in sentences (still not good enough)
			# push(@{$uber_category_array[$i]}, $j); #add to list of applicables
			# delete($sentence_array_clone[$j]); #if the first one has it, the rest can't have it
		# }
	# }
# }

# @category_array = (); #stores category titles and the numbers of lines which they apply to
# $highest_value = 0; #most common word
# while (($key, $value) = each(%freq_hash)) { #search hash
	# if (($value/$word_count >= $cut_off_value) && ($value>$highest_value)) { ######### CUTOFF VALUE ############
		# unshift(@category_array, $key); #put on beginning
		# $highest_value = $value; #also finds highest value for later
	# } elsif (($value)/($word_count) >= $cut_off_value) {
		# push(@category_array, $key); #put on end
	# }
# }