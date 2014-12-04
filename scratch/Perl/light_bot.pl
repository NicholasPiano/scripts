#!usr/bin/perl

#input
print("file? (y/n) ");
$ans = chop(<STDIN>);
if ($ans eq "y") {
    print("enter filename: ");
    $input_file = chop(<STDIN>);
    open <FILE>, $input_file or die "file does not open.\n";
    @lines = (<FILE>);
    close <FILE>;
} else {
    print("enter string: ");
    $line = chop(<STDIN>);
    @lines = ($line);
}
print("\n");

@hash_array = search(\@lines);
$length = scalar(@hash_array);
for ($m=0; $m<$length; $m++) {
    @
    for ($l=0; $l<) {
	
    }
}

sub search () {
    my($i, $j, $k, $n, $substr, $index, %function_hash, $line);
    
    for ($n=0; $n<scalar(@_); $n++) {
	$line = $_[$n];
	for ($i=0; $i<0.5*length($line); $i++) { #position of substr
	    for ($j=2; $j<length($line); $j++) { #length of substr
		$substr = substr($line, $i, $j);
		$k = 0;
		while ($k<length($line)) {
		    $index = index($line, $substr, $k);
		    if ($index != -1) { #position of $start in index
			$k = $index + $j; #found position + length of search string
			$function_array_hash[$n]{$substr}++;
		    }
		}
	    }
	}
    } 
    return @function_array_hash;
}
