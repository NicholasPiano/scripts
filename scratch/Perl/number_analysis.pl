#!usr/bin/perl

@numbers = (0,1,2,3,4,5,6,7,8,9);
@count_array = (0,0,0,0,0,0,0,0,0,0);

$in = <STDIN>;
chop($in);

for($x = 0;$x<1234234; $x++) {
	$y = $x/$in;
	$y =~ s/\.//g;
	@y_array = split(//, $y);
	foreach $i (@y_array) {
		foreach $j (@numbers) {
			if ($i == $j) {
				$count_array[$i]++;	
			}
		}
	}
	foreach $lm (@count_array) {
		print $lm, "   ";
	}
	print "\n";
}
foreach $m (@numbers) {
	print $m, "      ";
}
print "\n";
print $in, "\n";