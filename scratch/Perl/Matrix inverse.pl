#usr/bin/perl

#Matrix inverse

#input
@matrix = []; #whole matrix
$size = 0; #size
@product_array = ();
print "Enter the size of the matrix.\n";

print "Enter the elements of the matrix, one by one, separated by commas.\n";
for $i (0 .. $size) {
	$in = <STDIN>;
	chop($in);
	@{$matrix[$i]} = split(/,/, $in);
	for $j (0 .. $size) {
		$inc = $j + $i
		if ($inc >= $size) {
			$inc -= $size;
		}
		@product_array[$j] = 1;
		@product_array[$j] *= $matrix[$i][$inc];
	}
}