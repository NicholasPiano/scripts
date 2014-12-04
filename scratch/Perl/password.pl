#!usr/bin/perl

#create password protected perl script (local)

$possible = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
$switch = length($possible);
@codex = (0);

#1. generate password

$password = "aw3edr5p";#generatePassword(int(rand(8))) ;
print $password, "\n";
$a = <STDIN>;

#2. prompt for password
$counter = 0;
$time1 = time;
while($attempt ne $password) {
	$sum = 0; #reset sum
	$attempt = ""; #reset $attempt
	$size = scalar(@codex)-1; #address of last value
	#print "size = ",$size, "\n";
	for ($i=0; $i<($size+1); $i++) { #stepping forwards through @codex
		#print "i=",$i, "\n";
		$attempt .= substr($possible, $codex[$i], 1); #construct $attempt from numbers in @codex
		#print $attempt, "\n";
	}
	$codex[$size]++;
	for ($j=$size; $j >= 0; $j--) { #stepping backwards
		#print "codex[size]=",$codex[$size], "\n";
		if ($codex[$j] == $switch) { #last reached end?
			$codex[$j] = 0; #reset last
			if ($j-1 >= 0) { #check to see if step back exists (only for first value)
				$codex[$j-1]++; #increment step back
			}
		}
		$sum += $codex[$j]; #find sum to determine length
		#print $sum, "\n";
	}
	if ($sum == 0) { #if all counters in codex are now zero
		push(@codex, "0"); #add another counter
	}
	print $counter, "\t", $attempt, "\t";
	$counter++;
}
$time2 = time - $time1;

print "\n";
print $time2, " seconds or ", $time2/3600, " hours\n";
print $counter/$time2, " operations per second\n";
print "Correct password\n";
print "Secret revealed\n";
print $password, "\n";

 sub generatePassword {
	my($length) = shift;
	my($password);
	while (length($password) < $length) {
		$password .= substr($possible, (int(rand(length($possible)))), 1);
	}
	return $password
}
