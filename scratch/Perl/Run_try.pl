#!/usr/bin/perl
use warnings;
use strict;
use POSIX qw(ceil);
use Math::MPFR qw(:mpfr); 

sub log10{ my $n = shift;
       return log($n)/log(10);
  }

my $req_digits = 10000;
my $acc = ceil( $req_digits/log10(2) );
print "$acc\n";

$|++;
# 33220 is bits needed for 10000 digits
Rmpfr_set_default_prec($acc);

my $rop = Rmpfr_init2($acc); # return                                 
+                        
my $op = Rmpfr_init2($acc);  # operand                                
+                         
my $flip = Rmpfr_init2($acc);  # return test                          
+                               

Rmpfr_set_d ($op, 5.0 , GMP_RNDN);                                    
+            

#Set $rop to the square root of the 2nd arg rounded in the
#direction $rnd. Set $rop to NaN if 2nd arg is negative.
#Return 0 if the operation is exact, a non-zero value otherwise.
my $bool = Rmpfr_sqrt($rop, $op, GMP_RNDN);
print "$bool\n";
if($bool == 0){print "Exact\n";}

print "$rop\n\n"; 
print "length ",length $rop,"\n\n";


# see if return is accurate
#Set $flip to the square of $op, rounded in direction $rnd.
my $si = Rmpfr_sqr($flip, $rop, GMP_RNDN );

print "go back\n";
print "$flip\n";
# pretty close :-)