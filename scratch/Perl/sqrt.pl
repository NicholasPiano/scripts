#!usr/bin/perl

#input number of digits to compute
$in = <STDIN>;
chop($in);

#input numer to be operated on
$in_sqrt = <STDIN>;
chop($in_sqrt);
$sqrt = $in_sqrt;

#split in_sqrt into pairs
@intmed_split_in = split(/\./, $in_sqrt); #split input by decimal point
foreach $i (@intmed_split_in) {
	print "intmed_split_in1 = $i\n";
}

if (length(scalar(@intmed_split_in) > 1 && $intmed_split_in[1])%2 != 0) { #if frac_part exists and not divisible by 2 
	$intmed_split_in[1] .= "0"; #put "0" on end
}
foreach $i (@intmed_split_in) {
	print "intmed_split_in2 = $i\n";
}

@intmed_dupl = @intmed_split_in; #unamibiguous
foreach $elem (@intmed_dupl) {
	push (@intmed_re_split, split(//, $elem)); #split into single digits for joining in the next step
}
foreach $i (@intmed_re_split) {
	print "intmed_re_split1 = $i\n";
}

if (scalar(@intmed_re_split)%2 != 0) { #push "0" onto int_part to make a pair
	unshift(@intmed_re_split, "0");
}
foreach $i (@intmed_re_split) {
	print "intmed_re_split2 = $i\n";
}

$count_vars = scalar(@intmed_re_split)/2; #unambiguous value
for($n=0; $n < $count_vars; $n++) {
	$in_sqrt_array[$n] = $intmed_re_split[2*$n].$intmed_re_split[2*$n + 1]; #join pairs
}
foreach $i (@in_sqrt_array) {
	print "in_sqrt_array = $i\n";
}
print "\n";
#find square root

$diff = 0; #stores $current - $y
@out_sqrt_array = (); #stores all $x
$length = 0; #counts up to the length needed
while($length < $in) {
	$discard = 0;
	$x = 0;
	# for() {
		 if (scalar($length <= 10)) {
			#print "if less than 10\n";
			$part = 20*join("", @out_sqrt_array);
			#print "part = $part\n";
			print $part, "\n";
			#print "diff = $diff\n";
			if (scalar(@in_sqrt_array) != 0) { # if there are still numbers to take out of the in_array
				#print "if != 0\n";
				$current = shift(@in_sqrt_array) + 100*$diff;
			} else {
				#print "else = 0\n";
				$current = 100*$diff;
			}
			#print "current = $current\n";
			print $current, "\n";
			$x = 0;
			while (($part + $x)*$x <= $current) {
				$x++;
			}
			$x--;
			#print "x = $x\n";
			print $x, "\n";
			push(@out_sqrt_array, $x);
			$diff = $current - ($part + $x)*$x;
			if ($diff == 0) {
				die "if = 0\n", @out_sqrt_array, "\n";
			}
			print $diff, "\n";
		} else {
			# print "greater than 10\n";
			# print "part = $part, length = ", length($part), "\n";
			print $part, "\n";
			$current = 10*$diff;
			$current = substr($current, 0 ,12);
			print $current, "\n";
			# print "current = $current, length = ", length($current), "\n";
			$quot = $current/$part; #divide to get a quotient
			($x, $discard) = split(/\./, $quot);
			# print "x = $x\n";
			print $x, "\n";
			push(@out_sqrt_array, $x);
			$diff = $current - $part*$x;
			# print "diff = $diff, length = ", length($diff), "\n";
			print $diff, "\n";
		}
	# }
	$length = scalar(@out_sqrt_array);
	#print "length = $length\n";
	print "\n";
} #@out_sqrt_array comes out with all the digits of the sqrt.

print @out_sqrt_array, "\n";