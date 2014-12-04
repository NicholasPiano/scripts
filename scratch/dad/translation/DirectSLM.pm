# -*- PERL -*-
# Perl library module for SLMDirect
# DirectSLM.pm
#
# ****************************************************************************************
# ****************************************************************************************
#   Copyright 2012 Abacii Services.  All rights reserved.
#   This is an unpublished work of Abacii Services and is not to be
#   used or disclosed except as provided in a license agreement or
#   nondisclosure agreement with Abacii Services.
# ****************************************************************************************
# ****************************************************************************************
#
# Modified: Tue Apr 17 09:25:41 2012
#
# Created: August 12, 2011 v1.0 Larry Piano

package DirectSLM;

require Exporter;
@ISA = qw(Exporter);
#
# Globally exported functions
#
@EXPORT = qw(ApplyBuildMainString ApplyClassGrammars ApplyCorrectionAfterModSearch ApplyCorrectionRules ApplyFirstCorrectionRules ApplyParsingRules AssignLineType BuildDataStrings_FlatFile BuildDataStrings_Other BuildRepStrings BuildWordEndingsList CALL_SLMDirect CheckCats CheckForTranscriptions CheckIntegrity1 CheckKeywordHashes CheckSkipPhrase CheckTimeDiff checkRules ChopChar Classify_Output_Format ConditionalPrint CountParens createBackup CreateMainGrammar DebugPrint DetermineSourceAssignment DoAllCorrections ExpandSentence FillBuildStrings FillFilterArrays FillGoodFragmentHash FillGrammarElements FillSearchString FillTranslateHash FilterAmbigWords FilterCorpus FilterRepeatsETC FindAllReferences FindEnclosure FindFirstChar GenReducedCorpus GenWordList GetClosure GetClosure_SLMDirect GetEnclosure GetKnownCatsInfo GetReclassInfo GetResidualString GetReverseClosure GetRuleErrors writeTask MakeCatList1 MakeCatList2 MakeCleanTrans MakeCompressedAliasSentence NewGetClosure NormalizeFilename NormCat ParseGrammar ProcessChars ProcessCharsInitial ProcessCharsPlus ProcessNounVerbSentences ProcessOPTIONALs ProcessOPTIONALs_SLMDirect ProcessPrefix PutInVocab ReadNewCats ReadParse RemoveChar RemoveRepeats ReplaceEnclosures resetErrorsWarnings RestoreCorpusFile SeparateTaggedSentences Set_Elem_Format setTask SimpleReplaceMy SqueezeSentence stringBuilder TestSkipPhrase ThisGetClosure TransCatList TrimChars TrimCharsChangeTab WriteAssignmentFile WriteClassifications WriteDataStrings WriteGenRefFile WriteMainGrammar WriteMainGrammar_nuance_variant_xml WriteNewCatsFile WriteReplacementMainGrammar WriteVocabs Write_FilterCorpus_Fileout Write_Grammar_Out_all Write_SubGrammars_Out Write_Output_Format alphabetically AutoTagFilterSingles bump_num catdefOrder change_num change_num_three checkMultiParseVariables checkSpecialParseVariables chooseCompressedSentence createSearchString fisher_yates_shuffle getItemInfo getOutEncoding interpretCommand makeAliasExclusion makeArrayfromString makeArrayDirectfromString makeClassGrammars makeTaggingFile makeHashfromString makeHeavyHashfromString makeIndentedFile makePOSHashfromString makeSynonymHashfromString makeStringDirectfromString makeTrainingFileArray makeTruthFiles putItemInfo numerically setConnector setFalseFreqsfromString setRuleWordHash storeLocationInfo storeLocationInfoOrdered stringToVocab uniq);
#
#
use strict 'vars';
use File::Copy;
#
# declare the global variables to be used
#
use vars qw($raw_input $unparsed_raw_data $focusInputDir $webSwitch $pre_search_string $defaultDirectSLMVersion $vanilla_callingProg @callingProg_array $called_from_gui $err_no $err_msg_no $warning_msg_no $task_no $sub_task_no $debug $char13 $char10 $char186 $char135 $char166 $char128 $hard_error $num_infos $num_warnings $num_errors %ones_number_hash %tens_number_hash @error_message_array @warning_message_array
	    );

BEGIN {
  $ones_number_hash{"0"} = "zero";
  $ones_number_hash{"1"} = "one";
  $ones_number_hash{"2"} = "two";
  $ones_number_hash{"3"} = "three";
  $ones_number_hash{"4"} = "four";
  $ones_number_hash{"5"} = "five";
  $ones_number_hash{"6"} = "six";
  $ones_number_hash{"7"} = "seven";
  $ones_number_hash{"8"} = "eight";
  $ones_number_hash{"9"} = "nine";
  $ones_number_hash{"01"} = "one";
  $ones_number_hash{"02"} = "two";
  $ones_number_hash{"03"} = "three";
  $ones_number_hash{"04"} = "four";
  $ones_number_hash{"05"} = "five";
  $ones_number_hash{"06"} = "six";
  $ones_number_hash{"07"} = "seven";
  $ones_number_hash{"08"} = "eight";
  $ones_number_hash{"09"} = "nine";
  $ones_number_hash{"10"} = "ten";
  $ones_number_hash{"11"} = "eleven";
  $ones_number_hash{"12"} = "twelve";
  $ones_number_hash{"13"} = "thirteen";
  $ones_number_hash{"14"} = "fourteen";
  $ones_number_hash{"15"} = "fifteen";
  $ones_number_hash{"16"} = "sixteen";
  $ones_number_hash{"17"} = "seventeen";
  $ones_number_hash{"18"} = "eighteen";
  $ones_number_hash{"19"} = "nineteen";
  $ones_number_hash{"0th"} = "zeroth";
  $ones_number_hash{"1st"} = "first";
  $ones_number_hash{"2nd"} = "second";
  $ones_number_hash{"3rd"} = "third";
  $ones_number_hash{"4th"} = "fourth";
  $ones_number_hash{"5th"} = "fifth";
  $ones_number_hash{"6th"} = "sixth";
  $ones_number_hash{"7th"} = "seventh";
  $ones_number_hash{"8th"} = "eighth";
  $ones_number_hash{"9th"} = "ninth";
  $ones_number_hash{"01st"} = "first";
  $ones_number_hash{"02nd"} = "second";
  $ones_number_hash{"03rd"} = "third";
  $ones_number_hash{"04th"} = "fourth";
  $ones_number_hash{"05th"} = "fifth";
  $ones_number_hash{"06th"} = "sixth";
  $ones_number_hash{"07th"} = "seventh";
  $ones_number_hash{"08th"} = "eighth";
  $ones_number_hash{"09th"} = "ninth";
  $ones_number_hash{"10th"} = "tenth";
  $ones_number_hash{"11th"} = "eleventh";
  $ones_number_hash{"12th"} = "twelfth";
  $ones_number_hash{"13th"} = "thirteenth";
  $ones_number_hash{"14th"} = "fourteenth";
  $ones_number_hash{"15th"} = "fifteenth";
  $ones_number_hash{"16th"} = "sixteenth";
  $ones_number_hash{"17th"} = "seventeenth";
  $ones_number_hash{"18th"} = "eighteenth";
  $ones_number_hash{"19th"} = "nineteenth";

  $tens_number_hash{"2"} = "twenty";
  $tens_number_hash{"3"} = "thirty";
  $tens_number_hash{"4"} = "forty";
  $tens_number_hash{"5"} = "fifty";
  $tens_number_hash{"6"} = "sixty";
  $tens_number_hash{"7"} = "seventy";
  $tens_number_hash{"8"} = "eighty";
  $tens_number_hash{"9"} = "ninety";
  $tens_number_hash{"20"} = "twenty";
  $tens_number_hash{"30"} = "thirty";
  $tens_number_hash{"40"} = "forty";
  $tens_number_hash{"50"} = "fifty";
  $tens_number_hash{"60"} = "sixty";
  $tens_number_hash{"70"} = "seventy";
  $tens_number_hash{"80"} = "eighty";
  $tens_number_hash{"90"} = "ninety";
  $tens_number_hash{"20th"} = "twentieth";
  $tens_number_hash{"30th"} = "thirtieth";
  $tens_number_hash{"40th"} = "fortieth";
  $tens_number_hash{"50th"} = "fiftieth";
  $tens_number_hash{"60th"} = "sixtieth";
  $tens_number_hash{"70th"} = "seventieth";
  $tens_number_hash{"80th"} = "eightieth";
  $tens_number_hash{"90th"} = "ninetieth";

  $defaultDirectSLMVersion = "v1.0";
  $vanilla_callingProg = $0;
  $debug = 0;
  $err_no = 0;
  $sub_task_no = 0;
  $task_no = 0;
  $err_msg_no = 0;
  $warning_msg_no = 0;
  $hard_error = 0;
  $num_warnings = 0;
  $num_errors = 0;

  $char10 = chr(10);
  $char13 = chr(13);
  $char128 = chr(199); #"Ç"
  $char135 = chr(231); #"ç"
  $char166 = chr(170); #"ª"
  $char186 = chr(186); #"º"

  $webSwitch = 0;
  $focusInputDir = "/home/abaciivo/public_html/scripts/";

  $raw_input = '';
  $unparsed_raw_data = '';
}

######################################################################
######################################################################
############# GENERAL UTILITIES AND SUBROUTINES ######################
######################################################################
######################################################################

# ********************************************************************
# for numeric sorts
# ********************************************************************

sub numerically {$a <=> $b }

sub alphabetically {$a cmp $b }

# ********************************************************************
# same as Unix uniq
# ********************************************************************
#	    for $k (keys %mapHsh) {
#	      for ( uniq sort values %{$mapHsh{$k}} ) { print GRAM ",$_" }
#	    }

sub uniq {		# how can a unix hacker do without this?
    my($last, @stack);
    foreach $_ (@_) {
		if ($_ ne $last) {
			push @stack, $_;
			$last = $_;
		}
    }
    return @stack;
}

sub change_num {
    my($num, $suffix) = @_;

    my($out_string) = "";
    my($repcount) = 0;
    my($ordinal) = $suffix;
	my($num_len) = length($num);
	my($temp_num);
    my($pos) = $num_len;
	my($add_string) = " ";

	while ($pos > 0) {
		if ($repcount > 0) {
			$ordinal = "";
		}

		($temp_num, $pos) = bumpNum($num, $pos);

		if ($out_string eq "") {
			$out_string = change_num_three("$temp_num", $ordinal);
		} else {
			if ($repcount == 1) {
				$add_string = " ?thousand ";
			} elsif ($repcount == 2) {
				$add_string = " ?million ";
			} elsif ($repcount == 3) {
				$add_string = " ?billion ";
			} elsif ($repcount == 4) {
				$add_string = " ?trillion ";
			}

			$out_string = change_num_three("$temp_num", $ordinal)."$add_string".$out_string;
		}

		$repcount++;
	}

	return $out_string;

}

sub bumpNum {
    my($num, $startpos) = @_;
	my($temp_num);
	my($endpos);

	for ($endpos = $startpos; $endpos >= $startpos-2; $endpos--) {
		if ($endpos == 0) {
			last;
		}
	}

	$temp_num = substr($num, $endpos, $startpos-$endpos);

	return ($temp_num, $endpos);
}

sub change_num_three {
    my($num, $suffix) = @_;

    my($out_string) = "";
    my($temp_out_string) = "";
	my($num_len) = length($num);

	my($last_one) = substr($num, $num_len-1, 1);
	my($last_two) = -1;
	my($last_three) = -1;

	my($pos_two) = -1;
	my($pos_three) = -1;

	my($ending);

	if ($num_len >= 2) {
		$last_two = substr($num, $num_len-2, 2);
		$pos_two = substr($num, $num_len-2, 1);
	}

	if ($num_len >= 3) {
		$last_three = substr($num, $num_len-3, 3);
		$pos_three = substr($num, $num_len-3, 1);
	}

	$ending = "";
	if ($suffix ne "") {
		$ending = "th";
	}

	if ($last_two == -1) {
		$out_string = $ones_number_hash{"$last_one"."$suffix"};
	} else {
		if ($last_two == 0) {
		} elsif ($last_two < 20) {
			$out_string = $ones_number_hash{"$last_two"."$suffix"};
		} else {
			if ($last_one == 0) {
				$out_string = $tens_number_hash{"$last_two"."$suffix"};
			} else {
				$out_string = $tens_number_hash{$pos_two}." ".$ones_number_hash{"$last_one"."$suffix"};
			}
		}

		$temp_out_string = $out_string;

		if ($last_three > 0) {
			if ($temp_out_string ne "") {
				$out_string = $ones_number_hash{"$pos_three"}." ?(hundred and)"." $temp_out_string";
			} else {
				$out_string = $ones_number_hash{"$pos_three"}." hundred".$ending;
			}
		}
	}

	return $out_string;

}

# Return the Levenshtein distance (also called Edit distance)
# between two strings
#
# The Levenshtein distance (LD) is a measure of similarity between two
# strings, denoted here by s1 and s2. The distance is the number of
# deletions, insertions or substitutions required to transform s1 into
# s2. The greater the distance, the more different the strings are.
#
# The algorithm employs a proximity matrix, which denotes the distances
# between substrings of the two given strings. Read the embedded comments
# for more info. If you want a deep understanding of the algorithm, print
# the matrix for some test strings and study it
#
# The beauty of this system is that nothing is magical - the distance
# is intuitively understandable by humans
#
# The distance is named after the Russian scientist Vladimir
# Levenshtein, who devised the algorithm in 1965
#
sub levenshtein
{
    # $s1 and $s2 are the two strings
    # $len1 and $len2 are their respective lengths
    #
    my ($s1, $s2) = @_;
    my ($len1, $len2) = (length $s1, length $s2);

    # If one of the strings is empty, the distance is the length
    # of the other string
    #
    return $len2 if ($len1 == 0);
    return $len1 if ($len2 == 0);

    my %mat;
    my %s;
	my @ar1;
	my @ar2;

	my $pick;
	my $selection;


    # Init the distance matrix
    #
    # The first row to 0..$len1
    # The first column to 0..$len2
    # The rest to 0
    #
    # The first row and column are initialized so to denote distance
    # from the empty string
    #
    for (my $i = 0; $i <= $len1; ++$i)
    {
        for (my $j = 0; $j <= $len2; ++$j)
        {
            $mat{$i}{$j} = 0;
            $mat{0}{$j} = $j;
			$s{0}{$j} = $ar2[$j];
        }

        $mat{$i}{0} = $i;
	    $s{$i}{0} = $ar1[$i];
    }

    # Some char-by-char processing is ahead, so prepare
    # array of chars from the strings
    #
    @ar1 = split(//, $s1);
    @ar2 = split(//, $s2);

    for (my $i = 1; $i <= $len1; ++$i)
    {
        for (my $j = 1; $j <= $len2; ++$j)
        {
            # Set the cost to 1 iff the ith char of $s1
            # equals the jth of $s2
            #
            # Denotes a substitution cost. When the char are equal
            # there is no need to substitute, so the cost is 0
            #
            my $cost = ($ar1[$i-1] eq $ar2[$j-1]) ? 0 : 1;

            # Cell $mat{$i}{$j} equals the minimum of:
            #
            # - The cell immediately above plus 1
            # - The cell immediately to the left plus 1
            # - The cell diagonally above and to the left plus the cost
            #
            # We can either insert a new char, delete a char or
            # substitute an existing char (with an associated cost)
            #
            $mat{$i}{$j} = min([$mat{$i-1}{$j} + 1,
                                $mat{$i}{$j-1} + 1,
                                $mat{$i-1}{$j-1} + $cost]);

            $pick = min([$mat{$i-1}{$j} + 1.1,
                                $mat{$i}{$j-1} + 1.2,
                                $mat{$i-1}{$j-1} + $cost + 0.3]);
	    $selection = int(($pick - int($pick)) * 10 + 0.5);
	    if ($selection == 1) {
	      # use above with space
	      $s{$i}{$j} = $s{$i-1}{$j} . " " . $ar2[$j-1];
	    } elsif ($selection == 2) {
	      $s{$i}{$j} = $s{$i}{$j-1} . " " . $ar2[$j-1];
	    } else {
	      $s{$i}{$j} =  $s{$i-1}{$j-1} . (($cost == 0) ? "" : " ") . $ar2[$j-1] ;
	    }
        }
    }
    # Finally, the Levenshtein distance equals the rightmost bottom cell
    # of the matrix
    #
    # Note that $mat{$x}{$y} denotes the distance between the substrings
    # 1..$x and 1..$y
    #
      for (my $i = 0; $i <= $len2; ++$i)
    {
        for (my $j = 0; $j <= $len1; ++$j)
        {
#            printf " %2d",$mat{$j}{$i};
        }
#	print "\n";
    }
    #return $s{$len1}{$len2};

    return $mat{$len1}{$len2};
}

sub bilevenshtein
{
    # $s1 and $s2 are the two strings
    # $len1 and $len2 are their respective lengths
    #
    my ($s1, $s2) = @_;
    my ($len1, $len2) = (length $s1, length $s2);

    # If one of the strings is empty, the distance is the length
    # of the other string - 1 (number of bigrams)
    #
    return ($len2-1) if ($len1 == 0);
    return ($len1-1) if ($len2 == 0);

    my %mat;
    my %s;
	my @ar1;
	my @ar2;

	my $pick;
	my $selection;

    # Init the distance matrix
    #
    # The first row to 0..$len1
    # The first column to 0..$len2
    # The rest to 0
    #
    # The first row and column are initialized so to denote distance
    # from the empty string
    #
    for (my $i = 0; $i < $len1; ++$i)
    {
        for (my $j = 0; $j < $len2; ++$j)
        {
            $mat{$i}{$j} = 0;
            $mat{0}{$j} = $j;
	    $s{0}{$j} = $ar2[$j];
        }

        $mat{$i}{0} = $i;
	    $s{$i}{0} = $ar1[$i];
    }

    # Some char-by-char processing is ahead, so prepare
    # array of bigrams from the strings
    #
    @ar1 = split(//, $s1);
    @ar2 = split(//, $s2);
    for(my $i=0; $i < $#ar1; $i++) {
      $ar1[$i] .= $ar1[$i+1];
    }
    for(my $i=0; $i < $#ar2; $i++) {
      $ar2[$i] .= $ar2[$i+1];
    }
    for (my $i = 1; $i < $len1; ++$i)
    {
        for (my $j = 1; $j < $len2; ++$j)
        {
            # Set the cost to 1 iff the ith char of $s1
            # equals the jth of $s2
            #
            # Denotes a substitution cost. When the char are equal
            # there is no need to substitute, so the cost is 0
            #
            my $cost = ($ar1[$i-1] eq $ar2[$j-1]) ? 0 : 1;
	    #decrease penalty for mismatches at the end
	    if ($len1 > 6 && ($len1 - $i) < 4) { $cost *= .5; }
	    if ($len2 > 6 && ($len2 - $j) < 4) { $cost *= .5; }

            # Cell $mat{$i}{$j} equals the minimum of:
            #
            # - The cell immediately above plus 1
            # - The cell immediately to the left plus 1
            # - The cell diagonally above and to the left plus the cost
            #
            # We can either insert a new char, delete a char or
            # substitute an existing char (with an associated cost)
            #
            $mat{$i}{$j} = min([$mat{$i-1}{$j} + 1,
                                $mat{$i}{$j-1} + 1,
                                $mat{$i-1}{$j-1} + $cost]);

            $pick = min([$mat{$i-1}{$j} + 1.1,
                                $mat{$i}{$j-1} + 1.2,
                                $mat{$i-1}{$j-1} + $cost + 0.3]);
	    $selection = int(($pick - int($pick)) * 10 + 0.5);
	    if ($selection == 1) {
	      # use above with space
	      $s{$i}{$j} = $s{$i-1}{$j} . " " . $ar2[$j-1];
	    } elsif ($selection == 2) {
	      $s{$i}{$j} = $s{$i}{$j-1} . " " . $ar2[$j-1];
	    } else {
	      $s{$i}{$j} =  $s{$i-1}{$j-1} . (($cost == 0) ? "" : " ") . $ar2[$j-1] ;
	    }
        }
    }
    # Finally, the Levenshtein distance equals the rightmost bottom cell
    # of the matrix
    #
    # Note that $mat{$x}{$y} denotes the distance between the substrings
    # 1..$x and 1..$y
    #

    if (0) {
		print "\n";
		for (my $i = 0; $i <= $len2; ++$i) {
			for (my $j = 0; $j <= $len1; ++$j) {
				printf " %2d",$mat{$j}{$i};
			}

			print "\n";
		}

		return $s{$len1-1}{$len2-1};
    }

    return $mat{$len1-1}{$len2-1};
}


# minimal element of a list
#
sub min
{
    my @list = @{$_[0]};
    my $min = $list[0];

    foreach my $i (@list)
    {
        $min = $i if ($i < $min);
    }

    return $min;
}

sub CheckTimeDiff {

    my($callid, $prev_callid, $time, $prev_time) = @_;

	my($callid_is_diff);
	my($tdiff);

	my($thours);
	my($tmins);
	my($tsecs);

	my($phours);
	my($pmins);
	my($psecs);

	if ($prev_callid == -1) {
		$callid_is_diff = 1;
	} else {
		$callid_is_diff = 0;
		if ($callid != $prev_callid) {
			$callid_is_diff = 1;
		} else {
			($thours, $tmins, $tsecs) = split "-", $time;
			($phours, $pmins, $psecs) = split "-", $prev_time;

			if ($thours > $phours) {
				if ($tmins >= $pmins) {
					$tdiff = (($thours - $phours) * 60) + ($tmins - $pmins);
				} else {
					$thours--;
					$tmins += 60;

					$tdiff = (($thours - $phours) * 60) + ($tmins - $pmins);
				}
			} elsif ($thours < $phours) {
				if ($pmins >= $tmins) {
					$tdiff = (($phours - $thours) * 60) + ($pmins - $tmins);
				} else {
					$phours--;
					$pmins += 60;

					$tdiff = (($phours - $thours) * 60) + ($pmins - $tmins);
				}
			} else {
				if ($tmins >= $pmins) {
					$tdiff = (($thours - $phours) * 60) + ($tmins - $pmins);
				} else {
					$tdiff = $pmins - $tmins;
				}
			}

			if ($tdiff > 5) {
				$callid_is_diff = 1;
			}
		}
	}

	return ($callid_is_diff);
}

sub ChopChar($) {

    my($in_string) = @_;

	my($lastchar);

	$lastchar = substr($in_string,length($in_string)-1,1);
	while ((ord($lastchar) == 13) || ($lastchar eq "\n")) {
		chop($in_string);
		$lastchar = substr($in_string,length($in_string)-1,1);
	}

	return $in_string;

}

sub CountParens
{

    my($myvarvalue) = @_;

	my($return_val) = 0;

    my(@char_array) = split "", $myvarvalue;

	my($char_pos) = 0;
	my($num_lparen) = 0;
	my($num_rparen) = 0;
	my($char);

	while ($char_pos < length($myvarvalue)) {
		$char = $char_array[$char_pos];
		if ($char eq "(") {
			$num_lparen++;
		} elsif ($char eq ")") {
			$num_rparen++;
		}

		$char_pos++;
	}

	if ($num_lparen != $num_rparen) {
		$return_val = 1;
	}

	return $return_val;
}

sub FindFirstChar
{
    my($istartptr, $sonechar, $stwochar, $sthreechar, $teststring) = @_;

	my($loc);
	my($loc1);
	my($loc2);
	my($loc3);
	my($startchar) = "";

	$loc = -1;
	$loc2 = -1;
	$loc3 = -1;
	$loc1 = index($teststring, $sonechar, $istartptr);

	if ($stwochar ne "") {
		$loc2 = index($teststring, $stwochar, $istartptr);
	}

	if ($sthreechar ne "") {
		$loc3 = index($teststring, $sthreechar, $istartptr);
	}

	if (($loc1 != -1) && ($loc2 != -1) && ($loc3 != -1)) {
		if (($loc1 < $loc2) && ($loc1 < $loc3)) {
			$loc = $loc1;
		} elsif (($loc2 < $loc1) && ($loc2 < $loc3)) {
			$loc = $loc2;
		} elsif (($loc3 < $loc1) && ($loc3 < $loc2)) {
			$loc = $loc3;
		}
	} elsif (($loc1 != -1) && ($loc2 != -1)) {
		if ($loc1 < $loc2) {
			$loc = $loc1;
		} else {
			$loc = $loc2;
		}
	} elsif (($loc1 != -1) && ($loc3 != -1)) {
		if ($loc1 < $loc3) {
			$loc = $loc1;
		} else {
			$loc = $loc3;
		}
	} elsif (($loc2 != -1) && ($loc3 != -1)) {
		if ($loc2 < $loc3) {
			$loc = $loc2;
		} else {
			$loc = $loc3;
		}
	} elsif ($loc1 != -1) {
		$loc = $loc1;
	} elsif ($loc2 != -1) {
		$loc = $loc2;
	} elsif ($loc3 != -1) {
		$loc = $loc3;
	}

	if ($loc != -1) {
		$startchar = substr($teststring,$loc,1);
	}

	return ($loc, $startchar);
}

sub ProcessChars($) {
    my($in_string) = @_;

	my($retval) = $in_string;
	my($firstchar);

	$retval = ChopChar($retval);
	$retval =~ s/\x85/\.\.\./g;
	$retval =~ s/\x92/\'/g;
#	$retval =~ s/\xC2//g;
#	$retval =~ s/\xC3//g;
#	$retval =~ s/\x82//g;
#	$retval =~ s/\t/\ /g;

	$retval = TrimChars($retval);

	$firstchar = substr($retval,0,1);

	return ($retval, $firstchar);

}

sub ProcessCharsInitial($) {
    my($in_string) = @_;

	my($retval) = $in_string;

	$retval = ChopChar($retval);
	$retval =~ s/\x85/\.\.\./g;
	$retval =~ s/\x92/\'/g;
	$retval =~ s/\|/\//g;

	$retval =~ s/\xC2//g;
	$retval =~ s/\xC3//g;
	$retval =~ s/\x82//g;
#	$retval =~ s/\t/\ /g;

	$retval = TrimChars($retval);

	return ($retval);

}

sub ProcessCharsPlus($) {
    my($in_string) = @_;

	my($retval) = $in_string;
	my($firstchar);

	$retval = ChopChar($retval);
	$retval =~ s/\x85/\.\.\./g;
	$retval =~ s/\x92/\'/g;
	$retval =~ s/\xC2//g;
	$retval =~ s/\xC3//g;
	$retval =~ s/\x82//g;

	$retval = TrimChars($retval);

	$firstchar = substr($retval,0,1);

	return ($retval, $firstchar);

}

sub ProcessCharsPlusMinus($) {
    my($in_string) = @_;

	my($retval) = $in_string;

	$retval = ChopChar($retval);
	$retval =~ s/\x85/\.\.\./g;
	$retval =~ s/\x92/\'/g;
	$retval =~ s/\xC2//g;
	$retval =~ s/\xC3//g;
	$retval =~ s/\x82//g;

	$retval = TrimChars($retval);

	return ($retval);

}

sub TrimChars($) {

    my($in_string) = @_;

	my($retval) = $in_string;

	$retval =~ tr/ / /s;
	$retval =~ s/^\s*(.*?)\s*$/$1/;
	$retval =~ s/\( /(/;
	$retval =~ s/ \)/)/;
	$retval =~ s/\[ /[/;
	$retval =~ s/ \]/]/;
	$retval =~ s/\{ /{/;
	$retval =~ s/ \}/}/;

	if (substr($retval,0,1) eq " ") {
	}

	return $retval;
}

sub TrimCharsChangeTab($) {

    my($in_string) = @_;

	my($retval) = $in_string;

	$retval =~ s/\\t/ /g;

	$retval = TrimChars($retval);

	return $retval;
}

sub DoAllCorrections {

    my($general_args, $cleaning_args, $first_stage_done, $apply_classgrammars, $test_category, $no_response_exclusion, $utt) = @_;
	$utt = ProcessCharsInitial($utt);

	if ($$general_args{"downcase_utt"}) {
		$utt = lc($utt);
	}

	$utt =~ s/\*(blank|Blank)\*/[x]/g;

 	$utt = ApplyCorrectionRules($cleaning_args, $first_stage_done, $no_response_exclusion, $utt);

	if (($utt ne "") && ($utt ne " ")) {
		if ($$cleaning_args{"removerepeats"}) {
			$utt = RemoveRepeats($utt);
		}

		if ($apply_classgrammars) {
			$utt = ApplyClassGrammars ($general_args, $cleaning_args, $test_category, $utt);
		}
	}

	return ($utt);

}

sub RemoveRepeats {

    my($line) = @_;

	my($elem);

	my(@line_array);
	my(@temp_array);
	my(@build_array);
	my(@build2_array);
	my(@build3_array);

	my(%line_hash);
	my($do_repeat_search);
	my($prev_word) = "";
	my($prev_two_words) = "";
	my($prev_three_words) = "";
	my($temp_line) = "";

	my($test_word) = "";
	my($test_prev_two_words) = "";
	my($test_prev_three_words) = "";

	my($line_enter);
	my($line_exit);

	my(%repeat_okay_hash) = (
						'b' => 1,
						'c' => 1,
						'd' => 1,
						'e' => 1,
						'f' => 1,
						'g' => 1,
						'h' => 1,
						'j' => 1,
						'k' => 1,
						'l' => 1,
						'm' => 1,
						'n' => 1,
						'o' => 1,
						'p' => 1,
						'q' => 1,
						'r' => 1,
						's' => 1,
						't' => 1,
						'u' => 1,
						'v' => 1,
						'w' => 1,
						'x' => 1,
						'y' => 1,
						'z' => 1,
						'oh' => 1,
						'zero' => 1,
						'one' => 1,
						'two' => 1,
						'three' => 1,
						'four' => 1,
						'five' => 1,
						'six' => 1,
						'seven' => 1,
						'eight' => 1,
						'nine' => 1,
						'ten' => 1,
						'eleven' => 1,
						'twelve' => 1,
						'thirteen' => 1,
						'fourteen' => 1,
						'fifteen' => 1,
						'sixteen' => 1,
						'seventeen' => 1,
						'eighteen' => 1,
						'nineteen' => 1,
						'twenty' => 1,
						'thirty' => 1,
						'forty' => 1,
						'fifty' => 1,
						'sixty' => 1,
						'seventy' => 1,
						'eighty' => 1,
						'ninety' => 1,
						'hundred' => 1,
						'thousand' => 1,
						);

	$line = TrimChars($line);

#print "hereaaa111: line=$line\n";

	$line =~ s/((.*)\2)/DeleteRepeats($1, $2, \%repeat_okay_hash)/eg;
	while ($line ne $temp_line) {
	  $temp_line = $line;
	  $line =~ s/((.*)\2)/DeleteRepeats($1, $2, \%repeat_okay_hash)/eg;
	}

#print "hereaaa222: line=$line\n";

	return $line;
}

sub DeleteRepeats
{
	my($sentence1, $sentence2, $repeat_okay_hash) = @_;

	my($trim2);
	my(@trim2_array);

	if ($sentence2 ne "") {
	  $trim2 = TrimChars($sentence2);
	  @trim2_array = split " ", $trim2;
#	  print "sentence1a=>>>$sentence1<<<\n";
#	  print "sentence2=>>>$sentence2<<<\n";
#	  print "trim2_array=", $trim2_array[0], "\n";
	  if ((defined $$repeat_okay_hash{$trim2_array[0]}) || $sentence1 !~ / /) {
#		print "return1=>>>$sentence1<<<\n";
		return $sentence1;
	  } else {
#		print "return2=>>>$sentence2<<<\n";
		return $sentence2;
	  }
	} else {
	  return $sentence2;
	}

}

sub RemoveRepeats_save {

    my($line) = @_;

	my($elem);

	my(@line_array);
	my(@temp_array);
	my(@build_array);
	my(@build2_array);
	my(@build3_array);

	my(%line_hash);
	my($do_repeat_search);
	my($prev_word) = "";
	my($prev_two_words) = "";
	my($prev_three_words) = "";

	my($test_word) = "";
	my($test_prev_two_words) = "";
	my($test_prev_three_words) = "";

	my($line_enter);
	my($line_exit);

	my(%repeat_okay_hash) = (
						'b' => 1,
						'c' => 1,
						'd' => 1,
						'e' => 1,
						'f' => 1,
						'g' => 1,
						'h' => 1,
						'j' => 1,
						'k' => 1,
						'l' => 1,
						'm' => 1,
						'n' => 1,
						'o' => 1,
						'p' => 1,
						'q' => 1,
						'r' => 1,
						's' => 1,
						't' => 1,
						'u' => 1,
						'v' => 1,
						'w' => 1,
						'x' => 1,
						'y' => 1,
						'z' => 1,
						'oh' => 1,
						'zero' => 1,
						'one' => 1,
						'two' => 1,
						'three' => 1,
						'four' => 1,
						'five' => 1,
						'six' => 1,
						'seven' => 1,
						'eight' => 1,
						'nine' => 1,
						'ten' => 1,
						'eleven' => 1,
						'twelve' => 1,
						'thirteen' => 1,
						'fourteen' => 1,
						'fifteen' => 1,
						'sixteen' => 1,
						'seventeen' => 1,
						'eighteen' => 1,
						'nineteen' => 1,
						'twenty' => 1,
						'thirty' => 1,
						'forty' => 1,
						'fifty' => 1,
						'sixty' => 1,
						'seventy' => 1,
						'eighty' => 1,
						'ninety' => 1,
						'hundred' => 1,
						'thousand' => 1,
						);

	$line = TrimChars($line);

	@line_array = split " ", $line;
	if (scalar (@line_array) > 1) {
	  %line_hash = map {$_, (++$line_hash{$_})}  @line_array;

		$do_repeat_search = 0;
		foreach $elem ( sort { $a cmp $b } keys %line_hash) {
			if (($line_hash{$elem} > 1) && (not defined $repeat_okay_hash{$elem})) {
				$do_repeat_search = 1;
				last;
			}
		}

		if ($do_repeat_search) {
			$line_enter = $line;
			foreach $elem (@line_array) {
				$prev_word = $test_word;
				$test_word = $elem;
				if (($test_word ne $prev_word) || defined $repeat_okay_hash{$test_word}) {

					push @build_array, $test_word;
				}
			}

			if (scalar (@build_array) > 3) {
				while (scalar (@build_array) > 0) {
					if (scalar (@build_array) == 1) {
						$test_word = shift @build_array;
						push @build2_array, $test_word;
						last;
					}
					$prev_word = shift @build_array;
					$prev_two_words = $build_array[0];

					$test_word = $build_array[1];
					$test_prev_two_words = $build_array[2];

					$prev_two_words = $prev_word." ".$prev_two_words;
					$test_prev_two_words = $test_word." ".$test_prev_two_words;

					if ($test_prev_two_words ne $prev_two_words) {
						push @build2_array, $prev_word;
					} else {
						(@temp_array) = split " ", $prev_two_words;
						@build2_array = @temp_array;

						shift @build_array;
						shift @build_array;
						shift @build_array;
					}
				}

				if (scalar (@build2_array) > 5) {
					while (scalar (@build2_array) > 0) {
						if (scalar (@build2_array) == 1) {
							$test_word = shift @build2_array;
							push @build3_array, $test_word;
							last;
						}

						if (scalar (@build2_array) == 2) {
							$test_word = shift @build2_array;
							$test_prev_two_words = shift @build2_array;
							push @build3_array, $test_word, $test_prev_two_words;
							last;
						}

						$prev_word = shift @build2_array;
						$prev_two_words = $build2_array[0];
						$prev_two_words = $prev_word." ".$prev_two_words;
						$prev_three_words = $build2_array[1];

						$test_word = $build2_array[2];
						$test_prev_two_words = $build2_array[3];
						$test_prev_two_words = $test_word." ".$test_prev_two_words;
						$test_prev_three_words = $build2_array[4];

						$prev_three_words = $prev_two_words." ".$prev_three_words;
						$test_prev_three_words = $test_prev_two_words." ".$test_prev_three_words;
						if ($test_prev_three_words ne $prev_three_words) {
							push @build3_array, $prev_word;
						} else {
							(@temp_array) = split " ", $prev_three_words;
							@build3_array = @temp_array;

							shift @build2_array;
							shift @build2_array;
							shift @build2_array;
							shift @build2_array;
							shift @build2_array;
						}
					}

					$line = shift @build3_array;
					foreach $elem (@build3_array) {
						$line = $line." ".$elem;
					}
				} else {
					$line = shift @build2_array;
					foreach $elem (@build2_array) {
						$line = $line." ".$elem;
					}
				}
			} else {
				$line = shift @build_array;
				foreach $elem (@build_array) {
					$line = $line." ".$elem;
				}
			}

			$line_exit = $line;
		}
	}

	return $line;
}

sub ProcessOPTIONALs
{
    my($debug, $output_format, $strval, $startpos) = @_;

	my($retval) = $strval;
	my($loc);
	my($startchar);
	my($endpos);
	my($subitem1);
	my($concat1);
	my($concat2);

	if (lc($output_format) eq "abnf") {
		$retval =~ s/\?/\:/g;

		DebugPrint ("", 1, "ProcessOPTIONALs: $output_format: Entry", $debug-1, $err_no++, "retval=$retval\n\n");

		($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
		while ($loc != -1) {
			$startchar = substr($retval, $loc+1, 1);

			if ($startchar =~ /\[|\(/) {
				$endpos = GetClosure($loc+1, $startchar, $retval, length($retval));
			} else {
				$endpos = $loc + 1;
				while (substr($retval, $endpos, 1) =~ /[A-Za-z0-9]|\$|\@|\_/) {
					$endpos++;
				}
			}

			$subitem1 = substr($retval, $loc+1, $endpos-$loc-1);

			$subitem1 = TrimChars($subitem1);
			$concat1 = ":"."$subitem1";
			$concat1 =~ s/\(/\\\(/g;
			$concat1 =~ s/\)/\\\)/g;
			$concat1 =~ s/\[/\\\[/g;
			$concat1 =~ s/\]/\\\]/g;
			$concat1 =~ s/\$/\\\$/g;
			$concat1 =~ s/\:/\\\:/g;
			$concat1 =~ s/\|/\\\|/g;
			$concat2 = "["."$subitem1]";

			DebugPrint ("", 1, "ProcessOPTIONALs: $output_format: Loop1", $debug-1, $err_no++, "\n\nsubitem1=$subitem1, concat1=$concat1, concat2=$concat2, retval=$retval\n");
			$retval =~ s/$concat1/$concat2/g;

			($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
		}
	}

	if (lc($output_format) eq "xml") {
		$retval =~ s/\?/\:/g;

		DebugPrint ("", 1, "ProcessOPTIONALs: $output_format: Entry", $debug-1, $err_no++, "retval=$retval\n\n");

		($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
		while ($loc != -1) {
			$startchar = substr($retval, $loc+1, 1);

			if ($startchar =~ /\[|\(/) {
				$endpos = GetClosure($loc+1, $startchar, $retval, length($retval));
			} else {
				$endpos = $loc + 1;
				while (substr($retval, $endpos, 1) =~ /[A-Za-z0-9]|\$|\@|\_/) {
					$endpos++;
				}
			}

			$subitem1 = substr($retval, $loc+1, $endpos-$loc-1);

			$subitem1 = TrimChars($subitem1);
			$concat1 = ":"."$subitem1";
			$concat1 =~ s/\\/\\\\/g;
			$concat1 =~ s/\//\\\//g;
			$concat1 =~ s/\(/\\\(/g;
			$concat1 =~ s/\)/\\\)/g;
			$concat1 =~ s/\[/\\\[/g;
			$concat1 =~ s/\]/\\\]/g;
			$concat1 =~ s/\$/\\\$/g;
			$concat1 =~ s/\:/\\\:/g;
			$concat1 =~ s/\|/\\\|/g;
			$concat1 =~ s/\</\\\</g;
			$concat1 =~ s/\>/\\\>/g;
			$concat1 =~ s/\"/\\\"/g;
			$concat1 =~ s/\-/\\\-/g;

			if (substr($concat1, length($concat1)-1) =~ /[a-zA-Z]/) {
				$concat1 = $concat1."\\b";
			}

			$concat2 = "\n\t\t\t<item repeat=\"0\-1\">\n\t\t\t\t"."$subitem1"."\n\n\t\t\t<\/item>\n\n\t\t\t";

			$retval =~ s/$concat1/$concat2/g;

			DebugPrint ("", 1, "ProcessOPTIONALs: ", $debug-1, $err_no++, "concat1=$concat1, concat2=$concat2, retval=$retval\n\n");
			($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
		}

		$retval =~ s/\(//g;
		$retval =~ s/\)\n//g;
		$retval =~ s/\)//g;

	}

#	<item repeat="0-1">
#		services	</item>

	DebugPrint ("", 1, "ProcessOPTIONALs: $output_format: Exit", $debug-1, $err_no++, "retval=$retval\n\n");

	return ($retval);
}

sub ProcessOPTIONALs_SLMDirect
{
    my($debug, $strval, $startpos) = @_;

	my($concat1);
	my($concat2);
	my($endpos);
	my($loc);
	my($retval) = $strval;
	my($startchar);
	my($subitem1);

	$retval =~ s/\?/\:/g;

	DebugPrint ("", 1, "ProcessOPTIONALs_SLMDirect: Entry", $debug-1, $err_no++, "retval=$retval\n\n");

	($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
	while ($loc != -1) {
		$startchar = substr($retval, $loc+1, 1);

		if ($startchar =~ /\[|\(/) {
			$endpos = ThisGetClosure($loc+1, $startchar, $retval, length($retval));
		} else {
			$endpos = $loc + 1;
			while (substr($retval, $endpos, 1) =~ /[A-Za-z0-9]|\$|\@|\_/) {
				$endpos++;
			}
		}

		$subitem1 = substr($retval, $loc+1, $endpos-$loc-1);

		$subitem1 = TrimChars($subitem1);
		$concat1 = ":"."$subitem1";
		$concat1 =~ s/\(/\\\(/g;
		$concat1 =~ s/\)/\\\)/g;
#		$concat1 =~ s/\[/\\\[/g;
#		$concat1 =~ s/\]/\\\]/g;
		$concat1 =~ s/\$/\\\$/g;
		$concat1 =~ s/\:/\\\:/g;
		$concat1 =~ s/\|/\\\|/g;
		$concat1 =~ s/\^/\\\^/g;
#		$concat1 =~ s/\|/\\\|/g;
		$concat2 = "\(\(<NULL>\)\|\("."$subitem1\)\)";

		DebugPrint ("", 1, "ProcessOPTIONALs_SLMDirect: Loop1", $debug-1, $err_no++, "\n\nsubitem1=$subitem1, concat1=$concat1, concat2=$concat2, retval=$retval\n\n\n");
		$retval =~ s/$concat1/$concat2/g;

		($loc, $startchar) = FindFirstChar($startpos, ":", "", "", $retval);
	}

	DebugPrint ("", 1, "ProcessOPTIONALs_SLMDirect: Exit", $debug-1, $err_no++, "retval=$retval\n\n");

	return ($retval);
}

sub ThisGetClosure
{
    my($istartptr, $sopenchar, $teststring, $maxsearchlen) = @_;

	my($ilocstartptr);
	my($openparencnt);
	my($closeparencnt);
	my($sclosechar);
	my($testchar);

	if ($sopenchar eq "[") {
		$sclosechar = "]";
	} elsif ($sopenchar eq "(") {
		$sclosechar = ")";
	} elsif ($sopenchar eq "{") {
		$sclosechar = "}";
	} elsif ($sopenchar eq "<") {
		$sclosechar = ">";
	}

    $ilocstartptr = $istartptr + 1;

    $openparencnt = 1;
    $closeparencnt = 0;

    while (($openparencnt != $closeparencnt) && (($ilocstartptr - $istartptr) < $maxsearchlen)) {
        $testchar = substr($teststring, $ilocstartptr, 1);
		if ($testchar eq $sopenchar) {
            $openparencnt++;
        } else {
            if ($testchar eq $sclosechar) {
                $closeparencnt++;
            }
		}

        $ilocstartptr++;

	}

	if ($openparencnt != $closeparencnt) {
		DebugPrint ("", 1, "ThisGetClosure: openparencnt != closeparencnt", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, ilocstartptr=$ilocstartptr, istartptr=$istartptr, teststring=$teststring, maxsearchlen=$maxsearchlen\n\n");
		$ilocstartptr = -1;
	} else {
		$testchar = substr($teststring, $ilocstartptr, 1);
		DebugPrint ("", 1, "ThisGetClosure: openparencnt = closeparencnt-1", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar\n\n");
		if ($testchar eq "~") {
			while (substr($teststring, $ilocstartptr, 1) =~ /\~|\d|\.|\ /) {
				$ilocstartptr++;
			}

			DebugPrint ("", 1, "ThisGetClosure: openparencnt = closeparencnt-2", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar, ilocstartptr=$ilocstartptr\n\n");
		}
	}

	return $ilocstartptr;
}

sub collapseSentenceWithWordTotals
{
   my($meaning_args, $word_freq_min, $sentence, $category_hash, $removePlus, $removeA) = @_;

   my($elem);
   my($filesize);
   my($loop_cnt);
   my($number_of_sentences);
   my($pre_search_string);
   my($readlen);
   my($total_word_freq);
   my($total_word_freq_line);
   my($total_word_freq_line);
   my($word);
   my($word_freq);
   my($word_freq_line_mean);
   my($word_freq_line_number_of_values);
   my($word_freq_line_percentage);
   my($word_freq_line_percentage_threshold);
   my($word_freq_line_standard_deviation);
   my($word_freq_line_sum_of_deviations);
   my($word_freq_line_threshold);
   my($word_mean);
   my($word_number_of_values);
   my($word_standard_deviation);
   my($word_sum_of_deviations);
   my($word_threshold);
   my($word_threshold_original) = -1;
   my(%word_freq_line_hash);
   my(%word_hash);
   my(@temp_array);

   $number_of_sentences = scalar(split /\º/, $sentence);
   $sentence =~ s/\º/ /g;

   if ($removePlus) {
	 $sentence =~ s/\+/ /g;
   }

   if ($removeA) {
	 $sentence =~ s/\ª//g;
   }

   $sentence = TrimChars($sentence);

   $sentence =~ s/ /\n/g;

   $sentence = $sentence."\n";

   open(COLLAPSE,">"."slmdirect_results/createslmDIR_temp_files/temp_2collapse_sentence_with_word_totals") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_2collapse_sentence_with_word_totals";
   print COLLAPSE "$sentence";
   close(COLLAPSE);

   system("sort slmdirect_results\/createslmDIR_temp_files\/temp_2collapse_sentence_with_word_totals | uniq -c | sort -nr >"."slmdirect_results\/createslmDIR_temp_files\/collapsed_sentence_with_word_totals");

   open(NEWPARSEFILECOMP,"<"."slmdirect_results/createslmDIR_temp_files/collapsed_sentence_with_word_totals") or die "cant open "."slmdirect_results/createslmDIR_temp_files/collapsed_sentence_with_word_totals";
   $filesize = -s NEWPARSEFILECOMP;
   $readlen = sysread NEWPARSEFILECOMP, $pre_search_string, $filesize;
   close (NEWPARSEFILECOMP);

   if ($pre_search_string ne "") {
	 $pre_search_string = ChopChar($pre_search_string);
	 $pre_search_string =~ s/\s+((\d)+) /\n$1\t/g;
	 @temp_array = split /\n/, $pre_search_string;

	 $total_word_freq = 0;
	 $loop_cnt = 0;
	 foreach $elem (@temp_array) {
	   ($word_freq, $word) = split /\t/, $elem;
	   if ($word_freq ne "") {
		 if ($word_freq >= $word_freq_min) {
		   if ($loop_cnt > -1) {
			 $word_freq_line_percentage = $word_freq/$number_of_sentences;
			 $word_freq_line_hash{$word} = $word_freq_line_percentage;
			 $word_hash{$word} = $word_freq;
			 $total_word_freq_line += $word_freq_line_percentage;
			 $total_word_freq += $word_freq;
		   }

		   $loop_cnt++;
		 }
	   }
	 }

	 $word_freq_line_percentage_threshold = 0.9**($number_of_sentences**(1/3));
	 $word_freq_line_number_of_values = scalar(keys %word_freq_line_hash);
	 $word_freq_line_mean = $total_word_freq_line/$word_freq_line_number_of_values;

	 $word_number_of_values = scalar(keys %word_hash);
	 $word_mean = $total_word_freq/$word_number_of_values;

	 $word_sum_of_deviations = 0;
	 $loop_cnt = 0;
	 foreach $elem (@temp_array) {
	   ($word_freq, $word) = split /\t/, $elem;
	   if ($word_freq ne "") {
		 if ($word_freq >= $word_freq_min) {
		   if ($loop_cnt > -1) {
			 $word_freq_line_sum_of_deviations += (($word_freq_line_hash{$word} - $word_freq_line_mean)**2);
			 $word_sum_of_deviations += (($word_hash{$word} - $word_mean)**2);
		   }

		   $loop_cnt++;
		 }
	   }
	 }

	 $word_standard_deviation = sqrt($word_sum_of_deviations/($word_number_of_values-1));
	 $word_freq_line_standard_deviation = sqrt($word_freq_line_sum_of_deviations/($word_freq_line_number_of_values-1));

	 $word_threshold = $word_mean - (1 * $word_standard_deviation);
	 $word_freq_line_threshold = $word_freq_line_mean - (1 * $word_freq_line_standard_deviation);
	 $word_threshold_original = $word_threshold;

	 if ($word_standard_deviation > $word_mean) {
	   $word_threshold = $word_mean - (0.10 * $word_mean);
	 }

	 if (($word_threshold - int($word_threshold)) < 0.5) {
	   $word_threshold = int($word_threshold);
	 } else {
	   $word_threshold = int($word_threshold) + 1;
	 }

	 open(AUTOOUT,">"."slmdirect_results/createslmDIR_temp_files/createslm_temp_assign") or die "cant write "."slmdirect_results/createslm_temp_assign";
	 print AUTOOUT "total_word_freq=$total_word_freq\n\n\n\n";

	 print AUTOOUT "word_sum_of_deviations=$word_sum_of_deviations\n\n";
	 print AUTOOUT "word_number_of_values=$word_number_of_values\n\n";
	 print AUTOOUT "word_mean=$word_mean\n\n";
	 print AUTOOUT "word_standard_deviation=$word_standard_deviation\n\n";
	 print AUTOOUT "word_threshold_original=$word_threshold_original\n\n";
	 print AUTOOUT "word_threshold=$word_threshold\n\n\n\n";

	 print AUTOOUT "word_freq_line_sum_of_deviations=$word_freq_line_sum_of_deviations\n\n";
	 print AUTOOUT "word_freq_line_number_of_values=$word_freq_line_number_of_values\n\n";
	 print AUTOOUT "word_freq_line_mean=$word_freq_line_mean\n\n";
	 print AUTOOUT "word_freq_line_standard_deviation=$word_freq_line_standard_deviation\n\n";
	 print AUTOOUT "word_freq_line_threshold=$word_freq_line_threshold\n\n";
	 print AUTOOUT "word_freq_line_percentage_threshold=$word_freq_line_percentage_threshold\n\n\n\n";


	 foreach $elem (@temp_array) {
	   ($word_freq, $word) = split /\t/, $elem;
	   if ($word_freq ne "") {
		 if (($word_freq >= $word_freq_min) && ($word_freq >= $word_threshold)) {
#			 print "herettt222d1: word=$word, word_freq=$word_freq\n";

#			 print ">>>>>herettt222d2: actual word percentage=", $word_freq/$total_word_freq, ", word_average=$word_mean\n\n";
		   $word_freq_line_percentage = $word_freq/$number_of_sentences;
		   print AUTOOUT "word=$word, word_freq=$word_freq, word_freq_line_percentage=$word_freq_line_percentage, word_threshold=$word_threshold, word_freq_line_threshold=$word_freq_line_threshold, word_freq_line_percentage_threshold=$word_freq_line_percentage_threshold\n\n";
		   $$category_hash{$word} = $word_freq;
		 } else {
		   print AUTOOUT "BELOW THRESHOLD: word=$word, word_freq=$word_freq, word_freq_line_percentage=$word_freq_line_percentage, word_threshold=$word_threshold, word_freq_line_threshold=$word_freq_line_threshold, word_freq_line_percentage_threshold=$word_freq_line_percentage_threshold\n\n";
		 }
	   }
	 }

	 close(AUTOOUT);

   }
}

sub collapseSentence
{
   my($sentence, $unique_array, $removePlus, $removeA) = @_;

   my($filesize);
   my($pre_search_string);
   my($readlen);

   $sentence =~ s/\º/ /g;
   if ($removePlus) {
	 $sentence =~ s/\+/ /g;
   }

   if ($removeA) {
	 $sentence =~ s/\ª//g;
   }

   $sentence = TrimChars($sentence);

   $sentence =~ s/ /\n/g;

   $sentence = $sentence."\n";

   open(COLLAPSE,">"."slmdirect_results/createslmDIR_temp_files/temp_2collapse_sentence") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_2collapse_sentence";
   print COLLAPSE "$sentence";
   close(COLLAPSE);

   system("sort -u "."slmdirect_results/createslmDIR_temp_files/temp_2collapse_sentence>"."slmdirect_results/createslmDIR_temp_files/temp_collapsed_sentence");

   open(COLLAPSE,"slmdirect_results/createslmDIR_temp_files/temp_collapsed_sentence") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_collapsed_sentence";
   $filesize = -s COLLAPSE;
   $readlen = sysread COLLAPSE, $pre_search_string, $filesize;
   close (COLLAPSE);

   $pre_search_string = ChopChar($pre_search_string);

   $pre_search_string =~ s/$char13\n/ /g;
   $pre_search_string =~ s/$char13/ /g;
   $pre_search_string =~ s/\n/ /g;
   $pre_search_string =~ tr/ / /s;

   @$unique_array = split " ", $pre_search_string;
}

sub FillGoodFragmentHash
{
	my($sentence, $good_fragment_list_hash, $keep_fragment_length) = @_;

	my($elem);

	my(@good_fragment_list_array);

	if ($keep_fragment_length > 0) {
		collapseSentence($sentence, \@good_fragment_list_array, 0, 0);

		foreach $elem (@good_fragment_list_array) {
			if (($elem !~ /\_|\-|\[|\]|\(|\)|\@/)) {
				if (length($elem) >= $keep_fragment_length) {
					$elem =~ s/\*/ /g;
					$elem = TrimChars($elem);
					$$good_fragment_list_hash{$elem}++;
				}
			}
		}
	}
}

sub fisher_yates_shuffle
{
   my($array) = @_;

   my($i);

   for ($i = @$array; --$i;) {
	   my ($j) = int rand ($i+1);
	   next if $i == $j;
	   @$array[$i, $j] = @$array[$j, $i];
   }

}

sub MakeCompressedAliasSentence
{
   my($general_args, $meaning_args, $sentence, $compressed_already_alias_hash) = @_;

   my($elem0);
   my($temp1);
   my($compressed_alias_sentence);

   if (defined $$compressed_already_alias_hash{$sentence}) {
	 $compressed_alias_sentence = $$compressed_already_alias_hash{$sentence};
   } else {
	 $compressed_alias_sentence = $sentence;
	 if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
	   foreach $elem0 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_search"}}) {
		 $temp1 = $$meaning_args{"alias_search"}{$elem0};
		 $compressed_alias_sentence =~ s/\b$temp1\b/\^$elem0/g;
	   }
	 }

	 if ($$general_args{"main_language"} eq "es-us") {
	   foreach $elem0 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_search_esus"}}) {
		 $temp1 = $$meaning_args{"alias_search"}{$elem0};
		 $compressed_alias_sentence =~ s/\b$temp1\b/\^$elem0/g;
	   }
	 }

	 $$compressed_already_alias_hash{$sentence} = $compressed_alias_sentence;
   }

   return ($compressed_alias_sentence);
}

sub GetResidualString
{
   my($search_string, $used_sentence_num_hash, $sentence_corpus_limits_array) = @_;

   my($residual_search_string) = "";
   my($elem);
   my($current_sentence);
   my($prev_loc) = 0;
   my($sent_begin);
   my($sent_end);

   foreach $elem ( sort { $a <=> $b } keys %{$used_sentence_num_hash}) {
	   ($current_sentence, $sent_begin, $sent_end) = split ":", $$sentence_corpus_limits_array[$elem];
	   if ($prev_loc == 0) {
		   $residual_search_string = substr($search_string, 0, $sent_begin-1);
	   } else {
		   $residual_search_string = $residual_search_string.substr($search_string, $prev_loc+1, $sent_begin-$prev_loc);
	   }

	   $prev_loc = $sent_end;
   }

   return ($residual_search_string);
}

sub FillSearchString
{
   my($general_args, $cleaning_args, $mode, $already_clean, $catfilein, $original_transcription_array, $cat_order_array, $vanilla_cat_array, $write_array, $pre_search_array, $pseudo_pre_search_array) = @_;


   my($filename);
   my($first_stage_done) = 0;
   my($firstchar);
   my($item_category);
   my($label);
   my($line);
   my($orig_sentence);
   my($pre_search_string) = "";
   my($sentence_order) = 0;

   @$original_transcription_array = ();
   @$cat_order_array = ();
   @$vanilla_cat_array = ();
   @$write_array = ();
   @$pre_search_array = ();
   @$pseudo_pre_search_array = ();

   open(CATFILEIN,"<$catfilein") or die "cant open $catfilein";
   while(<CATFILEIN>) {
	   $line = ChopChar($_);
	   $line = TrimChars($line);
	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   if (($mode eq "KNOWN CATEGORIES") || ($mode eq "RECLASSIFICATION")) {
		   ($label, $orig_sentence, $item_category) = split "\t", $line;
	   } else {
		   ($filename, $orig_sentence, $item_category) = split "\t", $line;
	   }

#	   $$vanilla_cat_array[$sentence_order] = $item_category;
	   $item_category = NormCat($item_category, $$general_args{"test_reject_name"});

	   if (lc($item_category) eq "null") {
		   $item_category = $$general_args{"test_reject_name"};
	   }

	   @$write_array[$sentence_order] = 1;
	   @$cat_order_array[$sentence_order] = $item_category;
	   @$original_transcription_array[$sentence_order] = $orig_sentence;
	   $pre_search_string = storeLocationInfo($orig_sentence, $pre_search_string, $sentence_order);
	   $sentence_order++;
   }

   close(CATFILEIN);

  if ($$general_args{"downcase_utt"}) {
	   $pre_search_string = lc($pre_search_string);
   }

   $pre_search_string =~ s/\./ /g;
   $pre_search_string =~ s/\,/ /g;
   $pre_search_string =~ s/\?//g;
   $pre_search_string =~ s/\'\'/\'/g;
   $pre_search_string =~ s/ \//\//g;
   $pre_search_string =~ s/\/ /\//g;

   ($pre_search_string, $firstchar) = ProcessCharsPlus($pre_search_string);

   $pre_search_string = MakeCleanTrans($general_args, $cleaning_args, $first_stage_done, 0, 1, $already_clean, "", $pre_search_string);

   @$pre_search_array = split /\º/, $pre_search_string;
}

sub putItemInfo
{
    my($in_hash, $in_focus_hash, $elem, $return_array, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = @_;

	@$return_array[0] = $item_id;

	$$in_hash{$elem} = $test_item.":".$item_category.":".$item_id.":".$confirmed_as.":".$first_loc.":".$rep_utt.":".$vanilla_rep_utt.":".$first_loc.":".$last_loc;
	$$in_focus_hash{$elem} = [ @$return_array ];
}

sub getItemInfo
{
    my($in_hash, $in_focus_hash, $elem, $return_array) = @_;

	my($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);

	($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $first_loc, $last_loc) = split ":", $$in_hash{$elem};

	foreach (@{$$in_focus_hash{$elem}}) {
		push (@$return_array, $_);
	}

	return ($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);
}

sub makeTrainingFileArray
{
    my($mode, $string, $return_hash) = @_;

	my(@temp_array);
	my($temp_string);
	my($param_string);
	my($param_value);

	makeArrayDirectfromString($string, \@temp_array);
	foreach $temp_string (@temp_array) {
		($param_string, $param_value) = split /\=/, $temp_string;

		$$return_hash{$mode}{$param_string} = $param_value;
	}
}

sub makeClassGrammars
{
  my($main_language, $grammar_type, $grammarbase, $string, $class_grammar_hash, $dont_do_additional_command_vars) = @_;

  my($elem);
  my($elem1);
  my($elem2);
  my($elem3);
  my($encoding) = setEncoding($main_language);
  my($temp_elem);
  my($temp_elem1);
  my($temp_string);
  my($make_classgrammar);
  my($nl_type);
  my(@cat_array);
  my($current_item);
  my(@grammar_items);
  my(@class_grammar_items_array);
  my($build_string);
  my($possible_slot_val);
  my(@possible_slot_val_array);
  my(@uniq_possible_slot_val_array);
  my(%possible_slot_val_hash);
  my(@do_temp_array);
  #CG,&names.txt:DB1300_Employee_Name.grxml;root;phone;DATA,&iwantto.txt:IWantTo,&speakto.txt:SpeakTo
  makeArrayfromString("nonrules", $string, ",", \@class_grammar_items_array);
  foreach $elem (@class_grammar_items_array) {
	if ($elem eq "CG") {
	  next;
	}

	$elem =~ s/\?/\ª/g;
	$elem=~ s/([a-z])\:(\\|\/)/$1\º$2/g;

	if ($elem =~ /\&/) {
	  ($nl_type, $temp_string) = split ":", $elem;

	  $nl_type =~ s/\&//g;

	  $nl_type = ChopChar($nl_type);
	  $temp_string = ChopChar($temp_string);
	  open(TEMPREAD,"<$nl_type")|| die "cant open $nl_type";
	  while (<TEMPREAD>) {
		$elem1 = ChopChar($_);

		if (substr($elem1,0,1) ne "#") {
		  $$class_grammar_hash{$temp_string}{$elem1}++;
		}
	  }

	  close (TEMPREAD);
	} else {
	  ($temp_string, @do_temp_array) = split ":", $elem;
	  $temp_string = ChopChar($temp_string);
	  foreach $elem1 (@do_temp_array) {
		$elem1 = ChopChar($elem1);
		$$class_grammar_hash{$temp_string}{$elem1}++;
	  }
	}
  }

  @class_grammar_items_array = ();
  $make_classgrammar = 0;
  if ($grammar_type ne "") {
	$make_classgrammar = 1;
  }

  if ($dont_do_additional_command_vars) {
	$make_classgrammar = 0;
  }

  if ($make_classgrammar) {
	foreach $elem ( sort { $a cmp $b } keys %{$class_grammar_hash}) {
	  if (index ($elem, "+") == -1) {
		if (index ($elem, "=") != -1) {
		  (@cat_array) = split "=", $elem;
		  $temp_elem = $cat_array[0];
		} else {
			$temp_elem = $elem;
		  }
#:encoding(utf-8)
		if ((scalar keys %{$$class_grammar_hash{$elem}}) > 0) {
		  $temp_elem1 = $temp_elem;
		  $temp_elem1 =~ s/\ª//g;
		  if ($grammar_type eq "NUANCE_GSL") {
			open(CLASSGRAMMAR,">", "slmdirect_results\/$grammarbase"."_nuance_gsl_".lc($temp_elem1).".grammar") or die "cant write CLASSGRAMMAR";

			print CLASSGRAMMAR uc($temp_elem1), " [\n";
		  }

		  if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
#hereqaz111: indent candidate
			open(CLASSGRAMMAR_SF,">".getOutEncoding($main_language, $grammar_type), "slmdirect_results\/$grammarbase"."_".lc($grammar_type)."_".lc($temp_elem1).".grxml") or die "cant write CLASSGRAMMAR";

			print CLASSGRAMMAR_SF "<\?xml version=\"1.0\" encoding=\"$encoding\" \?>\n<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n\txml:lang=\"$main_language\" mode=\"voice\" root=\"ROOT\">\n\n";

			print CLASSGRAMMAR_SF "\t<meta name=\"swirec_normalize_to_probabilities\" content=\"1\"/>\n";

			print CLASSGRAMMAR_SF "\t<rule id=\"ROOT\" scope=\"public\">\n\t\t<item>\n\t\t\t<ruleref uri=\"#$temp_elem1\"/>\n\t\t\t<tag>".uc($temp_elem1)."=$temp_elem1.".uc($temp_elem1)."</tag>\n\t\t<\/item>\n\t</rule>\n\n";

			print CLASSGRAMMAR_SF "<rule id=\"$temp_elem1\">\n<one-of>\n";
		  }
		}

		foreach $elem1 ( sort { $a cmp $b } keys %{$$class_grammar_hash{$elem}}) {
		  $current_item = $elem1;

		  $possible_slot_val = $elem1;
		  $possible_slot_val =~ s/ and /\~and\~/g;
		  $possible_slot_val =~ s/ /\@/g;
		  $possible_slot_val =~ s/\(|\)|\|/ /g;
		  $possible_slot_val =~ s/ \@ / /g;
		  $possible_slot_val = TrimChars($possible_slot_val);

		  $possible_slot_val =~ s/_//g;
		  $possible_slot_val =~ s/\'//g;
		  $possible_slot_val =~ s/\@//g;
		  $possible_slot_val =~ s/\\b//g;
		  $possible_slot_val =~ s/\\s\*//g;
		  $possible_slot_val =~ s/\+//g;
		  (@possible_slot_val_array) = split " ", $possible_slot_val;

		  $possible_slot_val = "";

		  foreach $elem2 (@possible_slot_val_array) {
			if (not defined $possible_slot_val_hash{$elem2}) {
			  push(@uniq_possible_slot_val_array, $elem2);
			}

			$possible_slot_val_hash{$elem2}++;
		  }

		  $possible_slot_val = join " ", @uniq_possible_slot_val_array;

		  undef %possible_slot_val_hash;
		  @possible_slot_val_array = ();
		  @uniq_possible_slot_val_array = ();

		  $possible_slot_val = TrimChars($possible_slot_val);
		  $possible_slot_val =~ s/\~/_/g;
		  $possible_slot_val =~ s/ /_/g;
		  $possible_slot_val =~ tr/_/_/s;

		  while ($current_item ne "") {
			$current_item = FindEnclosure($possible_slot_val, $temp_elem, $grammar_type, $current_item, \@grammar_items, \@class_grammar_items_array);
		  }

		  $build_string = join ":", @class_grammar_items_array;

		  $build_string =~ s/\\b//g;
		  $build_string =~ s/\\s\*//g;
		  $build_string =~ s/\+//g;
		  (@class_grammar_items_array) = split ":", $build_string;

		  if ($grammar_type eq "NUANCE_GSL") {
			foreach $elem3 (@class_grammar_items_array) {
			  $elem3 =~ s/\ª//g;
			  print CLASSGRAMMAR "$elem3\n";
			}
		  }

		  if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
			foreach $elem3 (@class_grammar_items_array) {
			  $elem3 =~ s/\ª//g;
			  print CLASSGRAMMAR_SF "$elem3\n";
			}
		  }

		  @class_grammar_items_array = ();
		}

		if ((scalar keys %{$$class_grammar_hash{$elem}}) > 0) {
		  if ($grammar_type eq "NUANCE_GSL") {
			print CLASSGRAMMAR "]\n\n";
		  }

		  if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
			print CLASSGRAMMAR_SF "<\/one-of>\n<\/rule>\n\n";
			print CLASSGRAMMAR_SF "<\/grammar>\n";
		  }
		}

		close(CLASSGRAMMAR);
		close(CLASSGRAMMAR_SF);
	  }
	}
  }
}

sub makeAliasExclusion
{
    my($string, $return_hash) = @_;

	my($elem);
	my($elem1);
	my($newmod);
	my($oldmod);
	my(@temp_array);
	my(@temp_1_array);

	makeArrayDirectfromString($string, \@temp_array);
	foreach $elem (@temp_array) {
		($oldmod, $newmod) = split /\!/, $elem;

		(@temp_1_array) = split /\|/, $oldmod;

		foreach $elem1 (@temp_1_array) {
			$$return_hash{$elem1}{$newmod}++;
		}
	}
}

sub makeArrayfromString
{
    my($mode, $string, $split_char, $return_array) = @_;

	my($nl_type);
	my($found) = 0;

	if ($mode eq "rules") {
		if (substr($string, length($string)-1) eq ",") {
			$string = substr($string, 0, length($string)-1);
			$found = 1;
		}

		($nl_type,$string) = split ",", $string;

		if ($found) {
			$string = $string.",";
		}
	}

	if ($split_char eq "+") {
		$split_char = quotemeta($split_char);
	}

	@$return_array = split "$split_char", $string;
}

sub makeArrayDirectfromString
{
    my($string, $return_array) = @_;

	my($nl_type);

	($nl_type,@$return_array) = split ",", $string;
}

sub makeStringDirectfromString
{
    my($string) = @_;

	my($return_string);
	my($nl_type);

	($nl_type, $return_string) = split ",", $string;

	return ($return_string);
}

sub makeHashfromString
{
    my($string, $return_hash) = @_;

	my($elem);
	my($nl_type);
	my(@temp_array);

	($nl_type,@temp_array) = split ",", $string;

	foreach $elem (@temp_array) {

#		$elem = ChopChar($elem);

		$$return_hash{$elem}++;
	}
}

sub makeHeavyHashfromString
{
    my($string, $return_hash) = @_;

	my($category);
	my($elem);
	my($nl_type);
	my($word_string);
	my(@temp_array);

	($nl_type, @temp_array) = split ",", $string;

	foreach $elem (@temp_array) {
	  $elem = ChopChar($elem);
	  $elem =~ s/( \:|\: )/\:/g;
	  ($category, $word_string) = split ":", $elem;

	  if ($word_string ne "") {
		$$return_hash{$category} = $word_string;
	  }
	}
}

sub makePOSHashfromString
{
    my($string, $return_hash) = @_;

	my($elem);
	my($elem1);
	my($nl_type);
	my($pos);
	my(@pos_array);
	my(@temp_array);

	($nl_type,@temp_array) = split ",", $string;

	foreach $elem (@temp_array) {
		($pos, @pos_array) = split ":", $elem;

		if ($pos eq "n") {
			$pos = "noun";
		} elsif ($pos eq "v") {
			$pos = "verb";
		} elsif ($pos eq "a") {
			$pos = "adjective";
		}

		foreach $elem1 (@pos_array) {
			$elem1 = ChopChar($elem1);
			$$return_hash{$elem1} = $pos;
		}
	}
}

sub makeSynonymHashfromString
{
    my($string, $alt_syn_default_pos_hash, $return_hash) = @_;

	my($elem);
	my($elem1);
	my($elem2);
	my($nl_type);
	my($pos);
	my(@syn_array);
	my(@temp_array);

	($nl_type,@temp_array) = split ",", $string;

	foreach $elem (@temp_array) {
		($pos, @syn_array) = split ":", $elem;

		if ($pos eq "n") {
			$pos = "noun";
		} elsif ($pos eq "v") {
			$pos = "verb";
		} elsif ($pos eq "a") {
			$pos = "adjective";
		}

		foreach $elem1 ( sort { $a cmp $b } keys %{$$return_hash{$pos}}) {
			push @syn_array, $elem1;
			foreach $elem2 ( sort { $a cmp $b } keys %{$$return_hash{$pos}{$elem1}}) {
				if ($elem1 ne $elem2) {
					push @syn_array, $elem2;
				}
			}
		}

		foreach $elem1 (@syn_array) {
			$elem1 = ChopChar($elem1);
			$$alt_syn_default_pos_hash{$elem1} = $pos;
			foreach $elem2 (@syn_array) {
				$elem2 = ChopChar($elem2);
				if ($elem1 ne $elem2) {
					if (not defined $$return_hash{$pos}{$elem1}{$elem2}) {
						$$return_hash{$pos}{$elem1}{$elem2}++;
					}
				}
			}
		}
	}
}

sub setRuleWordHash
{
    my($combo, $return_hash) = @_;

	my($temp_words) = $combo;
	my(@temp_words_array);

	$temp_words =~ s/\\s\+\(\\w\*\\s\*\)\*/ /g;
	$temp_words =~ s/_(\d+)FILLER(\d+)_/ /g;
	$temp_words =~ s/_FILLER(\d+)_/ /g;
	$temp_words =~ s/_(\d+)FILLER_/ /g;
	$temp_words =~ s/_FILLER_/ /g;
	$temp_words =~ s/\\b/ /g;
	$temp_words =~ s/\(/ /g;
	$temp_words =~ s/\)/ /g;
	$temp_words =~ s/\|/ /g;
	$temp_words =~ s/\_/ /g;
	$temp_words =~ s/\-/ /g;
	$temp_words =~ s/\bone\b/ /g;
	$temp_words =~ s/\btwo\b/ /g;
	$temp_words =~ s/\bthree\b/ /g;
	$temp_words =~ s/\bfour\b/ /g;
	$temp_words =~ s/\bfive\b/ /g;
	$temp_words =~ s/\bsix\b/ /g;
	$temp_words =~ s/\bseven\b/ /g;
	$temp_words =~ s/\beight\b/ /g;
	$temp_words =~ s/\bnine\b/ /g;
	$temp_words =~ s/\bten\b/ /g;
	$temp_words =~ s/\beleven\b/ /g;
	$temp_words =~ s/\btwelve\b/ /g;
	$temp_words =~ s/\bthirteen\b/ /g;
	$temp_words =~ s/\bfourteen\b/ /g;
	$temp_words =~ s/\bfifteen\b/ /g;
	$temp_words =~ s/\bsixteen\b/ /g;
	$temp_words =~ s/\bseventeen\b/ /g;
	$temp_words =~ s/\beighteen\b/ /g;
	$temp_words =~ s/\bnineteen\b/ /g;
	$temp_words =~ s/\btwenty\b/ /g;
	$temp_words =~ s/\bthirty\b/ /g;
	$temp_words =~ s/\bforty\b/ /g;
	$temp_words =~ s/\bfifty\b/ /g;
	$temp_words =~ s/\bsixty\b/ /g;
	$temp_words =~ s/\bseventy\b/ /g;
	$temp_words =~ s/\beighty\b/ /g;
	$temp_words =~ s/\bninety\b/ /g;
	$temp_words =~ s/\bhundred\b/ /g;
	$temp_words =~ s/\bthousand\b/ /g;
	$temp_words =~ s/\b0\b/ /g;
	$temp_words =~ s/\b1\b/ /g;
	$temp_words =~ s/\b2\b/ /g;
	$temp_words =~ s/\b3\b/ /g;
	$temp_words =~ s/\b4\b/ /g;
	$temp_words =~ s/\b5\b/ /g;
	$temp_words =~ s/\b6\b/ /g;
	$temp_words =~ s/\b7\b/ /g;
	$temp_words =~ s/\b8\b/ /g;
	$temp_words =~ s/\b9\b/ /g;
	$temp_words =~ s/\b10\b/ /g;
	$temp_words =~ s/\ba\b/ /g;
	$temp_words =~ s/\bb\b/ /g;
	$temp_words =~ s/\bc\b/ /g;
	$temp_words =~ s/\bd\b/ /g;
	$temp_words =~ s/\be\b/ /g;
	$temp_words =~ s/\bf\b/ /g;
	$temp_words =~ s/\bg\b/ /g;
	$temp_words =~ s/\bh\b/ /g;
	$temp_words =~ s/\bi\b/ /g;
	$temp_words =~ s/\bj\b/ /g;
	$temp_words =~ s/\bk\b/ /g;
	$temp_words =~ s/\bl\b/ /g;
	$temp_words =~ s/\bm\b/ /g;
	$temp_words =~ s/\bn\b/ /g;
	$temp_words =~ s/\bo\b/ /g;
	$temp_words =~ s/\bp\b/ /g;
	$temp_words =~ s/\bq\b/ /g;
	$temp_words =~ s/\br\b/ /g;
	$temp_words =~ s/\bs\b/ /g;
	$temp_words =~ s/\bt\b/ /g;
	$temp_words =~ s/\bu\b/ /g;
	$temp_words =~ s/\bv\b/ /g;
	$temp_words =~ s/\bw\b/ /g;
	$temp_words =~ s/\bx\b/ /g;
	$temp_words =~ s/\by\b/ /g;
	$temp_words =~ s/\bz\b/ /g;
	$temp_words =~ s/\bthe\b/ /g;
	$temp_words =~ s/\bwith\b/ /g;
	$temp_words =~ s/\band\b/ /g;
	$temp_words =~ s/\bfor\b/ /g;
	$temp_words =~ s/\bmy\b/ /g;
	$temp_words =~ s/\byour\b/ /g;
	$temp_words =~ s/\bour\b/ /g;
	$temp_words =~ s/\bhis\b/ /g;
	$temp_words =~ s/\bher\b/ /g;
	$temp_words =~ s/\bby\b/ /g;

	$temp_words = TrimChars($temp_words);

	(@temp_words_array) = split " ", $temp_words;

	foreach (@temp_words_array) {
		$$return_hash{$_}++;
	}
}

sub stringToVocab
{
    my($source, $string, $return_hash) = @_;

	my($elem);
	my(@temp_array);

	$string =~ s/\+/ /g;

	makeArrayfromString("rules", $string, " ", \@temp_array);

	foreach $elem (@temp_array) {
		PutInVocab($source, 1, $return_hash, $elem);
	}
}

sub hpush(\%@)
{
	my $href = shift;

	while ( my ($k, $v) = splice(@_,0 ,2)) {
		$href->($k) = $v;
	}
}

sub SetConfirm_As
{
  my($item_category) = @_;

  my($confirm_as);

  if ($item_category =~ /\./) {
	($item_category, $confirm_as) = split /\./, $item_category;
  } else {
	$confirm_as = $item_category;
  }

  return ($item_category, $confirm_as);
}

# hpush (%piece, "queen" => 9, "rook" => 5)

############# END GENERAL UTILITIES AND SUBROUTINES ##################

######################################################################
######################################################################
################# SLMDIRECT-SPECIFIC SUBROUTINES ######################
######################################################################
######################################################################

######################################################################
######################################################################
############# SLMDirect Utility SUBROUTINES ###########################
######################################################################
######################################################################

sub RemoveChar {

    my($my_char, $my_elem) = @_;

	my($my_temp_elem);

	$my_temp_elem = $my_elem;
	if ($my_temp_elem =~ /(.*?(\w+_disk|\w+_inch|\w+_millimeter))/) {
		$my_temp_elem =~ s/$my_char/ /g;
	}

	return $my_temp_elem;
}

sub ReplaceMy {

    my($main_language, $rep_string, $build_string) = @_;

	my($replen) = length($rep_string);
	my($rep_string_minus);

	$rep_string_minus = $rep_string;
	$rep_string_minus =~ s/ //g;

	if ($build_string =~ /\b$rep_string_minus\b/) {
		if (length($build_string) > $replen && substr($build_string, length($build_string)-$replen) eq $rep_string) {
			$build_string = substr($build_string, 0, length($build_string) - $replen);
		}

		if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
			$build_string =~ s/\b$rep_string_minus\b/ ?MY/g;
		} elsif ($main_language eq "es-us") {
			$build_string =~ s/\b$rep_string_minus\b/ ?MI/g;
		}
	}

	return ($build_string);
}

sub catdefOrder
{
   my($item) = @_;

   my($autocat);
   my($compressed_word_num);
   my($temp_compressed_sentence);
   my($words);

   ($autocat, $words) = split /\º/, $item;
   $temp_compressed_sentence = $words;
   $temp_compressed_sentence =~ s/ //g;
   $compressed_word_num = length($words) - length($temp_compressed_sentence) + 1;

   return ($compressed_word_num);

}

sub setEncoding
{
   my($main_language) = @_;

   my($encoding) = "ISO-8859-1";

# ATTENTION
#   if ($grammar_type ne "NUANCE_GSL") {
#	   if (($main_language eq "es-us")) {
#		   $encoding = "UTF-8";
#	   }
#   }

   return ($encoding);

}

sub getOutEncoding
{
   my($main_language, $grammar_type) = @_;

   my($encoding) = "";

# ATTENTION
#   if ($grammar_type ne "NUANCE_GSL") {
#	   if (($main_language eq "es-us")) {
#		   $encoding = ":encoding(UTF-8)";
#	   }
#   }

   return ($encoding);

}

sub checkMultiParseVariables
{
   my($parse_variable) = @_;

   my($return_val) = 0;

   if (($parse_variable eq "\$") || ($parse_variable eq "^") || ($parse_variable eq "%") || ($parse_variable eq "+") || ($parse_variable eq "?") || ($parse_variable eq "MR") || ($parse_variable eq "BR") || ($parse_variable eq "ER") || ($parse_variable eq "GR") || ($parse_variable eq "AR")) {
	   $return_val = 1;
   }

   return ($return_val);
}

sub checkSpecialParseVariables
{
   my($parse_variable) = @_;

   my($return_val) = 0;

   if (($parse_variable eq "CG") || ($parse_variable eq "CS") || ($parse_variable eq "WG") || ($parse_variable eq "FS") || ($parse_variable eq "FV") || ($parse_variable eq "FN") || ($parse_variable eq "ESFS") || ($parse_variable eq "ESFV") || ($parse_variable eq "ESFN")) {
	   $return_val = 1;
   }

   return ($return_val);
}

sub setConnector
{
   my($parse_variable) = @_;

   my($connector) = " ";

   if (($parse_variable eq "CG") || ($parse_variable eq "CS") || ($parse_variable eq "WG")) {
	   $connector = ",";
   }

   return ($connector);
}

sub MaskEscChars
{
    my($elem) = @_;

	$elem =~ s/\'(?!s)/\_\_\_/g;
	$elem =~ s/\@/\_\_\_\_/g;

    return $elem;
}

sub RestoreEscChars
{
    my($elem) = @_;

	$elem =~ s/\_\_\_\_/\@/g;
	$elem =~ s/\_\_\_/\'/g;

    return $elem;
}

sub NormalizeFilename
{
  my($filename) = @_;

  $filename =~ s/\.\\//g;
  $filename =~ s/\\/\//g;

  if (substr($filename,0,1) eq "/") {
	$filename = substr($filename,1);
  }

  return ($filename);
}

sub SimpleReplaceMy {

    my($main_language, $line) = @_;

	if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
		$line =~ s/\bmy\b/?MY/g;
		$line =~ s/\ba\b/?MY/g;
		$line =~ s/\ban\b/?MY/g;
		$line =~ s/\bthe\b/?MY/g;
		$line =~ s/\bhis\b/?MY/g;
		$line =~ s/\bher\b/?MY/g;
		$line =~ s/\bour\b/?MY/g;
		$line =~ s/\byour\b/?MY/g;
	} elsif ($main_language eq "es-us") {
		$line =~ s/\bmis\b/?MI/g;
		$line =~ s/\bmi\b/?MI/g;
		$line =~ s/\btus\b/?MI/g;
		$line =~ s/\btu\b/?MI/g;
		$line =~ s/\buna\b/?MI/g;
		$line =~ s/\bun\b/?MI/g;
		$line =~ s/\bla\b/?MI/g;
		$line =~ s/\bel\b/?MI/g;
		$line =~ s/\blas\b/?MI/g;
		$line =~ s/\blos\b/?MI/g;
		$line =~ s/\bsu\b/?MI/g;
		$line =~ s/\bsus\b/?MI/g;
		$line =~ s/\bnuestra\b/?MI/g;
		$line =~ s/\bnuestro\b/?MI/g;
		$line =~ s/\bnuestras\b/?MI/g;
		$line =~ s/\bnuestros\b/?MI/g;
		$line =~ s/\bvuestra\b/?MI/g;
		$line =~ s/\bvuestro\b/?MI/g;
		$line =~ s/\bvuestras\b/?MI/g;
		$line =~ s/\bvuestros\b/?MI/g;
	}

	return($line);
}

sub	PotentialUnderscoredWord {
    my($line, $word_hash) = @_;

	my($build_string) = "";
	my($result_string) = "";
	my($elem1);
	my($look_active) = 0;
	my($stop_look);
	my(@temp_word_array);

	@temp_word_array = split " ", $line;

	foreach $elem1 (@temp_word_array) {
		if ($elem1 eq "") {
			next;
		}

		if ($elem1 !~ /[a-zA-Z]/) {
			next;
		}

		if (index($elem1, "/") != -1) {
			if ($elem1 eq "/") {
				next;
			}
		}

		if (length($elem1) == 1) {
			$look_active = 1;
			$stop_look = 0;
		} else {
			if ($look_active) {
				$stop_look = 1;
			}

			$look_active = 0;
		}

		if ($look_active) {
		  $build_string = stringBuilder($build_string, $elem1, " ");
		}

		if ($stop_look) {
			$stop_look = 0;
			if (index($build_string, " ") != -1) {
				$result_string = $build_string;
				$result_string =~ s/ /_/g;
				$result_string = $build_string."+".$result_string;
				$$word_hash{$result_string}++;
			}

			$build_string = "";
		}
	}

	if ($build_string ne "") {
		if (index($build_string, " ") != -1) {
			$result_string = $build_string;
			$result_string =~ s/ /_/g;
			$result_string = $build_string."+".$result_string;
			$$word_hash{$result_string}++;
		}
	}
}

sub GenReducedCorpus
{
   my($parsefile, $test_sequence) = @_;

   my($filesize);
   my($i);
   my($pre_search_string);
   my($readlen);
   my($temp_blank_test_percent);
   my($num_lines);
   my(@line_array);

   open(COLLAPSE,"$parsefile") or die "cant open $parsefile";
   $filesize = -s COLLAPSE;
   $readlen = sysread COLLAPSE, $pre_search_string, $filesize;
   close (COLLAPSE);

   $pre_search_string = ChopChar($pre_search_string);

   $pre_search_string =~ s/$char13\n/\º/g;
   $pre_search_string =~ s/$char13/\º/g;
   $pre_search_string =~ s/\n/\º/g;
   $pre_search_string =~ tr/º/º/s;

   @line_array = split /\º/, $pre_search_string;

   ($test_sequence, $num_lines, $temp_blank_test_percent) = split ":", $test_sequence;

   if ($test_sequence ne "random") {
	 $test_sequence = "original order";
   }

   if ($num_lines eq "") {
	 $num_lines = 5000;
   }

   if ($temp_blank_test_percent eq "") {
	 $temp_blank_test_percent = 0;
   }

   if ($test_sequence eq "random") {
	 fisher_yates_shuffle(\@line_array);
   }

   if ($num_lines > scalar(@line_array)) {
	 $num_lines = scalar(@line_array);
   }

   open(KEYOUT,">$parsefile".".$num_lines") or die "cant write $parsefile".".$num_lines";

   for ($i = 0; $i < $num_lines; $i++) {
	 print KEYOUT $line_array[$i], "\n";
   }

   close(KEYOUT);

   DebugPrint ("BOTH", 1, "GenReducedCorpus", $debug, $err_no++, "Created $parsefile".".$num_lines with $num_lines $test_sequence lines");
}

sub createBackup_hold
{
   my($parsefile) = @_;

   my($dir) = "slmdirect_results\/createslmDIR_backup_files";
   my($result) = 1;
   my($target) = "slmdirect_results\/$parsefile"."*.bak";
   my(@backup_array);

   return ($result);
}

sub createBackup
{
   my($parsefile) = @_;

   my($backup_filename);
   my($backup_sequence_filename);
   my($combo);
   my($dir) = "slmdirect_results\/createslmDIR_backup_files";
   my($result) = 1;
   my($target) = "$parsefile"."*.bak";
   my(@backup_array);

   $backup_sequence_filename = "$dir\/bakseq";
   (@backup_array) = glob("$dir/$target");

   if (scalar(@backup_array) == 0) {
	 $backup_filename = "$dir\/"."$parsefile"."_1.bak";
   } else {
	 $combo = join "\º", @backup_array;
	 $combo =~ s/$dir\/$parsefile//g;
	 $combo =~ s/_//g;
	 $combo =~ s/\.bak//g;

	 @backup_array = sort { $b <=> $a } split /\º/, $combo;

	 $backup_filename = "$dir\/"."$parsefile"."_".($backup_array[0]+1).".bak";
	 $result = $backup_array[0]+1;
   }

   system("sort -f -k2 $parsefile>$backup_filename");
   open(BACKSEQ,">$backup_sequence_filename") or die "cant write $backup_sequence_filename";
   print BACKSEQ "$result\n";
   close(BACKSEQ);
   return ($backup_filename, $result);
}

sub RestoreCorpusFile
{
   my($parsefile) = @_;

   my($backup_sequence_filename);
   my($bak_found) = 1;
   my($combo);
   my($copy_filename);
   my($currseq) = -1;
   my($dir) = "slmdirect_results\/createslmDIR_backup_files";
   my($newseq);
   my($result) = 1;
   my($target);
   my(@backup_array);
   my(@bak_contents);

   ($parsefile, $newseq) = split ":", $parsefile;
   if ($newseq != 0) {
	 $currseq = $newseq;
   }

   $target = "$parsefile"."*.bak";
   $backup_sequence_filename = "$dir\/bakseq";
   (@backup_array) = glob("$dir/$target");

   if (scalar(@backup_array) == 0) {
	   $result = -1;
   } else {
	 if ($currseq != -1) {
	   copy ("$dir\/"."$parsefile"."_".$currseq.".bak", $parsefile);
	   $result = $currseq;
	 } else {
	   unless(open(BACKSEQ,"<$backup_sequence_filename")) {
		 $bak_found = 0;
	   }

	   if (!$bak_found) {
		 copy ("$dir\/"."$parsefile"."_1.bak", $parsefile);
	   } else {
		 (@bak_contents) = (<BACKSEQ>);
		 $currseq = $bak_contents[0];
		 close(BACKSEQ);

		 $currseq = ChopChar($currseq);

		 $copy_filename = "$dir\/"."$parsefile"."_".$currseq.".bak";
		 copy ($copy_filename, $parsefile);

		 $result = $currseq - 1;
		 if ($result < 1) {
		   $result = 1;
		 }

		 open(BACKSEQ,">$backup_sequence_filename") or die "cant write $backup_sequence_filename";
		 print BACKSEQ "$result\n";
		 close(BACKSEQ);
	   }
	 }
   }

   return ($result);
}

sub RestoreCorpusFile_bak
{
   my($parsefile) = @_;

   my($combo);
   my($dir) = "slmdirect_results\/createslmDIR_backup_files";
   my($result) = 1;
   my($target) = "$parsefile"."*.bak";
   my(@backup_array);

   (@backup_array) = glob("$dir/$target");

   if (scalar(@backup_array) == 0) {
	   $result = -1;
   } else {
	   $combo = join "\º", @backup_array;
	   $combo =~ s/$dir\/$parsefile//g;
	   $combo =~ s/_//g;
	   $combo =~ s/\.bak//g;

	   @backup_array = sort { $b <=> $a } split /\º/, $combo;

	   copy ($parsefile, "$dir\/"."$parsefile".".sav");
	   copy ("$dir\/"."$parsefile"."_".($backup_array[0]).".bak", $parsefile);
	   copy ("$dir\/"."$parsefile"."_".($backup_array[0]).".bak", "slmdirect_results\/createslmDIR_backup_files\/"."$parsefile"."_".($backup_array[0]).".sav");

	   unlink "$dir\/"."$parsefile"."_".($backup_array[0]).".bak";

	   $result = $backup_array[0];
#	   system("sort -f -k2 $parsefile>"."$dir\/"."$parsefile"."_".($backup_array[0]+1).".bak");
   }

   return ($result);
 }

############# END SLMDirect Utility SUBROUTINES #######################

######################################################################
######################################################################
############# WORDNet SUBROUTINES ####################################
######################################################################
######################################################################

sub SetFrequency
{
   my($wn, $pos, $elem, $wordnet_false_frequency_hash) = @_;

   my($frequency);
   my($temp_elem) = $elem;

   $temp_elem =~ s/\#(n|v|a)\#((\d)+)//;
   $frequency = $$wordnet_false_frequency_hash{$pos}{$temp_elem};
   if (not defined $frequency) {
	   $frequency = $wn->frequency("$elem");
   }

   return ($frequency);
}

sub FillSenseArrays
{
   my($wordnet_args, $sense_type, $pos_hold_hash, $real_frequency, $item, $pos, $wordnet_used_hash, $related_hash, $processed_items_hash) = @_;

   my($elem);
   my($frequency);
   my($i);
   my($j);
   my($s_pos);
   my($test_string);
   my($words);
   my(%seen_hash);
   my(@items_array);
   my(@items_temp_adjective_array);
   my(@items_temp_array);
   my(@items_temp_noun_array);
   my(@items_temp_verb_array);
   my(@sense_array);
   my(@temp_array);
   my(@unique_array);

#print "=====================================herexxx0000000000000000000000000000000000000000a: pos=$pos, item=$item, sense_type=$sense_type, real_frequency=$real_frequency\n";
   @sense_array = $$wordnet_args{"wordnet"}->querySense($item, $sense_type);

   if ($real_frequency > 0) {
	   if ($sense_type eq "syns") {
		   (@temp_array) = split /\#/, $item;
		   $words = $temp_array[0];
		   $words = lc($words);
		   $words =~ s/\.//g;

		   $s_pos = $pos;
		   if ($s_pos eq "noun") {
			   $s_pos = "n";
		   } elsif ($s_pos eq "verb") {
			   $s_pos = "v";
		   } elsif ($s_pos eq "adjective") {
			   $s_pos = "a";
		   }

		   foreach $elem ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}{$words}}) {
			   if ($elem ne "") {
				   $elem = $elem."#".$s_pos."#1";
				   push @sense_array, $elem;
			   }
		   }
	   }
   }

   if ((scalar @sense_array) > 0) {
	   @unique_array = grep {! $seen_hash{$_} ++ } @sense_array;
	   $j = 0;
	   for ($i = 0; $i < scalar (@unique_array); $i++) {
		   $elem = $unique_array[$i];
		   (@temp_array) = split /\#/, $elem;
		   $words = $temp_array[0];
		   $words = lc($words);
		   $words =~ s/\.//g;

#		   if (($words =~ /\_/) || ($words =~ /\-/) || ($words =~ /\d/)) {
#			   print "herexxx1: item=$item, words=$words, sense_type=$sense_type\n";
#		   }

		   if (($words !~ /\_/) && ($words !~ /\-/) && ($words !~ /\d/)) {
			   $frequency = SetFrequency($$wordnet_args{"wordnet"}, $pos, $elem, $$wordnet_args{"wordnet_false_frequency"});
			   if (($sense_type eq "syns") || ($sense_type eq "sim") || ($sense_type eq "deri")) {
				   if ($frequency == 0) {
					   $frequency = 1;
				   }

			   }

			   if ($frequency >= $$wordnet_args{"wordnet_min"}{$pos}) {
#			   if ($frequency > 0) {
				   if ($pos eq "adjective") {
					   $items_temp_adjective_array[$j] = $words;
				   } elsif ($pos eq "noun") {
					   $items_temp_noun_array[$j] = $words;
				   } elsif ($pos eq "verb") {
					   $items_temp_verb_array[$j] = $words;
				   }

				   $items_temp_array[$j] = $words;
				   $j++;

				   if (($sense_type eq "syns") || ($sense_type eq "sim") || ($sense_type eq "deri")) {
#					   if ($pos ne "adjective") {
#						   $$related_hash{"all"}{$words} += $frequency;
#					   }
#print "=====================================herexxx1111111111111111111a: related_hash=pos=$pos, frequency=$frequency, words=$words\n";
					   $$related_hash{$pos}{$words} += $frequency;
				   }
			   }
		   }
	   }

#	   @unique_array = ();
#	   undef %seen_hash;

#	   @items_array = grep {! $seen_hash{$_} ++ } @items_temp_array ;
#	   undef %seen_hash;
#	   $test_string = join "|", @items_array;
#	   if ($test_string ne "") {
#		   @unique_array = grep (/\b($test_string)\b/, (sort { $a cmp $b } keys %{$$wordnet_used_hash{"all"}}));
#		   if (scalar (@unique_array) > 0) {
#			   foreach $elem (@unique_array) {
#				   $$processed_items_hash{"all"}{$elem}++;
#			   }
#		   }
#	   }

	   @unique_array = ();
	   undef %seen_hash;
	   if ($pos eq "noun") {
		   @items_array = grep {! $seen_hash{$_} ++ } @items_temp_noun_array ;
	   } elsif ($pos eq "verb") {
		   @items_array = grep {! $seen_hash{$_} ++ } @items_temp_verb_array ;
	   } elsif ($pos eq "adjective") {
		   @items_array = grep {! $seen_hash{$_} ++ } @items_temp_adjective_array ;
	   }
	   undef %seen_hash;

	   $test_string = join "|", @items_array;
	   if ($test_string ne "") {
		   @unique_array = grep (/\b($test_string)\b/, (sort { $a cmp $b } keys %{$$wordnet_used_hash{$pos}}));
		   if (scalar (@unique_array) > 0) {
			   foreach $elem (@unique_array) {
				   $$processed_items_hash{$pos}{$elem}++;
			   }
		   }
	   }
# if any word from processed_items_hash is in $pos_hold_hash then recurse

   }
}

sub FillWordNetHash_Sub1
{
   my($wordnet_args, $wordnet_array, $alt_syn_links_hash, $keyword_weight, $pos, $word, $word_count, $related_hash, $processed_hypernyms_hash, $processed_hyponyms_hash, $processed_synonyms_hash, $wordnet_frequency_hash, $wordnet_used_hash, $wordnet_pointer_hash, $wordnet_hash) = @_;

   my($add_word);
   my($alt_word_count);
   my($elem);
   my($i);
   my($new_word_found) = 0;
   my($temp_pos);
   my($temp_word_count) = -1;
   my(@final_array);
   my(@sorted_final_array);
   my(@temp_array);
   my(@threshold_array);

   $add_word = "";
#   print "herexxx5555: pos=$pos, word=$word, word_count=$word_count\n";

   if ((scalar keys %{$$processed_hypernyms_hash{$pos}}) > 0) {
	   ($temp_word_count, $add_word, $new_word_found) = FillRelatedHash("hypernyms", 1, 1, $add_word, $new_word_found, $keyword_weight, $pos, $word, $word_count, $related_hash, $processed_hypernyms_hash, $wordnet_frequency_hash, $wordnet_used_hash, $wordnet_hash);
   } elsif (((scalar keys %{$$processed_synonyms_hash{$pos}}) > 0) && ($$wordnet_args{"synonym_option"} ne "strict") && ($$wordnet_args{"autotag_option"} ne "strict")) {
	   ($temp_word_count, $add_word, $new_word_found) = FillRelatedHash("synonyms", 1, 1, $add_word, $new_word_found, $keyword_weight, $pos, $word, $word_count, $related_hash, $processed_synonyms_hash, $wordnet_frequency_hash, $wordnet_used_hash, $wordnet_hash);
   } elsif ((scalar keys %{$$processed_hyponyms_hash{$pos}}) > 0) {
	   ($temp_word_count, $add_word, $new_word_found) = FillRelatedHash("hyponyms", 1, 1, $add_word, $new_word_found, $keyword_weight, $pos, $word, $word_count, $related_hash, $processed_hyponyms_hash, $wordnet_frequency_hash, $wordnet_used_hash, $wordnet_hash);
   } else {
#	   print "HEREXXXVANILLA\n";

	   $temp_word_count = $word_count;
	   $new_word_found = 1;
   }

   if ((scalar keys %{$$related_hash{$pos}}) > 1) {
	   if ($new_word_found) {
		   $word_count++;
	   }

	   (@temp_array) = sort { $$related_hash{$pos}{$b} <=> $$related_hash{$pos}{$a} } keys %{$$related_hash{$pos}};
	   foreach $elem (@temp_array) {
		   if ($$related_hash{$pos}{$elem} >= $$wordnet_args{"wordnet_min"}{$pos}) {
#				   print "herexxxfinalarray0a: pos=$pos, word=$word, elem=$elem, keyword_weight=$keyword_weight\n";
			   push @threshold_array, $elem;
		   }
	   }

	   $i = 0;
	   foreach $elem (@threshold_array) {
		   if (($elem !~ /\_/) && ((length($elem) >= 3) || (defined $$wordnet_args{"wordnet_2_letter_words"}{$elem}))) {
#			 print "herexxxfinalarray0a1111: pos=$pos, word=$word, elem=$elem, keyword_weight=$keyword_weight\n";
			   if ($i > $$wordnet_args{"max_wordnet_count"}) {
				   if ($pos eq "all") {
					   last;
				   } else {
					   @temp_array = grep (/\b($elem)\b/, @$wordnet_array);
					   if ((scalar @temp_array) > 0) {
						   $$alt_syn_links_hash{$pos}{$elem} = $temp_word_count;
					   }

					   next;
				   }
			   }

			   if ($$related_hash{$pos}{$elem} < $keyword_weight) {
				   if ($pos eq "noun") {
					   $temp_pos = "n";
				   } elsif ($pos eq "verb") {
					   $temp_pos = "v";
				   } elsif ($pos eq "adjective") {
					   $temp_pos = "a";
				   } elsif ($pos eq "all") {
					   $temp_pos = "l";
				   }

				   push @final_array, "$elem+$temp_pos+".$$related_hash{$pos}{$elem};
#				   print "herexxxfinalarray1-1: pos=$pos, word=$word, thresholdelem=$elem, temp_word_count=$temp_word_count, word_count=$word_count, final_array=", "$elem+$temp_pos+".$$related_hash{$pos}{$elem}, "\n";

			   } else {
#				   print "herexxxfinalarray1-2: pos=$pos, word=$word, thresholdelem=$elem, temp_word_count=$temp_word_count, word_count=$word_count, final_array=$elem\n";
				   push @final_array, $elem;
			   }

			   if (($pos ne "all") && ($elem ne $word)) {
				   $alt_word_count = $$alt_syn_links_hash{$pos}{$elem};
				   if ((defined $alt_word_count) && ($alt_word_count != $temp_word_count)) {
#					   print "\t>>>>>>herexxxaltwordcount: alt_word_count=$alt_word_count, temp_word_count=$temp_word_count, word_count=$word_count, pos=$pos, word=$word, thresholdelem=$elem\n";
					   $temp_word_count = $alt_word_count;
				   }
			   }

			   $$wordnet_used_hash{$pos}{$elem} = $temp_word_count;
			   $$wordnet_frequency_hash{$pos}{$elem} = $$related_hash{$pos}{$elem};
			   $i++;
		   }
	   }

	   $$wordnet_pointer_hash{$pos}{$word} = $temp_word_count;
#	   print "herexxxfinalarray55555555555555555a: pos=$pos, word=$word, temp_word_count=$temp_word_count\n";

	   if ($add_word ne "") {
#	   print "herexxxfinalarray55555555555555555b: pos=$pos, word=$word, add_word=$add_word, temp_word_count=$temp_word_count\n";
		   $$wordnet_pointer_hash{$pos}{$add_word} = $temp_word_count;
	   }

	   if ((scalar @final_array) > 0) {
		   @sorted_final_array = sort { $a cmp $b } @final_array;
		   $$wordnet_hash{$pos}{$temp_word_count} = [@sorted_final_array];
	   }
   } elsif ((scalar keys %{$$related_hash{$pos}}) > 0) {
#	   print "herexxxfinalarray55555555555555555c: pos=$pos, word=$word, temp_word_count=$temp_word_count\n";
	   (@temp_array) = sort { $$related_hash{$pos}{$b} <=> $$related_hash{$pos}{$a} } keys %{$$related_hash{$pos}};
	   foreach $elem (@temp_array) {
		   if ($$related_hash{$pos}{$elem} >= $$wordnet_args{"wordnet_min"}{$pos}) {
			   push @threshold_array, $elem;
		   }
	   }

	   foreach $elem (@threshold_array) {
		   if (($elem !~ /\_/) && ((length($elem) >= 3) || (defined $$wordnet_args{"wordnet_2_letter_words"}{$elem}))) {
			   $$wordnet_used_hash{$pos}{$elem} = -1;
			   $$wordnet_frequency_hash{$pos}{$elem} = $$related_hash{$pos}{$elem};
		   }
	   }
   }

   return ($word_count);
}

sub FillRelatedHash
{
   my($mode, $filter_elem, $undef_hash, $add_word, $new_word_found, $keyword_weight, $pos, $word, $word_count, $related_hash, $processed_items_hash, $wordnet_frequency_hash, $wordnet_used_hash, $wordnet_hash) = @_;

   my($elem);
   my($temp_word_count) = -1;
   my(@temp_array);

   (@temp_array) = sort { $a cmp $b } keys %{$$processed_items_hash{$pos}};
   $temp_word_count = $$wordnet_used_hash{$pos}{$temp_array[0]};

#   print "HEREXXX$mode\n";

   if ($temp_word_count != -1) {
# herexxx should undef be delete?
	   if ($undef_hash) {
		   undef %{$$related_hash{$pos}};
	   }

#	   if ($mode eq "synonyms") {
#		   foreach $elem (@temp_array) {
#			   if (not defined $$related_hash{$pos}{$elem}) {
#				   $$related_hash{$pos}{$elem} = $$wordnet_frequency_hash{$pos}{$elem};
#				   print "\t\therexxx$mode: temp_word_count exists: elem=$elem, pos=$pos, word=$word, temp_word_count=$temp_word_count\n";
#			   }
#		   }
#	   } else {
#print "=====================================herexxx1111111111111111111b: related_hash=pos=$pos, word=$word\n";
		   $$related_hash{$pos}{$word} = $keyword_weight;

		   foreach $elem (sort { $a cmp $b } @{$$wordnet_hash{$pos}{$temp_word_count}}) {
			   if ($filter_elem) {
				   $elem =~ s/\+(n|a|v|l)\+((\d)+)//g;
			   }

			   if (not defined $$related_hash{$pos}{$elem}) {
#				   print "\t\therexxx$mode:temp_word_count exists: elem=$elem, pos=$pos, word=$word, temp_word_count=$temp_word_count\n";

#print "=====================================herexxx1111111111111111111c: related_hash=pos=$pos, elem=$elem, frequency=", $$wordnet_frequency_hash{$pos}{$elem}, "\n";

				   $$related_hash{$pos}{$elem} = $$wordnet_frequency_hash{$pos}{$elem};
			   }
		   }
#	   }
   } else {
	   $add_word = $temp_array[0];
#print "=====================================herexxx1111111111111111111d: related_hash=pos=$pos, elem=$elem, frequency=", $$wordnet_frequency_hash{$pos}{$add_word}, "\n";

	   $$related_hash{$pos}{$word} = $keyword_weight;
	   $$related_hash{$pos}{$add_word} = $$wordnet_frequency_hash{$pos}{$add_word};
	   $temp_word_count = $word_count;
	   $new_word_found = 1;
#	   print "\t\therexxx$mode: new temp_word_count: new_word_found=$new_word_found, $add_word=$add_word, pos=$pos, word=$word, temp_word_count=$temp_word_count\n";

   }

   return($temp_word_count, $add_word, $new_word_found);
}

sub FillWordNetHash
{
   my($general_args, $meaning_args, $wordnet_args, $keyword_weight, $sentence, $wordnet_pointer_hash, $wordnet_hash, $pos_only_hash, $default_pos_hash, $seen_hash, $create_freq_file) = @_;

   my($counter);
   my($disallow_adjective_adverb);
   my($elem1);
   my($elem2);
   my($elem3);
   my($found);
   my($frequency);
   my($inner_word_count) = 0;
   my($keep_string);
   my($match_pos);
   my($max_sense_elem);
   my($max_sense_freq);
   my($new_sentence);
   my($outer_word_count) = 0;
   my($pass_text) = "pass";
   my($pos);
   my($pos_lock);
   my($prev_word);
   my($real_frequency);
   my($s_pos);
   my($sense);
   my($sense_count) = 0;
   my($sim_sense);
   my($skip_string);
   my($test_string) = $$meaning_args{"pre_string"};
   my($validated);
   my($word);
   my($word1);
   my($word2);
   my($word_pointer);
   my(%alt_syn_links_hash);
   my(%frequency_hash);
   my(%loc_seen_hash);
   my(%pos_hold_hash);
   my(%processed_hypernyms_hash);
   my(%processed_hyponyms_hash);
   my(%processed_synonyms_hash);
   my(%related_hash);
   my(%sense_hash);
   my(%test_hash);
   my(%validate_hash);
   my(%wordnet_frequency_hash);
   my(%wordnet_used_hash);
   my(@derived_array);
   my(@exclude_array);
   my(@keep_array);
   my(@pos_array);
   my(@sense_array);
   my(@similar_array);
   my(@skip_array);
   my(@temp_array);
   my(@test_array);
   my(@unique_array);
   my(@wordnet_array);

   if ($$general_args{"main_language"} eq "es-us") {
	   $pass_text = $pass_text."_esus";
	   $test_string = $$meaning_args{"pre_string_esus"};
   }

   @test_array = split " ", $test_string;
   foreach $word (@test_array) {
	   if ($word =~ /\#/) {
		   next;
	   }

	   if ($word =~ /\=/) {
		   $word =~ s/\=//g;
	   } elsif ($word =~ /\!/) {
		   $word =~ s/\(|\)//g;
		   $counter = 0;
		   ($skip_string, $keep_string) = split /\!/, $word;
		   @skip_array = split /\|/, $skip_string;
		   @keep_array = split /\|/, $keep_string;
		   foreach $elem1 (@skip_array) {

			   $test_hash{$elem1}++;
		   }

		   foreach $elem1 (@skip_array) {
			   foreach $elem2 (@keep_array) {
				   $elem3 = $elem1." ".$elem2;
				   $validate_hash{$elem1}{$elem2}++;
				   push @exclude_array, $elem3;
			   }
		   }

		   next;
	   }

	   $test_hash{$word}++;
   }

   (@temp_array) = split /\º/, $sentence;
   @unique_array = grep {! $$seen_hash{$_} ++ } @temp_array;

   $new_sentence = join "\º", @unique_array;
   @temp_array = ();
   @unique_array = ();

   foreach $word ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}{$pass_text}}) {
	   foreach $elem1 ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}{$pass_text}{$word}}) {
		   ($word1, $word2) = split " ", $elem1;
		   if ($word2 ne "") {
			   $validate_hash{$word1}{$word2}++;
		   }

		   $elem2 = $elem1;
		   $elem2 =~ s/ /_/g;
		   $new_sentence =~ s/$elem1/$elem2/g;
	   }
   }

   $prev_word = "";
   foreach $word (@exclude_array) {
	   $elem1 = $word;
	   $elem1 =~ s/ /\+/g;
	   $new_sentence =~ s/$word/$elem1/g;
   }

   @exclude_array = ();

   $new_sentence = analyzeSentenceStructure($general_args, $meaning_args, $new_sentence);

   $new_sentence = ApplySqueezeSentenceMinus($general_args, $meaning_args, $wordnet_args, $new_sentence);

   collapseSentence($new_sentence, \@wordnet_array, 1, 0);

   $inner_word_count = 0;
   $outer_word_count = 0;
   $word_pointer = 0;
   foreach $word (@wordnet_array) {
	   $pos_lock = "";
	   if ($word =~ /\#a/) {
		 $pos_lock = $word;
	   }

	   if ($word =~ /\#n/) {
		 $pos_lock = $word;
	   }

	   if ($word =~ /\#v/) {
		 $pos_lock = $word;
	   }

	   $word =~ s/(\#a|\#n|\#v)//g;

	   if (($word !~ /\[|\]|\(|\)|\@|\_/) && ((length($word) >= 3) || (defined $$wordnet_args{"wordnet_2_letter_words"}{$word}))) {
		   $validated = 0;
		   $disallow_adjective_adverb = 0;
		   $sim_sense = 0;
		   if ($word_pointer < scalar(@wordnet_array)-1) {
			   if (defined $validate_hash{$word}{$wordnet_array[$word_pointer+1]}) {
				   $validated = 1;
			   }
		   }

		   if (!$validated) {
			   if (not defined $test_hash{$word}) {
				   $validated = 1;
			   }
		   }

		   if ($validated) {
			   undef %frequency_hash;
			   undef %processed_hypernyms_hash;
			   undef %processed_hyponyms_hash;
			   undef %processed_synonyms_hash;
			   undef %related_hash;

			   @derived_array = ();
			   @similar_array = ();
			   @temp_array = ();
			   @unique_array = ();

#			   $related_hash{"all"}{$word} = $keyword_weight;

			   if (($pos_lock eq "") || ($pos_lock =~ /\#n/)) {
				 @pos_array = $$wordnet_args{"wordnet"}->querySense($word);
				 if ($pos_lock =~ /\#n/) {
				   $s_pos = $word."\#a";
				   @unique_array = grep (/\b$s_pos\b/, @pos_array);
				   if ((scalar @unique_array) == 0) {
					 @pos_array = ();
					 $pos_array[0] = $pos_lock;
				   }

				   $s_pos = "";
				   @unique_array = ();
				 }
			   } else {
				 $pos_array[0] = $pos_lock;
			   }

			   $s_pos = $$wordnet_args{"add_wordnet_pos"}{$word};
			   if (not defined $s_pos) {
				   $s_pos = $$wordnet_args{"alt_default_pos"}{$word};
			   }

			   if (not defined $s_pos) {
				   $s_pos = $$wordnet_args{"alt_syn_default_pos"}{$word};
			   }

			   if (defined $s_pos) {
				   $sim_sense = 1;
				   if ($s_pos eq "noun") {
					   $s_pos = "$word#n";
				   } elsif ($s_pos eq "verb") {
					   $s_pos = "$word#v";
				   } elsif ($s_pos eq "adjective") {
					   $s_pos = "$word#a";
				   }

				   if ((scalar @pos_array) > 0) {
					   @unique_array = grep (/\b$s_pos\b/, @pos_array);
				   }

				   if ((scalar @unique_array) == 0) {
					   push @pos_array, $s_pos;
				   }

				   @unique_array = ();
			   }

#			   if ((scalar @pos_array) == 0) {
#				   $s_pos = $$wordnet_args{"add_wordnet_pos"}{$word};
#				   if (not defined $s_pos) {
#					   $s_pos = $$wordnet_args{"alt_default_pos"}{$word};
#				   }

#				   if (defined $s_pos) {
#					   if ($s_pos eq "noun") {
#						   $s_pos = "$word#n";
#					   } elsif ($s_pos eq "verb") {
#						   $s_pos = "$word#v";
#					   } elsif ($s_pos eq "adjective") {
##						   $s_pos = "$word#a";
#					   }
#
#					   $pos_array[0] = $s_pos;
#					   $sim_sense = 1;
#				   }
#			   }

			   if ((scalar @pos_array) > 1) {
				   if ($sim_sense && ($s_pos !~ /\#a/)) {
					   $disallow_adjective_adverb = 1;
				   }
			   }

			   if ((scalar @pos_array) == 1) {
				   $elem1 = $pos_array[0];
				   if (($elem1 =~ /\#n/) || ($elem1 =~ /\#v/) || ($elem1 =~ /\#a/)) {
					   if ($elem1 =~ /\#n/) {
						   $pos = "noun";
					   } elsif ($elem1 =~ /\#v/) {
						   $pos = "verb";
					   } elsif ($elem1 =~ /\#a/) {
						   $pos = "adjective";
					   }

					   if (($pos_lock ne "") || ((substr($word, length($word)-3) ne "ing") && ($pos eq "noun")) || ((substr($word, length($word)-2) ne "ed") && ($pos eq "adjective")) || ((substr($word, length($word)-2) eq "ed") && ($pos eq "adjective") && (substr($word, length($word)-3, 1) =~ /[aeiou]/)) || ($pos eq "verb")) {
						   $$pos_only_hash{$word} = $pos;
					   } else {
						   next;
					   }
				   }
			   }

			   $prev_word = $word;
			   foreach $elem1 (@pos_array) {
				   if (($elem1 !~ /\#n/) && ($elem1 !~ /\#v/) && ($elem1 !~ /\#a/)) {
					   next;
				   }

#			   if ($disallow_adjective_adverb && (($elem1 =~ /\#a/))) {
#				   next;
#			   }

				   (@temp_array) = split /\#/, $elem1;
				   if ($temp_array[1] eq "n") {
					   $pos = "noun";
				   } elsif ($temp_array[1] eq "v") {
					   $pos = "verb";
				   } elsif ($temp_array[1] eq "a") {
					   $pos = "adjective";
				   }

				   $pos_hold_hash{$pos}{$elem1}++;
			   }
		   }
	   }

	   $word_pointer++;
   }

   foreach $pos ( sort { $a cmp $b } keys %pos_hold_hash) {
	   foreach $elem1 ( sort { $a cmp $b } keys %{$pos_hold_hash{$pos}}) {
		   (@temp_array) = split /\#/, $elem1;
		   $word = $temp_array[0];

		   if ($wordnet_used_hash{$pos}{$word}) {
			   next;
		   }

		   @sense_array = $$wordnet_args{"wordnet"}->querySense($elem1);
		   if (((scalar @sense_array) == 0) && $sim_sense) {
			   $s_pos = $pos_array[0];

			   if ($s_pos =~ /\#n/) {
				   $s_pos = "$word#n#1";
			   } elsif ($s_pos =~ /\#v/) {
				   $s_pos = "$word#v#1";
			   } elsif ($s_pos =~ /\#a/) {
				   $s_pos = "$word#a#1";
			   }

			   $sense_array[0] = $s_pos;
		   }

		   if (($$wordnet_args{"synonym_option"} eq "strict") || ($$wordnet_args{"autotag_option"} eq "strict")) {
			   if ((scalar @sense_array) > 1) {
				   $max_sense_freq = -999999;
				   $max_sense_elem = $sense_array[0];
				   foreach $elem2 (@sense_array) {
					   if ($elem2 =~ /\_/) {
						   next;
					   }

					   $frequency = SetFrequency($$wordnet_args{"wordnet"}, $pos, $elem2, $$wordnet_args{"wordnet_false_frequency"});
#						   if ($frequency > $$wordnet_args{"wordnet_min"}{$pos}) {
					   if ($frequency > 0) {
#print "=====================================herexxx1111111111111111111f: frequency=$frequency, pos=$pos, word=$word, elem2=$elem2\n";
#   ATTENTION             if ($frequency >= 3) {
#print "=====================================herexxx1111111111111111111e: related_hash=pos=$pos, word=$word, keyword_weight=$keyword_weight\n";
#                             $related_hash{$pos}{$word} = $keyword_weight;
#						  }

                          $sense_hash{$elem2} = $frequency;

#						   if ($frequency > $max_sense_freq) {
#							   $max_sense_freq = $frequency;
#							   $max_sense_elem = $elem2;
#						   }
					   }
				   }

#				   $max_sense_elem = $sense_array[0];
				   @sense_array = ();
#				   $sense_array[0] = $max_sense_elem;

				   $sense_count = 0;
				   foreach $sense ( sort { $sense_hash{$b} <=> $sense_hash{$a}  } keys %sense_hash) {
					 $sense_array[$sense_count] = $sense;
					 $sense_count++;
					 if ($sense_count == 3) {
					   last;
					 }
				   }
			   }
		   }

		   @unique_array = grep {! $loc_seen_hash{$_} ++ } @sense_array;
		   foreach $elem2 (@unique_array) {
			   if ($elem2 =~ /\#5/) {
				   last;
			   }

			   $frequency = SetFrequency($$wordnet_args{"wordnet"}, $pos, $elem2, $$wordnet_args{"wordnet_false_frequency"});
			   $real_frequency = $frequency;
			   if ($frequency == 0) {
				   $frequency = 1;
			   }

			   $frequency_hash{$pos}{$word} += $frequency;

			   if ($elem2 =~ /\#n/) {
				 $match_pos = "noun";
			   } elsif ($elem2 =~ /\#v/) {
				 $match_pos = "verb";
			   } elsif ($elem2 =~ /\#a/) {
				 $match_pos = "adjective";
			   }

			   if ($match_pos eq $pos) {
				 if (($$wordnet_args{"synonym_option"} ne "strict") && ($$wordnet_args{"autotag_option"} ne "strict")) {
				   FillSenseArrays($wordnet_args, "hypos", \%pos_hold_hash, $real_frequency, $elem2, $pos, \%wordnet_used_hash, \%related_hash, \%processed_hyponyms_hash);

				   FillSenseArrays($wordnet_args, "hypes", \%pos_hold_hash, $real_frequency, $elem2, $pos, \%wordnet_used_hash, \%related_hash, \%processed_hypernyms_hash);

#						   FillSenseArrays($wordnet_args, "sim", \%pos_hold_hash, $real_frequency, $elem2, $pos, \%wordnet_used_hash, \%related_hash, \%processed_similar_hash);

#						   FillSenseArrays($wordnet_args, "deri", \%pos_hold_hash, $real_frequency, $elem2, $pos, \%wordnet_used_hash, \%related_hash, \%processed_derived_hash);
				 }

				 FillSenseArrays($wordnet_args, "syns", \%pos_hold_hash, $real_frequency, $elem2, $pos, \%wordnet_used_hash, \%related_hash, \%processed_synonyms_hash);
			   }
		   }

		   @unique_array = ();
		   undef %loc_seen_hash;

		   $inner_word_count = FillWordNetHash_Sub1($wordnet_args, \@wordnet_array, \%alt_syn_links_hash, $keyword_weight, $pos, $word, $inner_word_count, \%related_hash, \%processed_hypernyms_hash, \%processed_hyponyms_hash, \%processed_synonyms_hash, \%wordnet_frequency_hash, \%wordnet_used_hash, $wordnet_pointer_hash, $wordnet_hash);
	   }
   }

   foreach $pos ( sort { $a cmp $b } keys %pos_hold_hash) {
	   foreach $elem1 ( sort { $a cmp $b } keys %{$pos_hold_hash{$pos}}) {
		   (@temp_array) = split /\#/, $elem1;
		   $word = $temp_array[0];
		   if (($frequency_hash{"verb"}{$word} > 0) && (($frequency_hash{"verb"}{$word} >= $frequency_hash{"noun"}{$word}) && ($frequency_hash{"verb"}{$word} >= $frequency_hash{"adjective"}{$word}))) {
			   $$default_pos_hash{$word} = "verb";
		   } elsif (($frequency_hash{"noun"}{$word} > 0) && (($frequency_hash{"noun"}{$word} > $frequency_hash{"verb"}{$word}) && ($frequency_hash{"noun"}{$word} >= $frequency_hash{"adjective"}{$word}))) {
			   $$default_pos_hash{$word} = "noun";
		   } elsif (($frequency_hash{"adjective"}{$word} > 0) && (($frequency_hash{"adjective"}{$word} > $frequency_hash{"verb"}{$word}) && ($frequency_hash{"adjective"}{$word} > $frequency_hash{"noun"}{$word}))) {
			   $$default_pos_hash{$word} = "adjective";
		   }

#		   $outer_word_count = FillWordNetHash_Sub1($wordnet_args, \@wordnet_array, \%alt_syn_links_hash, $keyword_weight, "all", $word, $outer_word_count, \%related_hash, \%processed_hypernyms_hash, \%processed_hyponyms_hash, \%processed_synonyms_hash, \%wordnet_frequency_hash, \%wordnet_used_hash, $wordnet_pointer_hash, $wordnet_hash);

	   }
   }

   if ($create_freq_file) {
	   $found = 0;
	   open(WORDFREQ,">"."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_frequency".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_frequency".$$general_args{"language_suffix"};
	   foreach $pos ( sort { $a cmp $b } keys %wordnet_frequency_hash) {
		   foreach $word ( sort { $wordnet_frequency_hash{$pos}{$b} <=> $wordnet_frequency_hash{$pos}{$a} } keys %{$wordnet_frequency_hash{$pos}}) {
			   if ($wordnet_frequency_hash{$pos}{$word} < $keyword_weight) {
				   $found = 1;
				   print WORDFREQ "$pos\t$word\t", $wordnet_frequency_hash{$pos}{$word}, "\n";
			   }
		   }
	   }

	   close(WORDFREQ);

	   if (!$found) {
		   unlink "slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_frequency".$$general_args{"language_suffix"};
	   } else {
		   DebugPrint ("BOTH", 1, "FillWordNetHash_1", $debug, $err_no++, "WordNet Frequency File created: "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_frequency".$$general_args{"language_suffix"});
	   }
   }
}

sub BuildWordEndingsList
{
   my($pos, $wn, $ending_hash) = @_;

   my($ending, $total_count);

   $total_count = 0;

   foreach ($wn->listAllWords($pos)) {
	   $ending = GetWordEndings($_);
	   if ($ending ne "") {
		   $$ending_hash{$ending}++;
		   $total_count++;
	   }
   }

   return $total_count;
}

sub GetWordEndings
{
   my($word) = @_;

   my($temp_word, $ending, $wordlen);

   $temp_word = $word."\º";
   $temp_word =~ s/\'s//g;
   $wordlen = length($temp_word)-1;
   if (($wordlen >= 6) && ($temp_word !~ /\_|\-|\.|\d|\'|\//) && ($temp_word =~ /[aeiou]/)) {
	   $ending = "";
	   if ($temp_word =~ /(([bcdfghjklmnpqrstvwxz]){1})(([aeiouy])+)(([bcdfghjklmnpqrstvwxz]){1})\º/) {
		   $ending = "$3$5";
	   } elsif ($temp_word =~ /(([bcdfghjklmnpqrstvwxz]){1})(([aeiouy])+)(([bcdfghjklmnpqrstvwxz]){1,2})\º/) {
		   if (length($1) == 2) {
			   if (substr($1,0,1) eq substr($1,1,1)) {
				   $ending = substr($1,0,1)."$3$5";
			   } else {
				   $ending = "$1$3$5";
			   }
		   } else {
			   $ending = "$1$3$5";
		   }

		   if (length($ending) == 4) {
			   if (substr($ending,1,1) eq "i") {
				   $ending = substr($ending,1);
			   }
		   }
	   } elsif ($temp_word =~ /(([aeiouy])+)(([bcdfghjklmnpqrstvwxz]){1,2})\º/) {
		   $ending = "$1$3";
	   } elsif ($temp_word =~ /(([aeiouy])+)(([bcdfghjklmnpqrstvwxyz]){1,2})(([aeiouy])+)\º/) {
		   $ending = "$1$3$5";
	   } elsif ($temp_word =~ /(([bcdfghjklmnpqrstvwxyz]){1,2})(([aeiouy])+)\º/) {
		   $ending = "$1$3";
	   } elsif ($temp_word =~ /(([aeiouy])+)(([bcdfghjklmnpqrstvwxyz])+)\º/) {
		   $ending = "$1$3";
	   }
   }

   return $ending;
}

sub getPosFromSuffix
{
   my($word, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash) = @_;

   my($ending, $alt_default_pos);
   my($noun_freq, $verb_freq, $adjective_freq);

   $ending = GetWordEndings($word);
   if ($ending ne "") {
	   $noun_freq = $$ending_noun_hash{$ending};
	   $verb_freq = $$ending_verb_hash{$ending};
	   $adjective_freq = $$ending_adjective_hash{$ending};

	   if (($verb_freq > 0) && (($verb_freq >= $noun_freq) && ($verb_freq >= $adjective_freq))) {
		   $alt_default_pos = "verb";
	   } elsif (($noun_freq > 0) && (($noun_freq > $verb_freq) && ($noun_freq >= $adjective_freq))) {
		   $alt_default_pos = "noun";
	   } elsif (($adjective_freq > 0) && (($adjective_freq > $verb_freq) && ($adjective_freq > $noun_freq))) {
		   $alt_default_pos = "adjective";
	   }
   }

   return ($alt_default_pos);
}


sub PutArticles
{
   my($word, $pos, $assigned_article, $prev_word, $prev_pos, $replacement) = @_;

   my($article);
   my($articles) = " a an the my your our her his their ";
   my($elem);
   my($indef_pronouns) = " anyone anybody anything everyone everybody everything nothing nobody someone somebody something ";
   my($new_replacement) = $replacement;
   my($temp_elem) = "";
   my($temp_word) = "";
   my($word_is_indef);
   my(@word_array);

   if ($pos eq "noun") {
	   $word_is_indef = 0;
	   $temp_elem = " ".$word." ";
	   if (index($indef_pronouns, $temp_elem) != -1) {
		   $word_is_indef = 1;
	   }

	   if ($prev_word ne "") {
		   $temp_elem = " ".$prev_word." ";
	   }

	   if ((($prev_word eq "") && ($prev_pos eq "")) || (($temp_elem !~ /\'s /) && ($prev_pos ne "noun") && ($prev_pos ne "adjective"))) {
		   if ((($assigned_article ne "") && (!$word_is_indef)) || (($assigned_article eq "") && ($word_is_indef)) || (($assigned_article eq "") && ($word_is_indef))) {
			   (@word_array) = split ":", $replacement;
			   $new_replacement = "";
			   foreach $elem (@word_array) {
				   $temp_word = $elem;
				   $temp_word =~ s/\+(n|a|v|l)\+((\d)+)//g;
				   $temp_elem = " ".$temp_word." ";
				   if ((index($indef_pronouns, $temp_elem) == -1) && ($temp_elem !~ /ing /)) {
					   $article = "a";
					   if (substr($elem,0,1) =~ /[aeiou]/) {
						   $article = "an";
					   }

					   $new_replacement = stringBuilder($new_replacement, $article."\º".$elem, ":");
				   } else {
					 $new_replacement = stringBuilder($new_replacement, $elem, ":");
				   }
			   }
		   }
	   }
   }

   if (($new_replacement eq $replacement) && ($assigned_article ne "")) {
	   $new_replacement = $assigned_article." ".$new_replacement;
   }

   return ($new_replacement);
}

sub setFalseFreqsfromString
{
    my($string, $wordnet_false_frequency_hash, $alt_default_pos_hash) = @_;

	my($counter);
	my($elem);
	my($nl_type);
	my($new_freq);
	my($pos);
	my($word);
	my(@alt_temp_array);
	my(@temp_array);

	($nl_type,@temp_array) = split ",", $string;

	$counter = scalar(@temp_array);

	foreach $elem (@temp_array) {
		$alt_temp_array[$counter-1] = $elem;
		$counter--;

		($word, $pos, $new_freq) = split ":", $elem;

		$word = lc $word;

		if ($pos eq "n") {
			$pos = "noun";
		} elsif ($pos eq "v") {
			$pos = "verb";
		} elsif ($pos eq "a") {
			$pos = "adjective";
		}

		$$wordnet_false_frequency_hash{$pos}{$word} = $new_freq;
	}

	foreach $elem (@alt_temp_array) {
		($word, $pos, $new_freq) = split ":", $elem;

		$word = lc $word;

		if ($pos eq "n") {
			$pos = "noun";
		} elsif ($pos eq "v") {
			$pos = "verb";
		} elsif ($pos eq "a") {
			$pos = "adjective";
		}

		$$alt_default_pos_hash{$word} = $pos;
	}
}

sub autoSynonym
{
   my($wordnet_args, $use_original_wavfiles, $do_testsentence, $contains_categories, $item_category, $sentence_order, $synonym_sentence_order, $temp_sentence_order, $corrected_sentence, $seen_hash, $wordnet_pointer_hash, $wordnet_hash, $pos_only_hash, $default_pos_hash, $pos_corrected_array, $original_wavfile_array, $original_transcription_array, $pseudo_corrected_array, $synonym_corrected_array, $original_cat_array, $synfile_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash) = @_;

   my($alt_default_pos);
   my($articles) = " a an the my your our her his their ";
   my($assigned_article);
   my($default_pos);
   my($elem);
   my($loc);
   my($new_sentence) = "";
   my($pointer);
   my($pos);
   my($prev_pos);
   my($prev_word);
   my($replacement);
   my($temp_elem);
   my($temp_pointer);
   my($test_change);
   my(@cat_sentence_array);
   my(@cat_temp_word_array);
   my(@replacement_in_array);
   my(@replacement_out_array);
   my(@unique_array);
   my(@word_array);
   my(@word_pos_array);

   @word_pos_array = ();
   if (@$pos_corrected_array[$sentence_order] ne "") {
	   @word_pos_array = split " ", @$pos_corrected_array[$sentence_order];
   }

   @word_array = split " ", $corrected_sentence;
   $test_change = 0;
   $prev_pos = "";
   $prev_word = "";
   $assigned_article = "";
   foreach $elem (@word_array){
	   if ($assigned_article eq "") {
		   $temp_elem = " ".$elem." ";
		   $loc = index($articles, $temp_elem);
		   if ($loc != -1) {
			   $assigned_article = $elem;
			   next;
		   } else {
			   $assigned_article = "";
		   }
	   }

	   $pos = $$pos_only_hash{$elem};

	   if (not defined $pos) {
		   $pos = "";
		   if ((scalar @word_pos_array) > 0) {
			   @unique_array = grep (/\b$elem\b/, @word_pos_array);
			   if ((scalar @unique_array) > 0) {
				   if ($unique_array[0] =~ /\#v/) {
					   $pos = "verb";
				   } elsif ($unique_array[0] =~ /\#a/) {
					   $pos = "adjective";
				   }
			   }
		   }
	   }

	   $replacement = "";
#	   print "\n\nherexxxfinalarray4444444444444444444444444444a: default_pos=$default_pos, pos=$pos, word=$elem\n";
	   if ($pos ne "") {
		   $pointer = $$wordnet_pointer_hash{$pos}{$elem};
		   if (defined $pointer) {
			   $replacement = join ":", @{$$wordnet_hash{$pos}{$pointer}};
#			   print "herexxxfinalarray4444444444444444444444444444a11111: pos=$pos, pointer=$pointer, assigned_article=$assigned_article, replacement=$replacement, word=$elem\n";
			   if ($assigned_article ne "") {
				   $pos = "noun";
				   $temp_pointer = $$wordnet_pointer_hash{$pos}{$elem};
				   if (defined $temp_pointer) {
					   $replacement = join ":", @{$$wordnet_hash{$pos}{$temp_pointer}};
				   } else {
					   $replacement = "";
				   }
			   }
#			   print "herexxxfinalarray4444444444444444444444444444a22222: pos=$pos, temp_pointer=$temp_pointer, assigned_article=$assigned_article, replacement=$replacement, word=$elem\n";
		   }
	   }

#	   print "\n\nherexxxfinalarray6666666666666666666666666666666a: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
	   if ($replacement eq "") {
		   $default_pos = $$wordnet_args{"add_wordnet_pos"}{$elem};
		   if (not defined $default_pos) {
			   $default_pos = $$wordnet_args{"alt_default_pos"}{$elem};
		   }

		   if (not defined $default_pos) {
			   $default_pos = $$wordnet_args{"alt_syn_default_pos"}{$elem};
		   }

		   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
		   if ((defined $pointer)) {
			   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
		   }
	   }

#	   print "herexxxfinalarray77777777777777777777777777a: assigned_article=$assigned_article, default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
	   if ($replacement eq "") {
		   $default_pos = $$default_pos_hash{$elem};

		   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
		   if ((defined $pointer) && ($default_pos eq "verb")) {
			 if ($assigned_article ne "") {
#	   print "herexxxfinalarray77777777777777777777777777a1: pointer=$pointer, assigned_article=$assigned_article, default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
			   $pos = "noun";
			   $temp_pointer = $$wordnet_pointer_hash{$pos}{$elem};
			   if (defined $temp_pointer) {
				 $replacement = join ":", @{$$wordnet_hash{$pos}{$temp_pointer}};
			   } else {
				 $replacement = "";
			   }
			 }
		   }

		   if ((defined $pointer) && ($replacement eq "")) {
#	   print "herexxxfinalarray77777777777777777777777777a2: pointer=$pointer, assigned_article=$assigned_article, default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
			   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
		   }
	   }

#	   print "herexxxfinalarray77777777777777777777777777b: assigned_article=$assigned_article, default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
	   if ($replacement eq "") {
		   $default_pos = $$default_pos_hash{$elem};
		   $alt_default_pos = getPosFromSuffix($elem, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash);

		   if ($default_pos eq $alt_default_pos) {
			   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
			   if ((defined $pointer) && ($default_pos ne "verb")) {
				   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
			   }
		   }
	   }


	   if ($replacement eq "") {
		   $replacement = $elem;
	   }

#	   print "herexxxfinalarray77777777777777777777777777c: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
	   if ($replacement ne $elem) {
		   if ($replacement =~ /\:/) {
			   @replacement_in_array = split ":", $replacement;
			   keys my %or_cache = @replacement_in_array;
			   @replacement_out_array = sort {
				   ($or_cache{$a} ||= $a)
					   cmp
					   ($or_cache{$b} ||= $b)
				   } @replacement_in_array;

			   $replacement = join ":", @replacement_out_array;
		   }

		   $test_change = 1;
#		   $replacement =~ s/(\:$elem\b|\b$elem\:)//g;

		   $replacement = PutArticles($elem, $pos, $assigned_article, $prev_word, $prev_pos, $replacement);

		   $assigned_article = "";
	   } else {
		   if ($assigned_article) {
			   $replacement = $assigned_article." ".$replacement;
		   }

		   $assigned_article = "";
	   }

	   $replacement =~ s/(\+(\w)\+((\d)+))//g;
#	   print "herexxxfinalarray77777777777777777777777777d: replacement=$replacement, test_change=$test_change, pos=$pos, word=$elem\n";

	   $new_sentence = stringBuilder($new_sentence, $replacement, " ");

	   $new_sentence = TrimChars($new_sentence);

	   $prev_word = $elem;
	   if ($pos ne "") {
		   $prev_pos = $pos;
	   } elsif ($default_pos ne "") {
		   $prev_pos = $default_pos;
	   } else {
		   $prev_pos = "";
	   }
   }


   if ($test_change) {
	   if (index($new_sentence, ":") != -1) {
		   (@cat_temp_word_array) = split " ", $new_sentence;

		   ExpandSentence (":", \@cat_temp_word_array, \@cat_sentence_array);
	   } else {
		   push @cat_sentence_array, $new_sentence;
	   }

	   if (!$contains_categories) {
		   $item_category = "";
	   }

	   foreach $elem (@cat_sentence_array){
		   $elem =~ s/\º/ /g;

#	   print "herexxxfinalarray888888888888888888888888: new_sentence=$new_sentence, sentence=$elem\n";
		   if (not defined $$seen_hash{$elem}) {
			 $$seen_hash{$elem}++;
			   $$synfile_hash{"$elem\t$item_category\t$corrected_sentence"}++;

			   if ($do_testsentence) {
				   $temp_elem = $elem;
				   $$wordnet_args{"synonym_modified_corrected"}[$synonym_sentence_order] = $temp_elem;
			   }

			   $elem =~ s/\+(n|a|v|l)\+((\d)+)//g;

			   if ($use_original_wavfiles) {
				 @$original_wavfile_array[$synonym_sentence_order] = "synonym";
			   }

			   @$original_transcription_array[$synonym_sentence_order] = $elem;
			   @$pseudo_corrected_array[$synonym_sentence_order] = $elem;
#	   print "herexxxfinalarray999999999999999999: exit: elem=$elem\n";
			   @$synonym_corrected_array[$temp_sentence_order] = $elem;

			   if (!$contains_categories) {
				   $$wordnet_args{"synonym_corrected"}{$synonym_sentence_order} = $sentence_order;
				   $$wordnet_args{"reverse_synonym_corrected"}{$sentence_order}{$synonym_sentence_order}++;
			   }

			   @$original_cat_array[$synonym_sentence_order] = $item_category;

			   $synonym_sentence_order++;
			   $temp_sentence_order++;
		   }
	   }
   }

   return($synonym_sentence_order, $temp_sentence_order);
}

sub AutoTag
{
   my($wordnet_args, $sentence_order, $wordbag_compressed_alias_sentence, $wordnet_pointer_hash, $wordnet_hash, $pos_only_hash, $default_pos_hash, $pos_corrected_array, $replacement_frequency_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash) = @_;

   my($alt_default_pos);
   my($compressed_word_num);
   my($default_pos);
   my($elem);
   my($new_compressed_sentence) = "";
   my($pointer);
   my($pos);
   my($replacement);
   my($temp_compressed_sentence) = $wordbag_compressed_alias_sentence;
   my(@replacement_in_array);
   my(@replacement_out_array);
   my(@unique_array);
   my(@word_array);
   my(@word_pos_array);

   if ($$wordnet_args{"wordnet_available"}) {
	   $temp_compressed_sentence =~ s/ //g;
	   $compressed_word_num = length($wordbag_compressed_alias_sentence) - length($temp_compressed_sentence) + 1;

	   @word_pos_array = ();
	   if (@$pos_corrected_array[$sentence_order] ne "") {
#		 print "herewww111: sentence_order=$sentence_order, ", @$pos_corrected_array[$sentence_order], "\n";
		   @word_pos_array = split " ", @$pos_corrected_array[$sentence_order];
	   }

	   @word_array = split " ", $wordbag_compressed_alias_sentence;

	   foreach $elem (@word_array){
		   $pos = $$pos_only_hash{$elem};
#		   print "herewww111a: elem=$elem,pos=$pos \n";
		   if (not defined $pos) {
			   $pos = "";
			   if ((scalar @word_pos_array) > 0) {
				   @unique_array = grep (/\b$elem\b/, @word_pos_array);
				   if ((scalar @unique_array) > 0) {
#					   $pos = "noun";
					   if ($unique_array[0] =~ /\#v/) {
						   $pos = "verb";
					   } elsif ($unique_array[0] =~ /\#a/) {
						   $pos = "adjective";
					   }
				   }

				   @unique_array = ();
			   }
		   }

		   $replacement = "";
#	   print "\n\nherezzzutoassign4444444444444444444444444444a: default_pos=$default_pos, pos=$pos, word=$elem\n";
		   if ($pos ne "") {
			   $pointer = $$wordnet_pointer_hash{$pos}{$elem};
			   if (defined $pointer) {
				   $replacement = join ":", @{$$wordnet_hash{$pos}{$pointer}};
#			   print "herezzzutoassign4444444444444444444444444444a11111: pos=$pos, pointer=$pointer, replacement=$replacement, word=$elem\n";
			   }
		   }

#	   print "\n\nherezzzutoassign6666666666666666666666666666666a: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
		   if ($replacement eq "") {
			   $default_pos = $$wordnet_args{"add_wordnet_pos"}{$elem};
			   if (not defined $default_pos) {
				   $default_pos = $$wordnet_args{"alt_default_pos"}{$elem};
			   }

			   if (not defined $default_pos) {
				   $default_pos = $$wordnet_args{"alt_syn_default_pos"}{$elem};
			   }

			   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
			   if ((defined $pointer)) {
				   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
			   }
		   }

#	   print "herezzzutoassign77777777777777777777777777a: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
		   if ($replacement eq "") {
			   $default_pos = $$default_pos_hash{$elem};

			   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
			   if ((defined $pointer) && ($default_pos eq "verb")) {
				   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
			   }
		   }

#	   print "herezzzutoassign77777777777777777777777777b: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
		   if ($replacement eq "") {
			   $default_pos = $$default_pos_hash{$elem};
			   $alt_default_pos = getPosFromSuffix($elem, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash);

			   if ($default_pos eq $alt_default_pos) {
				   $pointer = $$wordnet_pointer_hash{$default_pos}{$elem};
				   if ((defined $pointer) && ($default_pos ne "verb")) {
					   $replacement = join ":", @{$$wordnet_hash{$default_pos}{$pointer}};
				   }
			   }
		   }

#	   print "herezzzutoassign7777777777777777777777777c: default_pos=$default_pos, pos=$pos, replacement=$replacement, word=$elem\n";
		   if ($replacement eq "") {
			   $replacement = $elem;
		   }

		   if ($replacement ne "") {
			   $replacement =~ s/\+(n|a|v|l)\+((\d)+)//g;
		   }

		   if ($replacement ne $elem) {
			 if ($replacement =~ /\:/) {
			   @replacement_in_array = split ":", $replacement;
			   keys my %or_cache = @replacement_in_array;
			   @replacement_out_array = sort {
				 ($or_cache{$a} ||= $a)
				   cmp
					 ($or_cache{$b} ||= $b)
				   } @replacement_in_array;

			   $replacement = join ":", @replacement_out_array;

			 }

			 if ($pos ne "") {
			   $$replacement_frequency_hash{"$pos:$replacement"}++;
			 } elsif ($default_pos ne "") {
			   $$replacement_frequency_hash{"$default_pos:$replacement"}++;
			 } else {
			   $$replacement_frequency_hash{"UNKNOWN_POS:".$replacement}++;
			 }
		   }

#	   print "herezzzutoassign77777777777777777777777777d: replacement=$replacement, pos=$pos, word=$elem\n";
		   $new_compressed_sentence = stringBuilder($new_compressed_sentence, $replacement, " ");
	   }
   } else {
	   $new_compressed_sentence = $wordbag_compressed_alias_sentence;
   }

   return ($new_compressed_sentence);
}

sub AutoTagFilterSingles
{
   my($wordnet_args, $elem, $counta, $auto_max, $total_auto_cats_assigned, $auto_cats_total_hash, $total_auto_cats_assigned_hash, $corrected_array, $auto_single_used_hash, $level) = @_;

   my($new_counta) = $counta;
   my($new_elem);
   my($new_auto_max);

   if (($$auto_cats_total_hash{$counta} == 1) && (not defined $$auto_single_used_hash{$elem})) {
	   $new_elem = $auto_max;
	   if ((not defined $$auto_single_used_hash{$new_elem})) {
		   $new_auto_max = $$wordnet_args{"auto_ordered_minus_max"}[$new_elem];
		   $new_counta = $$total_auto_cats_assigned_hash{$new_auto_max};

		   if ($new_counta != $counta) {
			   $$auto_single_used_hash{$elem}++;
			   ($total_auto_cats_assigned, $new_counta) = AutoTagFilterSingles($wordnet_args, $new_elem, $new_counta, $new_auto_max, $total_auto_cats_assigned, $auto_cats_total_hash, $total_auto_cats_assigned_hash, $corrected_array, $auto_single_used_hash, $level+1);

			   if ($level == 0) {
				   $$auto_cats_total_hash{$counta}--;
				   $total_auto_cats_assigned--;
				   $$auto_cats_total_hash{$new_counta}++;
			   }
		   }
	   }
   }

   return ($total_auto_cats_assigned, $new_counta);
}

sub AutoTagFinal_save
{
   my($wordnet_args, $language_suffix, $autotag_sentence, $replacement_frequency_hash) = @_;

   my($combo);
   my($higher_freq_found);
   my($elem);
   my($elem1);
   my($elem2);
   my($found);
   my($lastchar);
   my($linenum);
   my($maxval);
   my($max_item_frequency_seen);
   my($orig_sentence);
   my($sentence);
   my($sentence_counter) = 0;
   my($temp_autotag_sentence);
   my($word);
   my(%auto_assign_hash);
   my(%auto_ordered_minus_hash);
   my(%likeness_hash);
   my(%sentence_repeat_hash);
   my(%temp_auto_hash);
   my(@auto_ordered_array);
   my(@permanent_array);
   my(@presence_array);
   my(@sentence_array);
   my(@temp_array);
   my(@temp_auto_ordered_array);
   my(@word_array);

   if ((scalar keys %{$replacement_frequency_hash}) > 0) {
	   open(REPFREQ,">"."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix";
#	   @replacement_ordered_array =
#					   map  $_->[0] =>
#					   sort { $$replacement_frequency_hash{$b->[2]} <=> $$replacement_frequency_hash{$a->[2]} || $a->[1] cmp $b->[1] }
#			           map  [ $_, $_, $_ ]
#					   => (keys %{$replacement_frequency_hash});

#	   foreach $elem (@replacement_ordered_array) {
	   foreach $elem ( sort { $a cmp $b } keys %{$replacement_frequency_hash}) {
		   print REPFREQ "$elem\t", $$replacement_frequency_hash{$elem}, "\n";
	   }

	   close(REPFREQ);

	   DebugPrint ("BOTH", 1, "AutoTagFinal_1", $debug, $err_no++, "WordNet Autotag Replacement Frequency File created: "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix");
   }

   $lastchar = substr($autotag_sentence,length($autotag_sentence)-1,1);
   if ($lastchar ne "\º") {
	 $autotag_sentence = $autotag_sentence."\º";
   }

   @sentence_array = split /\º/, $autotag_sentence;
   @permanent_array = split /\º/, $autotag_sentence;

   foreach $orig_sentence (@sentence_array) {
	   $sentence = $orig_sentence;
	   $orig_sentence = quotemeta($orig_sentence)."\º";

	   $sentence =~ s/\[((\d)+)\]//g;

	   if (defined $sentence_repeat_hash{$sentence}) {
		 $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter] = $sentence_repeat_hash{$sentence};
		 @temp_array = split ":", $sentence_repeat_hash{$sentence};
		 $max_item_frequency_seen = -9;
		 foreach $elem (@temp_array) {
		   $likeness_hash{$sentence_counter}{$elem}{$max_item_frequency_seen}++;
		 }

	   } else {
		   $combo = "";
		   if ((lc($sentence) !~ /\*blank\*/) && ($sentence ne "")) {
			   @word_array = split " ", $sentence;
			   foreach $elem (@word_array) {
				   $found = 0;
				   if ( not defined $auto_assign_hash{$elem}) {
					   $temp_autotag_sentence = "";
					   $word = quotemeta($elem);
					   @presence_array = grep (/\b$word\b/, @permanent_array);
					   foreach $elem1 (@presence_array) {
						   if ($elem1 =~ /\[((\d)+)\]/) {
							 $linenum = $1;
							 $temp_autotag_sentence = stringBuilder($temp_autotag_sentence, $linenum, " ");
						   }
					   }

					   if (index($temp_autotag_sentence, " ") != -1) {
						   $found = 1;
						   $auto_assign_hash{$elem} = $temp_autotag_sentence;
					   }
				   } else {
					   $found = 1;
				   }

				   if ($found) {
					 $combo = stringBuilder($combo, $auto_assign_hash{$elem}, " ");
				   }
			   }

			   if ($combo eq "") {
				   $combo = $sentence_counter;
			   } else {
				 $combo =~ s/\b$sentence_counter //g;
				 $combo =~ s/ $sentence_counter$//g;
				 $combo = $combo." ".$sentence_counter;
			   }
		   }

		   if ($combo eq "") {
				 $likeness_hash{$sentence_counter}{-1}{1}++;
			   $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter] = -1;
		   } else {
			   undef %auto_ordered_minus_hash;
			   undef %temp_auto_hash;
			   $maxval = -9999999;
			   $max_item_frequency_seen = -9999999;
			   $higher_freq_found = 0;
			   @temp_auto_ordered_array = split " ", $combo;
			   foreach $elem (@temp_auto_ordered_array) {
				   if (defined $temp_auto_hash{$elem}) {
					   $higher_freq_found = 1;
				   }

				   $temp_auto_hash{$elem}++;
				   if ($temp_auto_hash{$elem} > $max_item_frequency_seen) {
					   $max_item_frequency_seen = $temp_auto_hash{$elem};
				   }

				   if ($elem > $maxval) {
					   $maxval = $elem;
				   }
#		   print "herexxx8888888888: combo=$combo, elem=$elem, higher_freq_found=$higher_freq_found, max_item_frequency_seen=$max_item_frequency_seen, maxval=$maxval\n";
			   }

			   if ($higher_freq_found) {
				 my($listcnt) = 0;
				 my($build_string) = "";
#		   print ">>>>>>>>>>>>>>>>>>>>>>>>>>>herexxx8888888888-2: ignore\n";
				 foreach $elem ( sort { $temp_auto_hash{$b} <=> $temp_auto_hash{$a} } keys %temp_auto_hash) {
				   if ($temp_auto_hash{$elem} < $max_item_frequency_seen) {
					 last;
				   } else {
					 $auto_ordered_minus_hash{$elem}++;
					 $listcnt++;
				   }
				 }

				 foreach $elem ( sort { $a <=> $b } keys %auto_ordered_minus_hash) {
				   $likeness_hash{$sentence_counter}{$elem}{$max_item_frequency_seen}++;
				 }

				 undef %temp_auto_hash;

				   @auto_ordered_array =
					   map  $_->[0] =>
					   sort { $auto_ordered_minus_hash{$b->[2]} <=> $auto_ordered_minus_hash{$a->[2]} || $b->[1] <=> $a->[1] }
			           map  [ $_, $_, $_ ]
					   => (keys %auto_ordered_minus_hash);

				 foreach  $elem (@auto_ordered_array) {
				   $build_string = stringBuilder($build_string, $elem, ":");
				 }

				 open(TEMPREC,">>"."slmdirect_results\/temp_record") or die "cant open "."slmdirect_results\/temp_record";
				 print TEMPREC "max_item_frequency_seen=$max_item_frequency_seen, orig_sentence=$orig_sentence, build_string=$build_string\n";
				 print TEMPREC "max_item_frequency_seen=$max_item_frequency_seen, sentence=$sentence, build_string=$build_string\n\n";
				 close(TEMPREC);



#				   $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter] = $auto_ordered_array[0];
				 $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter] = $build_string;
			   } else {
#		   print "herexxx999999999999999999b1: sentence=$sentence\n";

				 $likeness_hash{$sentence_counter}{$maxval}{1}++;

				 $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter] = $maxval;
			   }
		   }

#		   print "herexxx999999999999999999b1: auto_ordered_array0=", $auto_ordered_array[0], ", auto_ordered_array1=", $auto_ordered_array[1], "\n";
#		   print "herexxx999999999999999999b2: auto_ordered_minus_max=", $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter], "\n";
		   $sentence_repeat_hash{$sentence} = $$wordnet_args{"auto_ordered_minus_max"}[$sentence_counter];
	   }

	   $sentence_counter++;
	   $autotag_sentence =~ s/$orig_sentence//;
	   $autotag_sentence = TrimChars($autotag_sentence);

#	   $temp_autotag_sentence = $autotag_sentence;
	   if (($sentence_counter+1)/500 == int(($sentence_counter+1)/500)) {
		   print "&".($sentence_counter+1);
	   } elsif (($sentence_counter+1)/100 == int(($sentence_counter+1)/100)) {
		   print "*".($sentence_counter+1);
	   } elsif (($sentence_counter+1)/10 == int(($sentence_counter+1)/10)) {
		   print ".";
	   }
   }

   print "\n\n";

   foreach $elem ( sort { $a <=> $b } keys %likeness_hash) {
	 print "elem=$elem:\n";
	 foreach $elem1 ( sort { $a <=> $b } keys %{$likeness_hash{$elem}}) {
	   print "\telem1=$elem1:\n";
	   foreach $elem2 ( sort { $a <=> $b } keys %{$likeness_hash{$elem}{$elem1}}) {
		 print "\t\telem2=$elem2\n";
	   }

	   print "\n\n";
	 }
   }

}

sub AutoTagFinal
{
   my($meaning_args, $wordnet_args, $language_suffix, $autotag_sentence, $replacement_frequency_hash, $corrected_array, $compressed_sentence_array, $original_wavfile_array, $original_transcription_array) = @_;

   my($assigned_category);
   my($category_build_string);
   my($elem);
   my($i);
   my($lastchar);
   my($sentence);
   my($sentence_counter) = 0;
   my($temp_autotag_sentence);
   my($temp_cat_string);
   my($temp_elem);
   my($word);
   my($word_found);
   my(%auto_cats_total_hash);
   my(%sentence_repeat_hash);
   my(%test_category_hash);
   my(@category_assignment_array);
   my(@orig_sentence_array);
   my(@search_array);
   my(@sentence_array);
   my(@temp_array);
   my(@word_array);

   if ((scalar keys %{$replacement_frequency_hash}) > 0) {
	   open(REPFREQ,">"."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix";
#	   @replacement_ordered_array =
#					   map  $_->[0] =>
#					   sort { $$replacement_frequency_hash{$b->[2]} <=> $$replacement_frequency_hash{$a->[2]} || $a->[1] cmp $b->[1] }
#			           map  [ $_, $_, $_ ]
#					   => (keys %{$replacement_frequency_hash});

#	   foreach $elem (@replacement_ordered_array) {
	   foreach $elem ( sort { $a cmp $b } keys %{$replacement_frequency_hash}) {
		   print REPFREQ "$elem\t", $$replacement_frequency_hash{$elem}, "\n";
	   }

	   close(REPFREQ);

	   DebugPrint ("BOTH", 1, "AutoTagFinal_1", $debug, $err_no++, "WordNet Autotag Replacement Frequency File created: "."slmdirect_results\/createslmDIR_wordnet_files\/info_wordnet_autotag_replacement_frequency"."$language_suffix");
   }

   $lastchar = substr($autotag_sentence,length($autotag_sentence)-1,1);
   if ($lastchar ne "\º") {
	 $autotag_sentence = $autotag_sentence."\º";
   }

   $temp_autotag_sentence = $autotag_sentence;
   $temp_autotag_sentence =~ s/\[((\d)+)\]//g;

   collapseSentenceWithWordTotals($meaning_args, 20, $temp_autotag_sentence, \%test_category_hash, 0, 0);
   @sentence_array = split /\º/, $temp_autotag_sentence;

   foreach $sentence (@sentence_array) {
	 if (defined $sentence_repeat_hash{$sentence}) {
	   $assigned_category = $sentence_repeat_hash{$sentence};
	 } else {
	   if ((lc($sentence) =~ /\*blank\*/) || ($sentence eq "")) {
		 $assigned_category = "GARBAGE_REJECT";
	   } else {
		 @word_array = split " ", $sentence;
		 if (scalar(@word_array) > $$meaning_args{"sentence_length_for_scan"}) {
		   $sentence_counter++;
		   $category_build_string = "";

		   $assigned_category = "UNKNOWN";

		   next;
		 }

		 $category_build_string = "";
		 @orig_sentence_array = split " ", @$compressed_sentence_array[$sentence_counter];
		 foreach $elem (sort { $a <=> $b } @word_array) {
		   $temp_elem = $elem;
		   $temp_elem =~ s/_alias//g;
		   $temp_elem =~ s/\^//g;
		   if ((defined $test_category_hash{$elem}) || (defined $$meaning_args{"explicit_categories"}{$temp_elem})) {
			 $elem =~ s/_alias//g;
			 $elem =~ s/\^//g;
			 if ($elem =~ /\:/) {
			   @temp_array = split ":", $elem;
			   $word_found = 0;
			   foreach $word (sort { $a cmp $b } @temp_array) {
				 @search_array = grep {/\b$word\b/} @orig_sentence_array;
				 if (scalar (@search_array) > 0) {
				   $word_found = 1;
				   $elem = $search_array[0];
				 }
			   }

			   if (!$word_found) {
				 $elem = $temp_array[0];
			   }
			 }

			 $temp_cat_string = $category_build_string;
			 $temp_cat_string =~ s/\_/ /g;
			 $temp_elem = $elem;
			 $temp_elem =~ s/\_/ /g;

			 if ($temp_cat_string !~ /\b$temp_elem\b/) {
			   $category_build_string = stringBuilder($category_build_string, $elem, "_");
			 }
		   }
		 }

		 if ($category_build_string eq "") {
		   $assigned_category = "UNKNOWN";
		 } else {
		   if ($category_build_string =~ /\_/) {
			 $temp_cat_string = $category_build_string;
			 $temp_cat_string =~ s/\_/ /g;

			 $category_build_string = CheckSkipPhrase("loc1", $meaning_args, $wordnet_args, $temp_cat_string);
			 $category_build_string =~ s/\ /\_/g;
		   }

		   $assigned_category = $category_build_string;
		 }
	   }

	   $sentence_repeat_hash{$sentence} = $assigned_category;
	 }

	 $category_assignment_array[$sentence_counter] = $assigned_category;
	 $auto_cats_total_hash{$assigned_category}++;
	 $sentence_counter++;

	 if (($sentence_counter+1)/500 == int(($sentence_counter+1)/500)) {
	   print "&".($sentence_counter+1);
	 } elsif (($sentence_counter+1)/100 == int(($sentence_counter+1)/100)) {
	   print "*".($sentence_counter+1);
	 } elsif (($sentence_counter+1)/10 == int(($sentence_counter+1)/10)) {
	   print ".";
	 }
   }

   open(AUTOOUT,">"."slmdirect_results\/createslm_auto_assign") or die "cant write "."slmdirect_results\/createslm_auto_assign";
   print AUTOOUT "Filename\tTranscription\tword group\tsub\/alt\tNotes\/Comments\tCheck transcription\tfrequency\tcorrected sentence\tcompressed sentence\tsequence\n";
   for ($i = 0; $i < $sentence_counter; $i++) {
	 print AUTOOUT @$original_wavfile_array[$i]."\t".@$original_transcription_array[$i]."\t".$category_assignment_array[$i]."\t\t\t\t".$auto_cats_total_hash{$category_assignment_array[$i]}."\t".@$corrected_array[$i]."\t".@$compressed_sentence_array[$i]."\t$i\n";
   }

   close(AUTOOUT);

   DebugPrint ("BOTH", 1, "AutoTagFinal_2", $debug, $err_no++, "Auto Assign File created: "."slmdirect_results\/createslm_auto_assign");

   DebugPrint ("BOTH", 1, "AutoTagFinal_3", $debug, $err_no++, scalar(keys %auto_cats_total_hash)." Total Categories Assigned");
}

sub FindPreWordsInSentence
{
    my($sentence, $meaning_args, $wordnet_args) = @_;

	my($compressed_sentence);
	my($elem1);
	my($filtered_word);
	my($filtered_sentence);
	my($temp_sentence);
	my(%filtered_word_hash);
	my(@word_array);

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"verb"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#v)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2a: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"verb_to"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#v)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2b: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"noun_to"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+(\b(my|the|an|a|your|our|her|his)\b) ((\w|\_|\')+))/($5\#o)/g;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#o)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2c: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"could_i"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#v)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2d: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"could_you"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#v)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2e: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"noun"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+(\b(my|the|an|a|your|our|her|his)\b) ((\w|\_|\')+))/($5\#o)/g;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#o)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2f: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"how_much_does"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+(\b(my|the|an|a|your|our|her|his)\b) ((\w|\_|\')+))/($5\#o)/g;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#o)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2g: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

	foreach $elem1 ( sort { length($b) cmp length($a) } keys %{$$meaning_args{"pre"}{"how_much_do"}}) {
		$temp_sentence = $sentence;
		$sentence =~ s/((\b$elem1)\s+(\b(my|the|an|a|your|our|her|his)\b) ((\w|\_|\')+))/($5\#o)/g;
		$sentence =~ s/((\b$elem1)\s+((\w|\_|\')+))/($3\#o)/g;
		if ($sentence ne $temp_sentence) {
#			print "herexxx2h: $elem1:\ntemp_sentence=$temp_sentence\n\nsentence=$sentence\n\n";
		}
	}

#	print "herexxx2i: sentence=$sentence\n\n";
	$sentence =~ s/(\w|\_|\')+\s//g;
	$sentence =~ s/(\w|\_|\')+\º/\º/g;
	$sentence =~ s/\(//g;
	$sentence =~ s/\)//g;
	$sentence =~ s/ \º/\º/g;
	$sentence =~ s/\º /\º/g;

	$temp_sentence = $sentence;
	$temp_sentence =~ s/\º/ /g;
	$temp_sentence =~ tr/ / /s;
	@word_array = split " ", $temp_sentence;
	foreach $elem1 (@word_array) {
	  $filtered_word = $elem1;
	  if ($filtered_word !~ /\#/) {
		next;
	  }
#	print "herexxx2j1: filtered_word=$filtered_word\n\n";
	  $filtered_word =~ s/(\#o|\#v)//g;
	  $filtered_word_hash{$filtered_word} = $elem1;
	}

	$filtered_sentence = $sentence;
	$filtered_sentence =~ s/(\#o|\#v)//g;
	$filtered_sentence =~ s/\º/\ \+\+\+\ /g;

	$compressed_sentence = CheckSkipPhrase("loc2", $meaning_args, $wordnet_args, $filtered_sentence);
	$compressed_sentence =~ s/\ \+\+\+\ /\º/g;
	$compressed_sentence =~ s/\+\+\+\ /\º/g;
	$compressed_sentence =~ s/\+\+\+/\º/g;

#	print "herexxx2j2: sentence=$sentence\n\n";
	foreach $elem1 ( sort { $a cmp $b } keys %filtered_word_hash) {
	  $compressed_sentence =~ s/$elem1/$filtered_word_hash{$elem1}/g;
	}

#	print "herexxx2k: compressed_sentence=$compressed_sentence\n\n";
	return ($compressed_sentence);
}

sub analyzeSentenceStructure
{
  my($general_args, $meaning_args, $sentence) = @_;

  my($articles) = " a an the my your our her his their this these those ";
  my($current_word);
  my($excluded_prepositions) = " onto into on in of off for by over under to with ";
  my($excluded_verbs) = " have be is am are want like need need_to_talk need_to_speak ";
  my($excluded_words) = " right you me her him ";
  my($loc);
  my($loc1);
  my($loc2);
  my($loc3);
  my($new_sentence) = "";
  my($sentence_segment);
  my($test_word);
  my($verb_words) = " to onto into ";
  my($word);
  my($word_counter) = 0;
  my(@sentence_array);
  my(@word_array);

  @sentence_array = split /\º/, $sentence;
  foreach $sentence_segment (@sentence_array) {
	@word_array = split " ", $sentence_segment;
	$word_counter = 0;
	foreach $word (@word_array){
	  $loc = -1;
	  if ((substr($word, length($word)-4, 4) eq "tion") || (substr($word, length($word)-4, 4) eq "ness")) {
		if ($word !~ /\#/) {
		  $word = "$word#n";
		  $loc = 1;
		}
	  }

	  if ($loc == -1) {
		if (($word_counter-1) > 0) {
		  $test_word = " ".$word_array[$word_counter-1]." ";
		  $current_word = " $word ";
		  $loc = index($articles, $test_word);
		  if ($loc != -1) {
			$loc = index($excluded_prepositions, $current_word);
			$loc1 = index($excluded_verbs, $current_word);
			if (($loc == -1) && ($loc1 == -1) && ($word !~ /\'/) && ($word !~ /\#/)) {
			  $word = "$word#n";
			}
		  } else {
			$loc = index($verb_words, $test_word);
			$loc1 = index($excluded_prepositions, $current_word);
			$loc2 = index($articles, $current_word);
			$loc3 = index($excluded_verbs, $current_word);
			if (($loc != -1) && ($loc1 == -1) && ($loc2 == -1) && ($loc3 == -1) && ($word !~ /\#/)) {
			  $word = "$word#v";
			}
		  }
		}
	  }

	  if (($word_counter+1) < scalar(@word_array)) {
#	  print "herewww111b2a: word_counter=$word_counter, word=$word\n";
		$test_word = " ".$word_array[$word_counter+1]." ";
		$current_word = " $word ";
		$loc = index($articles, $test_word);
		if ($loc != -1) {
		  $loc = index($excluded_verbs, $current_word);
		  $loc1 = index($excluded_prepositions, $current_word);
		  $loc2 = index($excluded_words, $current_word);
		  if (($loc == -1) && ($loc1 == -1) && ($loc2 == -1) && ($word !~ /\#/)) {
			$word = "$word#v";
		  }
		} else {
		  $loc = index($verb_words, $test_word);
		  $loc1 = index($excluded_verbs, $current_word);
		  if (($loc != -1) && ($loc1 == -1) && ($word !~ /\#/)) {
			$word = "$word#v";
		  }
		}
	  }
#	  print "herewww111b2b: word=$word\n";

	  $new_sentence = stringBuilder($new_sentence, $word, " ");

	  $word_counter++;
	}

	$new_sentence = $new_sentence."º";
  }

  $new_sentence =~ s/\º /\º/g;
#  print "\n\nherewww111b3a: new_sentence=$new_sentence\n";
  $new_sentence = ApplyCoNounCorrection($general_args, $meaning_args, $new_sentence);
#  print "\n\nherewww111b3b: new_sentence=$new_sentence\n";

  return ($new_sentence);
}

#################### END WORDNet SUBROUTINES #########################

######################################################################
######################################################################
############# Tagging SUBROUTINES ####################################
######################################################################
######################################################################

sub makeTaggingFile
{
	my($container_file_in) = @_;

	my($pre_search_string) = "";
	my($elem);
	my($filesize);
	my($readlen);

	my(@word_array);

	$pre_search_string = "";

	open(TAGGINGIN,"<$container_file_in") or die "cant open $container_file_in";
	$filesize = -s TAGGINGIN;
	$readlen = sysread TAGGINGIN, $pre_search_string, $filesize;
	close (TAGGINGIN);

	$pre_search_string = ChopChar($pre_search_string);

	$pre_search_string =~ s/$char13\n/ /g;
	$pre_search_string =~ s/$char13/ /g;
	$pre_search_string =~ s/\n/ /g;
	$pre_search_string =~ tr/ / /s;

	$pre_search_string =~ s/\,|\:|\(|\)|\.|\||\#/ /g;

	$pre_search_string = TrimChars($pre_search_string);

	collapseSentence($pre_search_string, \@word_array, 0, 0);

	open(TAGGING,">tagging-filter.txt") or die "cant write tagging-filter.txt";

	foreach $elem (@word_array) {
		if (lc($elem) =~ /sg_|fg_|dg_|noun_|action_|adj_/) {
			print TAGGING "$elem\n";
		}
	}

	close(TAGGING);
}


sub splitSentence
{
   my($corrected_sentence, $tag_sentence_array, $max_tag_sentence_length) = @_;

   my($loc);
   my($scount) = 0;
   my($sentence_len) = length($corrected_sentence);
   my($startchar);
   my($startpos) = 0;
   my($startsearch) = $max_tag_sentence_length;

   ($loc, $startchar) = FindFirstChar($startsearch, "º", "", "", $corrected_sentence);
   while ($loc != -1) {
	   if ($startsearch > $sentence_len) {
		   @$tag_sentence_array[$scount] = substr($corrected_sentence, $startpos);
		   last;
	   } else {
		   @$tag_sentence_array[$scount] = substr($corrected_sentence, $startpos, $loc-$startpos+1);
	   }

	   $startpos = $loc + 1;
	   $startsearch = $loc + $max_tag_sentence_length;
	   if ($startsearch <= $sentence_len) {
		   ($loc, $startchar) = FindFirstChar($startsearch, "º", "", "", $corrected_sentence);
	   }

	   $scount++;
   }
}

sub CALL_Nuance_Tagging
{
    my($do_tagging, $corrected_sentence, $max_tag_sentence_length) = @_;

	my($cmd);
	my($filesize);
	my($output);
	my($readlen);
	my($tag_sentence);
	my(@tag_sentence_array);

#	open(READWRITEME, "| nl-tag-tool -package $do_tagging -grammar .Tagging -filter tagging-filter.txt -no_output <slmdirect_results\/createslm_temp_tagging_in >"."slmdirect_results\/createslm_temp_tagging") or die "Couldn't fork: $!\n";

	unlink "slmdirect_results\/createslm_temp_tagging";
	$cmd = "nl-tag-tool -package $do_tagging -grammar .Tagging -filter tagging-filter.txt -no_output <slmdirect_results\/createslm_temp_tagging_in >>"."slmdirect_results\/createslm_temp_tagging";

	if (length($corrected_sentence) > $max_tag_sentence_length) {
		splitSentence($corrected_sentence, \@tag_sentence_array, $max_tag_sentence_length);
		undef $corrected_sentence;
		$corrected_sentence = "";
		foreach $tag_sentence (@tag_sentence_array) {
			unlink "slmdirect_results\/createslm_temp_tagging_in";
			open(READWRITEME, ">"."slmdirect_results\/createslm_temp_tagging_in") or die "Couldn't open $!\n";

			$tag_sentence =~ s/\º/ \º /g;

			print READWRITEME "$tag_sentence\n";

			undef $tag_sentence;

			close(READWRITEME) or die "Couldn't close: $!\n";

			system($cmd);
		}
	} else {
		unlink "slmdirect_results\/createslm_temp_tagging_in";
		open(READWRITEME, ">"."slmdirect_results\/createslm_temp_tagging_in") or die "Couldn't open $!\n";

		$corrected_sentence =~ s/\º/ \º /g;

		print READWRITEME "$corrected_sentence\n";

		undef $corrected_sentence;

		close(READWRITEME) or die "Couldn't close: $!\n";

		system($cmd);
	}

#	print READWRITEME "$corrected_sentence\n";

#	close(READWRITEME) or die "Couldn't close: $!\n";

	open(READWRITEME, "<"."slmdirect_results\/createslm_temp_tagging") or die "Couldn't open $!\n";
	$filesize = -s READWRITEME;
	$readlen = sysread READWRITEME, $output, $filesize;
	close (READWRITEME);

	$output =~ s/ \º /\º/g;
	$output =~ s/\º /\º/g;
	$output =~ s/ \º/\º/g;
	$output = ChopChar($output);
	$output =~ s/$char13//g;
	$output =~ s/$char10//g;
	$output =~ s/\n\n//g;

	return($output);
}

############# END Tagging SUBROUTINES ####################################

######################################################################
######################################################################
############# Enclosure SUBROUTINES ##################################
######################################################################
######################################################################

sub ProcessPrefix
{
    my($debug, $strval, $startpos, $tcnt, $level_count, $counter, $storage_merge_hash, $expanded_merge_hash, $comp_hash, $rep_array, $expanded_array) = @_;

	my($bcount);
	my($build_string);
	my($composite);
	my($elem);
	my($elem0);
	my($enclosure);
	my($endpos);
	my($i);
	my($item);
	my($loc);
	my($prev_sub_level_count) = 0;
	my($retval) = $strval;
	my($startchar);
	my($sub_level_count) = $level_count + 100;
	my($subretval);
	my($temp_bcount);
	my($temp_retval);

	DebugPrint ("", 1, "ProcessPrefix: Entry", $debug-1, $err_no++, "retval=$retval\n\n");

	$counter++;
	($loc, $startchar) = FindFirstChar($startpos+1, "(", "", "", $retval);
	if ($loc != -1) {
		while ($loc != -1) {
			$endpos = ThisGetClosure($loc, $startchar, $retval, length($retval));
			$enclosure = substr($retval, $loc, $endpos-$loc);
			($subretval) = ProcessPrefix($debug, $enclosure, 0, $tcnt+1, $sub_level_count, $counter, $storage_merge_hash, $expanded_merge_hash, $comp_hash, $rep_array, $expanded_array);

			$retval = substr($retval,0,$loc).$subretval.substr($retval, $endpos);

			($loc, $startchar) = FindFirstChar($startpos+1, "(", "", "", $retval);

			$prev_sub_level_count = $sub_level_count;
			$sub_level_count += 100;
		}
	}

	($loc, $startchar) = FindFirstChar($startpos, "(", "", "", $retval);
	if ($loc != -1) {
		($loc, $startchar) = FindFirstChar($startpos, "|", "", "", $retval);

		if ($loc != -1) {
			while ($loc != -1) {
				$retval = substr($retval,0,$loc)."=".substr($retval, $loc+1);
				$endpos = $loc + 1;

				($loc, $startchar) = FindFirstChar($endpos, "|", "", "", $retval);
			}
		} else {
			if ($tcnt > 1) {
				if ($retval !~ /NULL/) {
					$retval =~ s/\(//g;
					$retval =~ s/\)//g;
				}
			}
		}
	}

	$retval =~ s/\(/\[/g;
	$retval =~ s/\)/\]/g;

	if ($retval =~ /\[/) {
		if (($tcnt > 1) || (($tcnt == 1) && ($retval =~ /\=/)) || ($tcnt == 0)) {
			$composite = $level_count+$counter;

			if (not defined $$comp_hash{$composite}) {
				$$comp_hash{$composite}++;
			} else {
				while (defined $$comp_hash{$composite}) {
					$composite++;
				}

				$$comp_hash{$composite}++;
			}

			@$rep_array = ();
			foreach $elem ( sort { $a cmp $b } keys %{$storage_merge_hash}) {
				if ($retval =~ /$elem/) {
					push (@$rep_array, $elem) ;
				}
			}

			$build_string = "";
			$bcount = 0;
			foreach $elem (@$rep_array) {
				if ($bcount == 0) {
					if ((scalar @$rep_array) == 1) {
						if (($tcnt == 0)) {
							$build_string = "foreach \$elem0 ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$retval;\$temp_retval =~ s/$elem/\$elem0/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;(\@\$expanded_array) = split \"=\", \$temp_retval;foreach \$item (\@\$expanded_array) {\$\$storage_merge_hash{$composite}{\$item}++;\$item =~ s\/<NULL> \| <NULL>\/\/g;\$\$expanded_merge_hash{\$item}++;}}";
						} else {
							$build_string = "foreach \$elem0 ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$retval;\$temp_retval =~ s/$elem/\$elem0/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;(\@\$expanded_array) = split \"=\", \$temp_retval;foreach \$item (\@\$expanded_array) {\$\$storage_merge_hash{$composite}{\$item}++;}}";
						}
					} else {
						$build_string = "if (1) {";
						for ($i = 1; $i <= (scalar @$rep_array)-1; $i++) {
							$build_string = $build_string."my(\$elem".$i.");";
						}

						for ($i = 0; $i < (scalar @$rep_array)-1; $i++) {
							$build_string = $build_string."my(\$temp_retval".$i.");";
						}

						$build_string = $build_string." "."foreach \$elem0 ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$retval;\$temp_retval =~ s/$elem/\$elem0/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;\$temp_retval0 = \$temp_retval;";
					}
				} elsif ($bcount == (scalar @$rep_array)-1) {
					$temp_bcount = $bcount - 1;
					if (($tcnt == 0)) {
						$build_string = $build_string." "."foreach \$elem".$bcount." ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$temp_retval".$temp_bcount.";\$temp_retval =~ s/$elem/\$elem".$bcount."/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;(\@\$expanded_array) = split \"=\", \$temp_retval;foreach \$item (\@\$expanded_array) {\$\$storage_merge_hash{$composite}{\$item}++;\$item =~ s\/<NULL> \| <NULL>\/\/g;\$\$expanded_merge_hash{\$item}++;}}";
					} else {
						$build_string = $build_string." "."foreach \$elem".$bcount." ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$temp_retval".$temp_bcount.";\$temp_retval =~ s/$elem/\$elem".$bcount."/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;(\@\$expanded_array) = split \"=\", \$temp_retval;foreach \$item (\@\$expanded_array) {\$\$storage_merge_hash{$composite}{\$item}++;}}";
					}

					for ($i = 0; $i < (scalar @$rep_array)-1; $i++) {
						$build_string = $build_string."}";
					}

					$build_string = $build_string."}";
				} else {
					$temp_bcount = $bcount - 1;
					$build_string = $build_string." "."foreach \$elem".$bcount." ( sort { \$a cmp \$b } keys \%{\$\$storage_merge_hash{$elem}}) {\$temp_retval = \$temp_retval".$temp_bcount.";\$temp_retval =~ s/$elem/\$elem".$bcount."/g;\$temp_retval =~ s\/\\[\|\\]\/\/g;\$temp_retval".$bcount." = \$temp_retval;";
				}

				$bcount++;
			}

			eval($build_string);

			if ($build_string eq "") {
				(@$expanded_array) = split "=", $retval;

				foreach $elem (@$expanded_array) {
					$$storage_merge_hash{$composite}{$elem}++;
				}
			}

			$retval = "[$composite]";
		}
	}

	DebugPrint ("", 1, "ProcessPrefix: Exit", $debug-1, $err_no++, "retval=$retval\n\n");

	return ($retval);
}

sub makeIndentedFile
{
   my($output_xml_file) = @_;

   my($combo);
   my($filesize);
   my($loc);
   my($newloc);
   my($original_xml_file);
   my($pre_search_string);
   my($readlen) = 0;
   my($result_string);
   my($startchar);
   my($startpos) = 0;

   $original_xml_file = $output_xml_file;
   open(ORIGINALXML,"<$original_xml_file") or die "cant open $original_xml_file";
   $filesize = -s ORIGINALXML;
   $readlen = sysread ORIGINALXML, $pre_search_string, $filesize;
   close (ORIGINALXML);

   if ($readlen > 0) {
	 $pre_search_string =~ s/$char13//g;
	 $pre_search_string =~ s/\n//g;
	 $pre_search_string =~ s/\t//g;
	 $pre_search_string =~ tr/ / /s;
	 $pre_search_string =~ s/\> \</></g;
	 $pre_search_string =~ s/\> />/g;
	 $pre_search_string =~ s/ \</</g;

	 open(OUTPUTXML,">$output_xml_file".".aligned") or die "cant write OUTPUTXML";

	 ($loc, $startchar) = FindFirstChar($startpos, "<", "", "", $pre_search_string);
	 while ($loc != -1) {
	   ($result_string, $newloc) = GetXMLClosure($output_xml_file, 0, $loc, $pre_search_string, "", "");

	   if (result_string eq "") {
		 last;
	   }

	  $combo = stringBuilder($combo, $result_string, "\n");

	   $loc = $newloc;
	 }

	 $combo =~ s/(\n){3,}/\n/g;
	 $combo =~ s/(((\t)+)\n)//g;

	 print OUTPUTXML "$combo\n";
	 close (OUTPUTXML);
   }

   DebugPrint ("BOTH", 1, "makeIndentedFile", $debug, $err_no++, "Aligned File created: $output_xml_file".".aligned");
 }

sub makeIndentedString
{
   my($grammar_cand, $pre_search_string) = @_;

   my($char13) = chr(13);
   my($combo) = "";
   my($loc);
   my($newloc);
   my($readlen) = length($pre_search_string);
   my($result_string) = "";
   my($startchar);
   my($startpos) = 0;

   if ($readlen > 0) {
	 $pre_search_string =~ s/$char13//g;
	 $pre_search_string =~ s/\n//g;
	 $pre_search_string =~ s/\t//g;
	 $pre_search_string =~ tr/ / /s;
	 $pre_search_string =~ s/\> \</></g;
	 $pre_search_string =~ s/\> />/g;
	 $pre_search_string =~ s/ \</</g;

	 ($loc, $startchar) = FindFirstChar("makeIndentedString1", $startpos, "<", "", "", $pre_search_string);
	 while ($loc != -1) {
#	   print "hereqqq1a: pre_search_string=$pre_search_string, loc=$loc\n\n\n";
	   ($result_string, $newloc) = GetXMLClosure($grammar_cand, 0, $loc, $pre_search_string, "", "");

	   if (result_string eq "") {
		 last;
	   }

	  $combo = stringBuilder($combo, $result_string, "\n");

	   $loc = $newloc;
	 }
   }

   $combo =~ s/(\n){3,}/\n/g;
   $combo =~ s/(((\t)+)\n)//g;

   DebugPrint ("", 1, "makeIndentedString", $debug, $err_no++, "--- Aligned String created: $combo\n");

   return("$combo");
 }

sub FilterResultString1
{

  my($result_string, $qsopenchar, $sopenchar, $tab_set) = @_;

  $result_string =~ s/\<$qsopenchar/$tab_set<$sopenchar/g;
  $result_string =~ s/\>/\>\n$tab_set\t/g;
  $result_string =~ s/\<\//\n$tab_set\<\//g;

  return($result_string);
}

sub DoSkipChars
{

  my($level, $tab_set, $teststring, $istartptr, $rloc) = @_;

  my($temp_chars);
  my($loc);
  my($result_string) = "";
  my($startchar);

  $temp_chars = substr($teststring, $istartptr, 1);
#  print "DoSkipChars0: level=$level, temp_chars=$temp_chars, istartptr=$istartptr\n\n";
  if ($temp_chars ne "<") {
	($loc, $startchar) = FindFirstChar($istartptr, "<", "", "", $teststring);
	$temp_chars = substr($teststring, $istartptr, $loc-$istartptr);

#	print "DoSkipChars1: level=$level, temp_chars=$temp_chars, istartptr=$istartptr\n\n";

	$result_string = $result_string."\n$tab_set".$temp_chars."\n";
	$rloc = $istartptr+length($temp_chars);
	$istartptr = $rloc;

#	print "DoSkipChars2: level=$level, istartptr=$istartptr, result_string=$result_string\n\n";
  }

  return($istartptr, $rloc, $result_string);
}

sub DoCloseChar
{

  my($level, $tab_set, $teststring, $sclosechar, $istartptr, $rloc, $result_string) = @_;

  my($temp_chars);


  $istartptr = $rloc;
  $temp_chars = substr($teststring, $istartptr+1, length($sclosechar));
#  print "DoCloseChar1: level=$level, temp_chars=$temp_chars, istartptr=$istartptr, sclosechar=$sclosechar\n\n";
  if ($temp_chars eq $sclosechar) {
	$result_string = $result_string."\n$tab_set".substr($teststring, $istartptr, length($sclosechar)+1)."\n";
	$rloc = $istartptr+length($sclosechar)+1;
	$istartptr = $rloc;

#	print "DoCloseChar2: level=$level, istartptr=$istartptr, result_string=$result_string\n\n";
  }

  return($istartptr, $rloc, $result_string);
}

sub GetXMLClosure
{
    my($grammar_cand, $level, $istartptr, $teststring, $above_closure, $above_tab_set) = @_;

	my($closure_found) = 0;
	my($combo) = "";
	my($floc);
	my($i);
	my($lentest);
	my($loc);
	my($match_len);
	my($qsclosechar);
	my($qsclosechar1) = "";
	my($qsopenchar);
	my($qtag);
	my($result_string) = "";
	my($result_string0);
	my($result_string1);
	my($result_string2);
	my($rloc);
	my($sclosechar);
	my($sclosechar1) = "";
	my($sopenchar);
	my($startchar);
	my($tab_set) = "";
	my($tag);
	my($tag_found);
	my($tcnt) = $level;
	my($temp_string);
	my($test_positive);
	my($test_words);
	my($wait) = 0;
	my($local_debug) = $debug;
#	my($local_debug) = 6;
	my($qstring1);
	my($qstring2);

	while (1) {
	  $tab_set = "";
	  ($loc, $startchar) = FindFirstChar($istartptr, " ", ">", ";", $teststring);
	  $lentest = length($teststring);
	  DebugPrint ("", 1, "GetXMLClosure0: ", $local_debug-1, $err_no++, "\n\nlevel=$level\nteststring=$teststring\nlength=$lentest\nistartptr=$istartptr\nloc=$loc\ncombo=\n$combo\n\n");

	  if ($loc == -1) {
		$rloc = $loc;
		$combo = "";

		return ($combo, $rloc);
	  }

	  $tag = substr($teststring, $istartptr+1, $loc-$istartptr-1);

	  if (($tag =~ /\//) || $level > 100) {
		$temp_string = substr($teststring, $istartptr-50, 75);
		$qstring1 = substr($teststring, $istartptr-50, 50);
		$qstring2 = substr($teststring, $istartptr, 25);
		DebugPrint ("", -1, "GetXMLClosure1: ", 6, $err_no++, "\n\n***ERROR*** Possible tag inconsistency at or before the following file position\n\n\t$temp_string at level=$level\n\ntag=$tag\n\nstartchar=$startchar\n\nqstring1=$qstring1\n\nqstring2=$qstring2\n\n");

		exit;
	  }

	  $qtag = quotemeta($tag);

	  for ($i = 0; $i < ($tcnt); $i++) {
		$tab_set = stringBuilder($tab_set, "\t", "");
	  }

	  DebugPrint ("", 1, "GetXMLClosure2: ", $local_debug-1, $err_no++, "\n\nlevel=$level, istartptr=$istartptr, loc=$loc, tag=$tag\n\n");

	  $sopenchar = $tag;

	  $tag_found = 0;
	  if ($sopenchar eq "?xml") {
		$sclosechar = "?>";
	  } elsif ($sopenchar eq "!--") {
		$sclosechar = "-->";
	  } else {
		$sclosechar = "/"."$tag>";
		$sclosechar1 = "/>";
		$tag_found = 1;
	  }

	  $qsopenchar = quotemeta($sopenchar);
	  $qsclosechar = quotemeta($sclosechar);
	  $qsclosechar1 = quotemeta($sclosechar1);

	  pos $teststring = $loc;
	  $test_positive = "<((\\w|\\_|\\-)+)";

	  if ($tag_found) {
		$tag_found = 0;
		if ($sclosechar1 ne "") {
		  if ($teststring =~ /($qsclosechar|$qsclosechar1)/) {
			$tag_found = 1;
		  }
		} else {
		  if ($teststring =~ /($qsclosechar)/) {
			$tag_found = 1;
		  }
		}

		if (!$tag_found) {
		  DebugPrint ("", 3, "GetXMLClosure3: ", 6, $err_no++, "\n\n*** Closing tag: $sclosechar not found: $grammar_cand ***\n\n");

		  exit;
		}
	  }

	  if ($sclosechar1 ne "") {
		if ($teststring =~ /($qsclosechar|$qsclosechar1|$test_positive)/g) {
		  $test_words = $1;
		}
	  } else {
		if ($teststring =~ /($qsclosechar|$test_positive)/g) {
		  $test_words = $1;
		}
	  }

	  $match_len = length($test_words);
	  $floc = pos $teststring;

	  DebugPrint ("", 1, "GetXMLClosure4: ", $local_debug-1, $err_no++, "\n\nlevel=$level, floc=$floc, test_words=$test_words, sclosechar=$sclosechar, sclosechar1=$sclosechar1\n\n");

	  if (($test_words eq $sclosechar) || ($test_words eq $sclosechar1)) {
		$wait = 0;
		$rloc = $floc;

		$result_string = substr($teststring, $istartptr, $floc-$istartptr);

		$result_string = FilterResultString1($result_string, $qsopenchar, $sopenchar, $tab_set);

		$istartptr = $rloc;
		($istartptr, $rloc, $result_string0) = DoSkipChars($level, $tab_set, $teststring, $istartptr, $rloc);

		if ($result_string0 ne "") {
		  $result_string = $result_string."\n".$result_string0;
		  $result_string0 = "";
		}

		($istartptr, $rloc, $result_string, $wait) = DoAboveEnclosure($level, $above_tab_set, $teststring, $above_closure, $istartptr, $rloc, $result_string);

		DebugPrint ("", 1, "GetXMLClosure4a: ", $local_debug-1, $err_no++, "\n\nlevel=$level, wait=$wait, tag=$tag, qsclosechar=$qsclosechar, qsclosechar1=$qsclosechar1, sclosechar=$sclosechar, sclosechar1=$sclosechar1, loc=$loc, floc=$floc, above_closure=$above_closure, test_words=$test_words, match_len=$match_len, result_string0=$result_string0, result_string=\n$result_string\n\n");
		($istartptr, $rloc, $result_string0) = DoSkipChars($level, $tab_set, $teststring, $istartptr, $rloc);

		if ($result_string0 ne "") {
		  $result_string = $result_string."\n".$result_string0;
		  $result_string0 = "";
		}

		DebugPrint ("", 1, "GetXMLClosure5: ", $local_debug-1, $err_no++, "\n\nlevel=$level, wait=$wait, tag=$tag, qsclosechar=$qsclosechar, qsclosechar1=$qsclosechar1, sclosechar=$sclosechar, sclosechar1=$sclosechar1, loc=$loc, floc=$floc, above_closure=$above_closure, test_words=$test_words, match_len=$match_len, result_string0=$result_string0, result_string=\n$result_string\n\n");

	  } else {
		$wait = 0;
		DebugPrint ("", 1, "GetXMLClosure6: ", $local_debug-1, $err_no++, "\n\nlevel=$level, floc=$floc, match_len=$match_len, sclosechar=$sclosechar, above_closure=$above_closure, test_words=$test_words\n\n");

		$result_string1 = substr($teststring, $istartptr, $floc-$istartptr-$match_len);

		($result_string2, $rloc) = GetXMLClosure($grammar_cand, $level+1, $floc-$match_len, $teststring, $sclosechar, $tab_set);
		DebugPrint ("", 1, "GetXMLClosure6a: ", $local_debug-1, $err_no++, "\n\nlevel=$level, result_string2=$result_string2, rloc=$rloc\n\n");
		$result_string1 = FilterResultString1($result_string1, $qsopenchar, $sopenchar, $tab_set);

		$result_string = $result_string1."\n".$result_string2;

		DebugPrint ("", 1, "GetXMLClosure6b: ", $local_debug-1, $err_no++, "\n\nlevel=$level, result_string=$result_string\n\n");
		$istartptr = $rloc;
		($istartptr, $rloc, $result_string0) = DoSkipChars($level, $tab_set, $teststring, $istartptr, $rloc);
		DebugPrint ("", 1, "GetXMLClosure6c: ", $local_debug-1, $err_no++, "\n\nlevel=$level, result_string=$result_string\n\n");
		if ($result_string0 ne "") {
		  $result_string = $result_string."\n".$result_string0;
		}

		DebugPrint ("", 1, "GetXMLClosure6d: ", $local_debug-1, $err_no++, "\n\nlevel=$level, result_string0=$result_string0, result_string=$result_string\n\n");
#		($istartptr, $rloc, $result_string, $closure_found) = DoCloseChar($level, $above_tab_set, $teststring, $sclosechar, $istartptr, $rloc, $result_string);
		$closure_found = 0;
#		DebugPrint ("", 1, "GetXMLClosure6e: ", $local_debug-1, $err_no++, "\n\nlevel=$level, result_string=$result_string, rloc=$rloc, istartptr=$istartptr\n\n");
		($istartptr, $rloc, $result_string, $wait) = DoAboveEnclosure($level, $above_tab_set, $teststring, $above_closure, $istartptr, $rloc, $result_string);
		DebugPrint ("", 1, "GetXMLClosure7: ", $local_debug-1, $err_no++, "\n\nlevel=$level, wait=$wait, above_closure=$above_closure, result_string=\n$result_string, rloc=$rloc, istartptr=$istartptr\n\n");

	  }

	  $combo = stringBuilder($combo, $result_string, "\n");

	  DebugPrint ("", 1, "GetXMLClosure8: ", $local_debug-1, $err_no++, "\n\nlevel=$level, wait=$wait, rloc=$rloc, above_closure=$above_closure, combo=\n$combo\n\n");

	  if (!$wait) {
		last;
	  }

	  DebugPrint ("", 1, "GetXMLClosure9: ", $local_debug-1, $err_no++, "\n\nCONTINUE: level=$level, wait=$wait, rloc=$rloc, above_closure=$above_closure, combo=\n$combo\n\n");
	}

	  DebugPrint ("", 1, "GetXMLClosure10: ", $local_debug-1, $err_no++, "\n\nOUT: level=$level, wait=$wait, rloc=$rloc, above_closure=$above_closure, combo=\n$combo\n\n");

#	$combo =~ s/((\t)+)(\£((\d)+)\£)((\w|\d|\_|\[|\]|\(|\))+)/$1$3$1$6/g;
	return ($combo, $rloc);

}

sub GetClosure_SLMDirect
{
    my($istartptr, $sopenchar, $sclosechar, $teststring) = @_;

	my($ilocstartptr);
	my($openparencnt);
	my($closeparencnt);
	my($testchar);

    $ilocstartptr = $istartptr + 1;

    $openparencnt = 1;
    $closeparencnt = 0;

    while (($openparencnt != $closeparencnt) && $ilocstartptr < 500) {
        $testchar = substr($teststring, $ilocstartptr, 1);
		if ($testchar eq $sopenchar) {
            $openparencnt++;
        } else {
            if ($testchar eq $sclosechar) {
                $closeparencnt++;
            }
		}

        $ilocstartptr++;

	}

	return $ilocstartptr;
}

sub NewGetClosure
{
    my($debug, $istartptr, $sopenchar, $teststring, $maxsearchlen) = @_;

	my($ilocstartptr);
	my($openparencnt);
	my($closeparencnt);
	my($sclosechar);
	my($testchar);

	if ($sopenchar eq "[") {
		$sclosechar = "]";
	} elsif ($sopenchar eq "(") {
		$sclosechar = ")";
	} elsif ($sopenchar eq "{") {
		$sclosechar = "}";
	} elsif ($sopenchar eq "<") {
		$sclosechar = ">";
	}

    $ilocstartptr = $istartptr + 1;

    $openparencnt = 1;
    $closeparencnt = 0;

    while (($openparencnt != $closeparencnt) && (($ilocstartptr - $istartptr) < $maxsearchlen)) {
        $testchar = substr($teststring, $ilocstartptr, 1);
		if ($testchar eq $sopenchar) {
            $openparencnt++;
        } else {
            if ($testchar eq $sclosechar) {
                $closeparencnt++;
            }
		}

        $ilocstartptr++;

	}

	if ($openparencnt != $closeparencnt) {
		DebugPrint ("", 1, "NewGetClosure: openparencnt != closeparencnt", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, ilocstartptr=$ilocstartptr, istartptr=$istartptr, teststring=$teststring, maxsearchlen=$maxsearchlen\n\n");
		$ilocstartptr = -1;
	} else {
		$testchar = substr($teststring, $ilocstartptr, 1);
		DebugPrint ("", 1, "NewGetClosure: openparencnt = closeparencnt-1", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar\n\n");
		if ($testchar eq "~") {
			while (substr($teststring, $ilocstartptr, 1) =~ /\~|\d|\.|\ /) {
				$ilocstartptr++;
			}

			DebugPrint ("", 1, "NewGetClosure: openparencnt = closeparencnt-2", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar, ilocstartptr=$ilocstartptr\n\n");
		}
	}

	return $ilocstartptr;
}

sub GetClosure
{
    my($istartptr, $sopenchar, $teststring, $maxsearchlen) = @_;

	my($ilocstartptr);
	my($openparencnt);
	my($closeparencnt);
	my($sclosechar);
	my($testchar);

	if ($sopenchar eq "[") {
		$sclosechar = "]";
	} elsif ($sopenchar eq "(") {
		$sclosechar = ")";
	} elsif ($sopenchar eq "{") {
		$sclosechar = "}";
	} elsif ($sopenchar eq "<") {
		$sclosechar = ">";
	}

    $ilocstartptr = $istartptr + 1;

    $openparencnt = 1;
    $closeparencnt = 0;

    while (($openparencnt != $closeparencnt) && (($ilocstartptr - $istartptr) < $maxsearchlen)) {
        $testchar = substr($teststring, $ilocstartptr, 1);
		if ($testchar eq $sopenchar) {
            $openparencnt++;
        } else {
            if ($testchar eq $sclosechar) {
                $closeparencnt++;
            }
		}

        $ilocstartptr++;

	}

	if ($openparencnt != $closeparencnt) {
		DebugPrint ("", 1, "GetClosure: openparencnt != closeparencnt", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, ilocstartptr=$ilocstartptr, istartptr=$istartptr, teststring=$teststring, maxsearchlen=$maxsearchlen\n\n");
		$ilocstartptr = -1;
	} else {
		$testchar = substr($teststring, $ilocstartptr, 1);
		DebugPrint ("", 1, "GetClosure: openparencnt = closeparencnt-1", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar\n\n");
		if ($testchar eq "~") {
			while (substr($teststring, $ilocstartptr, 1) =~ /\~|\d|\.|\ /) {
				$ilocstartptr++;
			}

			DebugPrint ("", 1, "GetClosure: openparencnt = closeparencnt-2", $debug-2, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar, ilocstartptr=$ilocstartptr\n\n");
		}
	}

	return $ilocstartptr;
}

sub GetReverseClosure
{
    my($istartptr, $sopenchar, $teststring, $maxsearchlen) = @_;

	my($ilocstartptr);
	my($openparencnt);
	my($closeparencnt);
	my($sclosechar);
	my($testchar);

	if ($sopenchar eq "]") {
		$sclosechar = "[";
	} elsif ($sopenchar eq ")") {
		$sclosechar = "(";
	} elsif ($sopenchar eq "}") {
		$sclosechar = "{";
	} elsif ($sopenchar eq ">") {
		$sclosechar = "<";
	}

    $ilocstartptr = $istartptr - 1;

    $openparencnt = 1;
    $closeparencnt = 0;

    while (($openparencnt != $closeparencnt) && (($istartptr - $ilocstartptr) < $maxsearchlen)) {
        $testchar = substr($teststring, $ilocstartptr, 1);
		if ($testchar eq $sopenchar) {
            $openparencnt++;
        } else {
            if ($testchar eq $sclosechar) {
                $closeparencnt++;
            }
		}

        $ilocstartptr--;

	}

	if ($openparencnt != $closeparencnt) {
		DebugPrint ("", 1, "GetReverseClosure: openparencnt != closeparencnt", $debug-1, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, ilocstartptr=$ilocstartptr, istartptr=$istartptr, teststring=$teststring, maxsearchlen=$maxsearchlen\n\n");
		$ilocstartptr = -1;
	} else {
		$testchar = substr($teststring, $ilocstartptr, 1);
		DebugPrint ("", 1, "GetReverseClosure: openparencnt = closeparencnt-1", $debug-1, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar\n\n");
		if ($testchar eq "~") {
			while (substr($teststring, $ilocstartptr, 1) =~ /\~|\d|\.|\ /) {
				$ilocstartptr++;
			}

			DebugPrint ("", 1, "GetReverseClosure: openparencnt = closeparencnt-2", $debug-1, $err_no++, "\topenparencnt=$openparencnt, closeparencnt=$closeparencnt, testchar=$testchar, ilocstartptr=$ilocstartptr\n\n");
		}
	}

	return $ilocstartptr;
}

sub GetEnclosure
{

    my($grammar_type, $my_char_pos, $my_char_array, $mystring) = @_;

	my($section_complete) = 0;
	my($char_pos) = $my_char_pos;
	my($num_lparen) = 0;
	my($num_rparen) = 0;
	my($closure_string);
	my($closure_pos);
	my($char);
	my($or_found);
	my($sub_section_complete);
	my($sub_closure_pos);
	my($sub_closure_string);
	my($sub_or_found);

	while ($char_pos < length($mystring)) {
		$char = @$my_char_array[$char_pos];

		if ($char eq "(") {
			$num_lparen++;
		} elsif ($char eq ")") {
			$num_rparen++;
			if ($num_lparen == $num_rparen) {
				if ((substr($mystring,$char_pos+1,1) eq "|") || ($char_pos >= length($mystring)-1)) {
					$section_complete = 1;
				}

				last;
			}
		}

		$char_pos++;
	}

	$closure_string  = "";
	$closure_pos = $char_pos;
	$char_pos = $my_char_pos + 1;
	$or_found = 0;
	while ($char_pos < $closure_pos) {
		$char = @$my_char_array[$char_pos];
		if ($char eq "(") {
			($sub_section_complete, $sub_closure_pos, $sub_closure_string, $sub_or_found) = GetEnclosure ($grammar_type, $char_pos, $my_char_array, $mystring);

			if ($sub_or_found) {
				$sub_closure_string = "[(".$sub_closure_string.")]";
			} else {
				$sub_closure_string = "(".$sub_closure_string.")";
			}

			$closure_string = stringBuilder($closure_string, $sub_closure_string, "");

			$char_pos = $sub_closure_pos;

		} else {
			if ($char eq "|") {
				$or_found = 1;

				if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
					$char = ")|(";
				} elsif ($grammar_type eq "NUANCE_GSL") {
					$char = ") (";
				}
			}

			$closure_string = stringBuilder($closure_string, $char, "");
		}

		$char_pos++;
	}

	return ($section_complete, $closure_pos, $closure_string, $or_found);

}

sub ReplaceEnclosures
{
    my($debug, $output_format, $strval, $startpos, $tcnt) = @_;

	my($enclosure);
	my($endchar);
	my($endpos);
	my($i);
	my($insert_chars);
	my($insert_chars_end);
	my($len_insert_chars);
	my($loc);
	my($retval) = $strval;
	my($startchar);
	my($subretval);
	my($tab_set);
	my($tempchar);

	DebugPrint ("", 1, "ReplaceEnclosures: $output_format: Entry", $debug-1, $err_no++, "retval=$retval\n\n");

	if (lc($output_format) eq "xml") {
		for ($i = 0; $i < ($tcnt+1); $i++) {
			$tab_set = stringBuilder($tab_set, "\t", "");
		}

		($loc, $startchar) = FindFirstChar($startpos+1, "[", "(", "|", $retval);
		if ($startchar eq "|") {
			$retval =~ s/\|/\n$tab_set<\/item>\n$tab_set<item>\n/g;

			return ($retval);
		}

		while ($loc != -1) {
			$endpos = NewGetClosure($debug, $loc, $startchar, $retval, length($retval));
			$enclosure = substr($retval, $loc, $endpos-$loc);
			$subretval = ReplaceEnclosures($debug, "XML", $enclosure, 0, $tcnt+1);

			$retval = substr($retval,0,$loc).$subretval.substr($retval, $endpos);

			($loc, $startchar) = FindFirstChar($startpos+1, "[", "(", "", $retval);
		}

		($loc, $startchar) = FindFirstChar($startpos, "[", "(", "", $retval);
		if ($loc != -1) {
			($loc, $startchar) = FindFirstChar($startpos, "(", "[", "", $retval);

			if ($startchar eq "(") {
				$insert_chars = "\n$tab_set<item>\n$tab_set";
				$insert_chars_end = "\n$tab_set<\/item>\n$tab_set";
				$endchar = ")";
			} elsif ($startchar eq "[") {
				$insert_chars = "\n$tab_set<one-of>\n$tab_set<item>\n$tab_set";
				$insert_chars_end = "\n$tab_set<\/item>\n$tab_set<\/one-of>\n$tab_set";
				$endchar = "]";
			}

			$len_insert_chars = length($insert_chars);

			$tempchar = "\\$startchar";

			$retval =~ s/$tempchar/$insert_chars/;

			$tempchar = "\\$endchar";
			$retval =~ s/$tempchar/$insert_chars_end/;

			$retval = $insert_chars.substr($retval,$loc+1);
		}
	}

	DebugPrint ("", 1, "ReplaceEnclosures: $output_format: Exit", $debug-1, $err_no++, "retval=$retval\n\n");

	return ($retval);
}

sub DoAboveEnclosure
{

  my($level, $above_tab_set, $teststring, $above_closure, $istartptr, $rloc, $result_string) = @_;

  my($temp_chars);
  my($wait) = 0;

  if ($above_closure ne "") {
	$istartptr = $rloc;
	$temp_chars = substr($teststring, $istartptr+1, length($above_closure));
#	print "DoAboveEnclosure1a: level=$level, temp_chars=$temp_chars, istartptr=$istartptr, above_closure=$above_closure\n";
	if ($temp_chars ne $above_closure) {
	  if (substr($temp_chars, 0, 1) ne "/") {
		$wait = 1;
	  }
	} else {
	  $result_string = $result_string."\n$above_tab_set".substr($teststring, $istartptr, length($above_closure)+1)."\n";
	  $rloc = $istartptr+length($above_closure)+1;
	  $istartptr = $rloc;
	}
  } else {
#	print "DoAboveEnclosure2: level=$level, rloc=$rloc\n\n";
  }

  return($istartptr, $rloc, $result_string, $wait);
}

sub FindEnclosure
{

    my($possible_slot_val, $class_grammar_name, $grammar_type, $mystring, $mygram_array, $myclass_gram_array) = @_;

	my(@char_array);

	my($changed_string);
	my($char);
	my($char_pos) = 0;
	my($closure_pos);
	my($closure_string);
	my($or_found) = 0;
	my($out_string);
	my($section_complete) = 0;
	my($temp_changed_string);

	$char_pos = 0;

	if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
		$mystring = "(".$mystring."**********)";
	}

	$mystring =~ s/\(\?\!\((\w|\s|\|)+\)\)//g;

	@char_array = split //, $mystring;
	$changed_string = "";
	while (!$section_complete && ($char_pos < length($mystring))) {
		$char = $char_array[$char_pos];

		if ($char eq "(") {
			($section_complete, $closure_pos, $closure_string, $or_found) = GetEnclosure ($grammar_type, $char_pos, \@char_array, $mystring);

			if ($grammar_type eq "NUANCE_GSL") {
				if ($or_found) {
					$closure_string = "[(".$closure_string.")]";
				} else {
					$closure_string = "(".$closure_string.")";
				}
			} elsif ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
				if ($or_found) {
					$closure_string = "([(".$closure_string.")])";
				} else {
					$closure_string = "(".$closure_string.")";
				}
			}

			$changed_string = stringBuilder($changed_string, $closure_string, "");

			$char_pos = $closure_pos;
		} else {
			if ($char eq "|") {
				$section_complete = 1;
				last;
			} else {
			  $changed_string = stringBuilder($changed_string, $char, "");
			}
		}

		$char_pos++;
	}

	if ($grammar_type eq "NUANCE_GSL") {
		$changed_string =~ s/\?_FILTEMP_/ \?\(\*-filler-\) /g;
	} elsif ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
		$changed_string =~ s/\?_FILTEMP_//g;
	}

	$changed_string =~ s/\[\?\!(\w|\s)+\]//g;
	$changed_string =~ s/\((\w+)\)/$1/g;
	$changed_string =~ s/\[(\w+)\]/$1/g;
	$changed_string = TrimChars($changed_string);

	if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
		if (index($changed_string, "(") == -1) {
			$changed_string = "(".$changed_string.")";
		}
	}

	if ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
		my($retval);
		my($debug) = 0;
		my($loc);
		my($startchar);
		my($enclosure);
		my($within_enclosure);
		my($endpos);
		my($tcnt);
		my($rcnt);
		my($scnt);
		my($tlen);
		my($tab_set);
		my($tab_add);

		$changed_string =~ s/\] \[/\]\[/g;

# ATTENTION1
		if (0) {
			$changed_string =~ s/\) \(/\)\(/g;
			$changed_string =~ s/\] \(/\]\(/g;
			$changed_string =~ s/\) \[/\)\[/g;

			$changed_string =~ s/\] \|/\]\|/g;
			$changed_string =~ s/\) \|/\)\|/g;
			$changed_string =~ s/\| \(/\|\(/g;
			$changed_string =~ s/\| \[/\|\[/g;
			$retval = $changed_string;
			$tab_set = "\@";
			$tab_add = "\@";
			($loc, $startchar) = FindFirstChar(0, "[", "(", "|", $retval);
			$tcnt = 0;
			while ($loc != -1) {
				if ($loc != -1) {
					$rcnt = $tcnt + 1;
					$scnt = $rcnt + 1;
					if ($startchar eq "|") {
						$retval = substr($retval,0,$loc)."===$tcnt===<\/item>===$tcnt===<item>===$rcnt===".substr($retval, $loc+1);
					} else {
						$tlen = length($retval);
						$endpos = NewGetClosure($debug, $loc, $startchar, $retval, length($retval));
						$enclosure = substr($retval, $loc, $endpos-$loc);
						$within_enclosure = substr($retval, $loc+1, $endpos-$loc-2);

						if ($endpos == $tlen) {
							if ($startchar eq "(") {
								$retval = "===$tcnt===<item>===$rcnt===".$within_enclosure."===$tcnt===<\/item>===$rcnt===";
							} else {
								$retval = "===$tcnt===<one-of>"."===$rcnt===<item>===$scnt===".$within_enclosure."===$rcnt===<\/item>===$tcnt===<\/one-of>===$rcnt===";
							}
						} else {
							if ($startchar eq "(") {
								$retval = substr($retval,0,$loc)."===$tcnt===<item>===$rcnt===".$within_enclosure."===$tcnt===<\/item>===$tcnt===<item>===$rcnt===".substr($retval, $endpos);
							} else {
								$retval = substr($retval,0,$loc)."===$tcnt===<one-of>"."===$rcnt===<item>===$scnt===".$within_enclosure."===$rcnt===<\/item>===$tcnt===<\/one-of>===$rcnt===".substr($retval, $endpos);
							}
						}

						$tcnt++;
					}

					($loc, $startchar) = FindFirstChar(0, "[", "(", "|", $retval);
				}
			}

			$retval =~ s/===0===/\n\t/g;
			$retval =~ s/===1===/\n\t\t/g;
			$retval =~ s/===2===/\n\t\t\t/g;
			$retval =~ s/===3===/\n\t\t\t\t/g;
			$retval =~ s/===4===/\n\t\t\t\t\t/g;
			$retval =~ s/===5===/\n\t\t\t\t\t\t/g;
			$retval =~ s/===6===/\n\t\t\t\t\t\t\t/g;
			$retval =~ s/===7===/\n\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===8===/\n\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===9===/\n\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===10===/\n\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===11===/\n\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===12===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===13===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===14===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===15===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===16===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===17===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===18===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===19===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===20===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===21===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===22===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
			$retval =~ s/===23===/\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t/g;
		}

		$changed_string =~ s/\] /\]\n\t\t/g;
		$changed_string =~ s/ \[/\n\[/g;
		$changed_string =~ s/\[/\n\t\t<one-of>\n\t\t<item>\n/g;
		$changed_string =~ s/\]/\n<\/item>\n\t\t<\/one-of>\n/g;
		$changed_string =~ s/\|/\n\t<\/item>\n\t\t<item>\n/g;
		$changed_string =~ s/<item>\(/\n<item>\n/g;
		$changed_string =~ s/\)<\/item>/\n<\/item>\n/g;
		$changed_string =~ s/\(/\n\t<item>\n/g;
		$changed_string =~ s/\)/\n\t<\/item>\n/g;
		$changed_string = TrimChars($changed_string);
	}

	$temp_changed_string = $changed_string;

	$changed_string =~ s/\*\*\*\*\*\*\*\*\*\*//g;

	push (@$mygram_array, $changed_string);

	if ($possible_slot_val ne "") {
		$class_grammar_name = uc($class_grammar_name);

		if ($grammar_type eq "NUANCE_GSL") {
			$temp_changed_string = $temp_changed_string."{<$class_grammar_name \"$possible_slot_val\">}";
		} elsif ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
			$temp_changed_string =~ s/\*\*\*\*\*\*\*\*\*\*/\n\t\t<tag>$class_grammar_name=\'$possible_slot_val\'<\/tag>\n/;
		}

		push (@$myclass_gram_array, $temp_changed_string);
	}

	$out_string = substr($mystring,$char_pos+1);

	return $out_string;
}

############# END Enclosure SUBROUTINES ##############################

######################################################################
######################################################################
################# Print SUBROUTINES ##################################
######################################################################
######################################################################

sub ConditionalPrint
{

    my($fileout, $flag, $print_string) = @_;

	if ($flag) {
		print $fileout "$print_string\n";
	}
}

sub DebugPrint
{

    my($fileout, $mode, $label, $debug, $err_no, $print_string) = @_;

	my($mcnt) = 0;
	my($message);
	my($mode_is_ignore) = -1;
	my($mode_is_top_level) = 0;
	my($mode_is_top_level_1) = 0.1;
	my($mode_is_info_msg) = 1;
	my($mode_is_track_warnings) = 2;
	my($mode_is_track_errors) = 3;
	my($mode_is_print_all) = 4;

	if ($label ne "") {
		$label = "(".$label.")";
	}

	if ($mode == $mode_is_top_level) {
	    $print_string = "\nTask ".($task_no+1).": ".$print_string."\n";
	    $task_no++;
	    $sub_task_no = 0;
	}

	if ($mode == $mode_is_top_level_1) {
	    $print_string = "\n\t".($task_no).".".($sub_task_no+1).": ".$print_string;
	    $sub_task_no++;
	}

	if ($mode == $mode_is_track_errors) {
	  if ($print_string ne "") {
	      writeErrors($print_string);
#	      push @error_message_array, $print_string;
#		$print_string = "\n\t--- See error \#".scalar(@error_message_array)." below\n";
	      $print_string = "\n\t--- See error \#".($err_msg_no+1)." below ($print_string)\n";
	      $err_msg_no++;
	  }
	} elsif ($mode == $mode_is_track_warnings) {
	  if ($print_string ne "") {
	      writeWarnings($print_string);
#	      push @warning_message_array, $print_string;
#		$print_string = "\n\t--- See warning \#".scalar(@warning_message_array)." below\n";
	      $print_string = "\n\t--- See warning \#".($warning_msg_no+1)." below ($print_string)\n";
	      $warning_msg_no++;
	  }
	} elsif ($mode == $mode_is_info_msg) {
	  $print_string = "\n\t--- ".$print_string."\n";
	} elsif ($mode == $mode_is_top_level_1) {
	  $print_string = "\n\t".$print_string."\n";
	}

	if ($fileout =~ /UNDERLINE/) {
		$print_string = $print_string."\n---------------------------------------------\n";

		if (($mode == $mode_is_print_all) && (($num_warnings > 0) || ($num_errors > 0))) {
		  if ($fileout =~ /(\d)/) {
			if ($1 == 0) {
			  $print_string = $print_string."---------------------------------------------\n\nTotal Warnings:\t$num_warnings\n\n";

			  $mcnt = 0;
			  if (-e "slmdirect_results/createslmDIR_temp_files/temp_warnings") {
			      open(WARNINGS,"<"."slmdirect_results\/createslmDIR_temp_files\/temp_warnings") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_warnings";
			      (@warning_message_array) = (<WARNINGS>);
			      foreach $message (@warning_message_array) {
				  $print_string = $print_string."\t".($mcnt+1).": $message\n";
				  $mcnt++;
			      }

			      close(WARNINGS);
			      $print_string = $print_string."\n";
			  }

			  $print_string = $print_string."Total Errors:\t$num_errors\n\n";

			  $mcnt = 0;
			  if (-e "slmdirect_results/createslmDIR_temp_files/temp_errors") {
			      open(ERRORS,"<"."slmdirect_results\/createslmDIR_temp_files\/temp_errors") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_errors";
			      (@error_message_array) = (<ERRORS>);
			      foreach $message (@error_message_array) {
				  $print_string = $print_string."\t".($mcnt+1).": $message\n";
				  $mcnt++;
			      }
			      
			      close(ERRORS);

			      $print_string = $print_string."\n";
			  }

			  $print_string = $print_string."---------------------------------------------\n---------------------------------------------\n\n";
			} elsif ($1 == 1) {
			  $print_string = $print_string."---------------------------------------------\n\nTotal Warnings:\t$num_warnings\n\n";

			  $mcnt = 0;
			  if (-e "slmdirect_results/createslmDIR_temp_files/temp_warnings") {
			      open(WARNINGS,"<"."slmdirect_results\/createslmDIR_temp_files\/temp_warnings") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_warnings";
			      (@warning_message_array) = (<WARNINGS>);
			      foreach $message (@warning_message_array) {
				  $print_string = $print_string."\t".($mcnt+1).": $message\n";
				  $mcnt++;
			      }

			      close(WARNINGS);

			      $print_string = $print_string."\n";
			  }

			  $print_string = $print_string."Total Errors:\t\t$num_errors\n\n";

			  $mcnt = 0;
			  if (-e "slmdirect_results/createslmDIR_temp_files/temp_errors") {
			      open(ERRORS,"<"."slmdirect_results\/createslmDIR_temp_files\/temp_errors") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_errors";
			      (@error_message_array) = (<ERRORS>);
			      foreach $message (@error_message_array) {
				  $print_string = $print_string."\t".($mcnt+1).": $message\n";
				  $mcnt++;
			      }

			      close(ERRORS);

			      $print_string = $print_string."\n";
			  }

			  $print_string = $print_string."---------------------------------------------\n---------------------------------------------\n\n";
			}
		  }
		}
	}

	if ($fileout =~ /BOTH/) {
		open(DEBUGOUT,">>"."slmdirect_results\/createslm_log_file") or die "cant open "."slmdirect_results\/createslm_log_file";
		print DEBUGOUT ">>>$fileout - $label - $err_no: $print_string";
		close(DEBUGOUT);

		print "$print_string";
	}

	if ($fileout =~ /SCREEN/) {
		print "$print_string";
	}

	if ($debug > 0) {
		if (($fileout ne "") && ($fileout !~ /BOTH/)) {
			open(DEBUGOUT,">>"."slmdirect_results\/createslm_log_file") or die "cant open "."slmdirect_results\/createslm_log_file";
			print DEBUGOUT ">>>$fileout - $label - $err_no: $print_string";
			close(DEBUGOUT);
		} elsif ($fileout eq "") {
			print STDERR ">>>DEBUG - $label - $err_no: $print_string";
#			print "\n>>>DEBUG - $label - $err_no: $print_string\n\n";
		}
	}

	if ($mode == $mode_is_track_warnings) {
	  $num_warnings++;
	} elsif ($mode == $mode_is_track_errors) {
	  $num_errors++;
	}
}

################# END Print SUBROUTINES ##################################

######################################################################
######################################################################
################# Clean and Correction SUBROUTINES ###################
######################################################################
######################################################################

sub MoreClean
{
   my($sentence) = @_;

   $sentence =~ s/\./ /g;
   $sentence =~ s/\,/ /g;
   $sentence =~ s/\?//g;
   $sentence =~ s/\'\'/\'/g;
   $sentence =~ s/ \//\//g;
   $sentence =~ s/\/ /\//g;
   $sentence =~ s/(\º )|( \º)/\º/g;

   return ($sentence);
}

sub DoFirstCorrections
{
   my($cleaning_args, $meaning_args, $corrected_sentence, $pre_search_string_len, $filename_pre_search_string_len, $parsefile) = @_;

   if ($pre_search_string_len == ($filename_pre_search_string_len)) {
	 DebugPrint ("BOTH", 2, "Main", $debug, $err_no++, "Filename Specification may be missing in $parsefile");
   }

   if ($$cleaning_args{"response_exclusion"} ne "") {
	 DebugPrint ("BOTH", 0.1, "DoFirstCorrections", $debug, $err_no++, "Doing Response Exclusions ... done");
	 $corrected_sentence = ApplyResponseExclusion($corrected_sentence, $$cleaning_args{"response_exclusion"});
   }

   if ($$cleaning_args{"removerepeats"}) {
	 DebugPrint ("BOTH", 0.1, "DoFirstCorrections", $debug, $err_no++, "Removing Repeats ... done");
	 $corrected_sentence = ApplyRemoveRepeats($corrected_sentence);
   }

   DebugPrint ("BOTH", 0.1, "DoFirstCorrections", $debug, $err_no++, "Cropping Sentences ... done");
   $corrected_sentence = ApplyCropSentence($corrected_sentence, $$meaning_args{"sentence_length_for_scan"});

   DebugPrint ("BOTH", 0.1, "DoFirstCorrections", $debug, $err_no++, "Removing Extraneous Characters ... done");
   $corrected_sentence = ApplyProcessCharsPlusMinus($corrected_sentence);

   return ($corrected_sentence);
 }

sub MakeCleanTrans
{
   my($general_args, $cleaning_args, $first_stage_done, $apply_classgrammars, $no_response_exclusion, $already_clean, $test_category, $original_trans) = @_;

   my($clean_trans);
   my($temp_trans) = quotemeta($original_trans);
   my($test_trans) = "\=".$temp_trans;
   my($check_trans) = 0;

   if (!$no_response_exclusion) {
	   $temp_trans = TrimCharsChangeTab($original_trans);
	   $temp_trans = s/\@hes\@/ /g;
	   $temp_trans = s/\(\(\ \)\)/ /g;
	   $temp_trans = quotemeta(TrimChars($temp_trans));
	   $test_trans = "\=".$temp_trans;

	   if ($$cleaning_args{"response_exclusion"} =~ /$test_trans/) {
		   $check_trans = 1;
	   } elsif ($$cleaning_args{"response_exclusion"} =~ /$temp_trans/) {
		   $check_trans = 1;
	   }
   }

   if ($already_clean) {
	   $clean_trans = $original_trans;
   } else {
	   if ($check_trans || (not defined $$cleaning_args{"clean_trans"}{$original_trans})) {
		   $clean_trans = DoAllCorrections ($general_args, $cleaning_args, $first_stage_done, $apply_classgrammars, $test_category, $no_response_exclusion, $original_trans);

#		   $$clean_trans_hash{$original_trans} = $clean_trans;
	   } else {
		   $clean_trans = $$cleaning_args{"clean_trans"}{$original_trans};
	   }
   }

   return ($clean_trans);
}

sub ApplyAliases
{
  my($general_args, $meaning_args, $result_sentence) = @_;

  my($elem0);
  my($elem1);
  my($temp);
  my($temp1);

  if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
	foreach $elem0 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_search"}}) {
	  if ($result_sentence =~ /$$meaning_args{"alias_search"}{$elem0}/) {
		$temp = $1;

		if ((scalar keys %{$$meaning_args{"alias_exclusion"}{$temp}}) > 0) {
		  $temp1 = "";

		  $result_sentence =~ s/\^/\:/g;
		  foreach $elem1 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_exclusion"}{$temp}}) {
			$elem1 =~ s/\(//g;
			$elem1 =~ s/\)//g;
			$elem1 =~ s/\^/\\\:/g;
			$temp1 = stringBuilder($temp1, $elem1, " ");
		  }

		  $result_sentence =~ s/\b($temp(?!( ($temp1))))\b/\^$elem0/g;
		  $result_sentence =~ s/\:/\^/g;
		} else {
		  $result_sentence =~ s/\b$temp\b/\^$elem0/g;
		}
	  }
	}
  }

  if ($$general_args{"main_language"} eq "es-us") {
	foreach $elem0 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_search_esus"}}) {
	  if ($result_sentence =~ /$$meaning_args{"alias_search_esus"}{$elem0}/) {
		$temp = $1;

		if ((scalar keys %{$$meaning_args{"alias_exclusion"}{$temp}}) > 0) {
		  $temp1 = "";

		  $result_sentence =~ s/\^/\:/g;

		  foreach $elem1 ( sort { $a cmp $b } keys %{$$meaning_args{"alias_exclusion"}{$temp}}) {
			$elem1 =~ s/\(//g;
			$elem1 =~ s/\)//g;
			$elem1 =~ s/\^/\\\:/g;
			$temp1 = stringBuilder($temp1, $elem1, " ");
		  }

		  $result_sentence =~ s/$temp(?!( ($temp1)))/\^$elem0/g;

		  $result_sentence =~ s/\:/\^/g;
		} else {
		  $result_sentence =~ s/\b$temp\b/\^$elem0/g;
		}
	  }
	}
  }

  return ($result_sentence);
}

sub ApplyFindBadChars
{
   my($sentence, $language_suffix) = @_;

   my($elem1);
   my(%bad_char_hash);

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/FindBadChars($1, \%bad_char_hash)/eg;
   if (scalar (keys %bad_char_hash) > 0) {
	   open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_chars_in_sentences"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_chars_in_sentences"."$language_suffix";

	   foreach $elem1 ( sort { $a cmp $b } keys %bad_char_hash) {
		   print KEYOUT "$elem1\n";
	   }

	   DebugPrint ("BOTH", 2, "ApplyFindBadChars", $debug, $err_no++, "POSSIBLE EXTRANEOUS CHARS IN OUTPUT SENTENCES: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_chars_in_sentences"."$language_suffix");
   } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_chars_in_sentences"."$language_suffix";
   }
}

sub FindBadChars
{
	my($sentence, $bad_char_hash) = @_;

	if ($sentence =~ /\[|\]|\*|\~|\/|\!|\"|\$|\%|\^|\&|\*|\(|\)|\-|\+|\{|\}|\;|\@|\#|\.|\,|\<|\>|\?|\\|\|/) {
		if (($sentence !~ /\*Blank\*/) && ($sentence !~ /\*Response Exclusion\*/) && ($sentence !~ /Ramble Exclusion/)) {
			$$bad_char_hash{$sentence}++;
		}
	}
}

sub ApplyBuildMainString
{
   my($sentence) = @_;

   my($s_counter);

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/BuildMainString($1, $s_counter++)/eg;

   return ($sentence);
}

sub BuildMainString
{
	my($sentence, $s_counter) = @_;

	$sentence = $sentence."[$s_counter]";

  return ($sentence);
}

sub ApplyReferenceTags
{
   my($language_suffix, $test_reject_name, $search_string, $referencetag_hash) = @_;

   my($elem);
   my($elem_underscore);
   my($hold_search_string) = $search_string;
   my($temp_search_string);
   my(@temp_array);
   my(%seen_hash);
   my(%error_hash);
   my(@unique_array);

   if (scalar (keys %{$referencetag_hash}) > 0) {
	   $search_string = lc($search_string);
	   foreach $elem ( sort { length($b) <=> length($a) } keys %{$referencetag_hash}) {
		 $elem_underscore = $elem;
		 $elem_underscore =~ s/ /_/g;
		 if (($elem eq $$referencetag_hash{$elem}) || ($elem_underscore eq $$referencetag_hash{$elem_underscore})) {
		   next;
		 } else { 
		   while ($search_string =~ /\b($elem|$elem_underscore)\b/g) {
			 $temp_search_string = $1;
			 $search_string =~ s/\b($temp_search_string)\b/$$referencetag_hash{$temp_search_string}/g;
		   }
		 }

		 pos $search_string = 0;
	   }

	   DebugPrint ("BOTH", 0.1, "ApplyReferenceTags", $debug, $err_no++, "Applying Reference Tags ... done\n");

	   @temp_array = split /\º/, $hold_search_string;
	   @unique_array = grep {! $seen_hash{$_} ++ } @temp_array;
	   undef %seen_hash;

	   foreach $elem (@unique_array) {
		 $elem_underscore = $elem;
		 $elem_underscore =~ s/ /_/g;

		 if (lc($elem) ne lc($test_reject_name)) {
		   $elem  =~ s/_/ /g;
		 }

		 if ((not defined $$referencetag_hash{lc($elem)}) && (not defined $$referencetag_hash{lc($elem_underscore)})) {
		   if (index($elem, " ") != -1) { 
			 $error_hash{$elem." OR ".$elem_underscore}++;
		   } else {
			 $error_hash{$elem}++;
		   }
		 }
	   }

	   if (scalar (keys %error_hash) > 0) {
		   open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_bad_reference_tags"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_bad_reference_tags"."$language_suffix";

		   foreach $elem ( sort { $a cmp $b } keys %error_hash) {
			   print KEYOUT "$elem\n";
		   }

		   DebugPrint ("BOTH", 2, "ApplyReferenceTags", $debug, $err_no++, "TAGS EXIST THAT ARE NOT IN THE REFERENCE TAG FILE: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_bad_reference_tags"."$language_suffix");
	   } else {
		   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_bad_reference_tags"."$language_suffix";
	   }

	   close(KEYOUT);
   }

   return ($search_string);
}

sub ApplyBlanks
{
   my($sentence) = @_;

   if (($sentence =~ /\º\º/) || ($sentence =~ /^\º/) || ($sentence =~ /\º$/) || (lc($sentence) =~ /\*blank\*/)) {
	 DebugPrint ("BOTH", 0.1, "ApplyBlanks", $debug, $err_no++, "Identifying Blank Sentences ... done");

	 while ($sentence =~ /\º\º/) {
	   $sentence =~ s/\º\º/\º*Blank*\º/g;
	 }

	 $sentence =~ s/^\º/*Blank*\º/g;
	 $sentence =~ s/\º$/\º*Blank*/g;
   }

   return ($sentence);
}

sub convertCharEntity
{
   my($charentity) = @_;

   my($retval) = "";

   if (lc($charentity) eq "apos") {
	   $retval = "'";
   } elsif (lc($charentity) eq "pound") {
	   $retval = "#";
   }

   return $retval;
}

sub ApplyResponseExclusion
{
   my($sentence, $response_exclusion_string) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/TestResponseExclusion($1, $response_exclusion_string)/eg;

   return ($sentence);
}

sub TestResponseExclusion
{
   my($sentence, $response_exclusion_string) = @_;

   my(@response_exclusion_array);
   my($elem);
   my($retval) = 0;

   if ($response_exclusion_string ne "") {
	   if ($response_exclusion_string !~ /\=/) {
		   if ( $sentence =~ /\b(.*$response_exclusion_string)\b/ )           {
			   $retval = 1;
		   }
	   } else {
		   @response_exclusion_array = split /\|/, $response_exclusion_string;
		   foreach $elem (@response_exclusion_array) {
			   if (substr($elem, 0, 1) eq "=") {
				   $elem = substr($elem, 1);
				   if ( $sentence eq $elem) {
					   $retval = 1;
					   last;
				   }
			   } else {
				   if ( $sentence =~ /\b$elem\b/ ) {
					   $retval = 1;
					   last;
				   }
			   }
		   }
	   }
   }

   if ($retval) {
	   $sentence = $sentence.":"."*Response Exclusion*";
   }

   return $sentence;
}

sub ApplyRambleExclusion
{
   my($sentence, $ramble_exclusion_string) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/TestRambleExclusion($1, $ramble_exclusion_string)/eg;

   return ($sentence);
}

sub TestRambleExclusion
{
   my($sentence, $ramble_exclusion_string) = @_;

   my($retval) = 0;

   if ($ramble_exclusion_string ne "") {
	 if ( $sentence =~ /\[($ramble_exclusion_string)\]/ )           {
	   $retval = 1;
	 }
   }

   if ($retval) {
	 $sentence =~ s/ \[$ramble_exclusion_string\]//g;
	 $sentence =~ s/\[$ramble_exclusion_string\] //g;
	 $sentence =~ s/\[$ramble_exclusion_string\]//g;
	 $sentence = $sentence.":"."*Ramble Exclusion*";
   }

   return $sentence;
}

sub ApplyCropSentence
{
   my($sentence, $sentence_length_for_scan) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/TestCropSentence($1, $sentence_length_for_scan)/eg;

   return ($sentence);
}

sub TestCropSentence
{
   my($changed_utt, $sentence_length_for_scan) = @_;

   my(@sent_to_rule_array);

   (@sent_to_rule_array) = split " ", $changed_utt;

   if (scalar (@sent_to_rule_array) > $sentence_length_for_scan) {
	   while (scalar (@sent_to_rule_array) > $sentence_length_for_scan) {
		   pop @sent_to_rule_array;
	   }

	   $changed_utt = join " ", @sent_to_rule_array;
   }

   return ($changed_utt);
}

sub ApplyRemoveRepeats
{
   my($sentence) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/RemoveRepeats($1)/eg;

   return ($sentence);
}

sub ApplyCoNounCorrection
{
   my($general_args, $meaning_args, $sentence) = @_;

   $sentence =~ s/(((\w|\d)+(\#n)) ((\w|\d)+(\#n)))/CoNounCorrection($general_args, $meaning_args, $1)/eg;

   return ($sentence);
}

sub CoNounCorrection
{
  my($general_args, $meaning_args, $sentence) = @_;

  my($i);
  my(@sentence_array);

  $sentence =~ s/\(|\)|(\#n)//g;

  @sentence_array = split " ", $sentence;

  for ($i = 0; $i < (scalar(@sentence_array) - 1); $i++) {
	$sentence_array[$i] = $sentence_array[$i]."#a";
  }

  $sentence_array[-1] = $sentence_array[-1]."#n";

  $sentence = join " ", @sentence_array;

  return ($sentence);
}

sub ApplySqueezeSentenceMinus
{
   my($general_args, $meaning_args, $wordnet_args, $sentence) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/SqueezeSentenceMinus($general_args, $meaning_args, $wordnet_args, $1)/eg;

   return ($sentence);
}

sub SqueezeSentenceMinus
{
   my($general_args, $meaning_args, $wordnet_args, $changed_utt) = @_;

   my($elem1);
   my($pos) = 0;
   my(@skip_array);
   my(@keep_array);
   my($skip_string) = "";
   my($keep_string) = "";
   my($success);
   my(@sent_to_rule_array);
   my($filtered_utt);

   my($sent_totally_squeezed) = 0;

# >>>>>>> filter changed_utt for skip words on either side
   $filtered_utt = $changed_utt;

   (@sent_to_rule_array) = split " ", $filtered_utt;

   $pos = 0;
   $skip_string = "";
   $keep_string = "";
   $success = 1;
   while ($success) {
	   ($success, $pos, $skip_string, $keep_string) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, \@sent_to_rule_array, $pos, $skip_string, $keep_string);
   }

   @skip_array = split " ", $skip_string;

   foreach $elem1 (@skip_array) {
	   shift @sent_to_rule_array;
   }

   if (scalar (@sent_to_rule_array) > 0) {
	   $keep_string = CheckSkipPhrase2($meaning_args, $wordnet_args, \@sent_to_rule_array);
	   @keep_array = split " ", $keep_string;
	   while (((scalar @keep_array) > 0) && ((defined $$meaning_args{"valid_restricted_end"}{$keep_array[-1]}) ||(defined $$meaning_args{"valid_restricted_general"}{$keep_array[-1]}) )) {
		   pop @keep_array;
	   }

	   while (((scalar @sent_to_rule_array) > 0) && ($sent_to_rule_array[-1] ne $keep_array[-1])) {
		   pop @sent_to_rule_array;
	   }

	   if (scalar (@sent_to_rule_array) > 0) {
		   $filtered_utt = join " ", @sent_to_rule_array;
	   }
   } else {
	   $sent_totally_squeezed = 1;
	   $filtered_utt = "";
   }

   return ($filtered_utt);
}

sub ApplyProcessCharsPlusMinus
{
   my($sentence) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/ProcessCharsPlusMinus($1)/eg;

   return ($sentence);
}

sub Special_chooseCompressedSentence
{
    my($general_args, $meaning_args, $wordnet_args, $corrected_sentence, $compressed_sentence_array, $wordbag_compressed_sentence_array, $compressed_alias_sentence_array, $wordbag_compressed_alias_sentence_array, $chosen_already_hash, $compressed_already_hash, $wordlist_already_hash) = @_;

	my($compressed_alias_sentence) = "";
	my($compressed_sentence) = "";
	my($compressed_sentence_save) = "";
	my($throwaway_compressed);
	my($throwaway_compressed_alias);
	my($wordbag_compressed_alias_sentence) = "";
	my($wordbag_compressed_sentence) = "";

	if (defined $$chosen_already_hash{$corrected_sentence}) {
	  ($compressed_sentence_save, $compressed_sentence, $wordbag_compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_alias_sentence) = split ":", $$chosen_already_hash{$corrected_sentence};
	} else {
	  if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
		if (not defined $$meaning_args{"pre_string"}) {
		  $compressed_sentence = $corrected_sentence;
		} else {
		  $compressed_sentence = CheckSkipPhrase("loc3", $meaning_args, $wordnet_args, $corrected_sentence);
		}
	  } elsif ($$general_args{"main_language"} eq "es-us") {
		if (not defined $$meaning_args{"pre_string_esus"}) {
		  $compressed_sentence = $corrected_sentence;
		} else {
		  $compressed_sentence = CheckSkipPhrase("loc4", $meaning_args, $wordnet_args, $corrected_sentence);
		}
	  }

	  $throwaway_compressed = 0;
	  $throwaway_compressed_alias = 0;
	  if ($compressed_sentence eq "") {
		$compressed_sentence = "___twm___";
		$wordbag_compressed_sentence = "";
		$compressed_alias_sentence = "";
		$wordbag_compressed_alias_sentence = "";
		$compressed_sentence_save = $compressed_sentence;
	  } else {
		if ($compressed_sentence eq $corrected_sentence) {
		  $throwaway_compressed = 1;
		}

		$wordbag_compressed_sentence = GenWordList($$general_args{"main_language"}, $compressed_sentence, $wordlist_already_hash);
		if ($wordbag_compressed_sentence eq $compressed_sentence) {
		  $wordbag_compressed_sentence = "Ç";
		}

		$compressed_alias_sentence = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_sentence, $compressed_already_hash);
		if ($compressed_alias_sentence eq $compressed_sentence) {
		  $throwaway_compressed_alias = 1;
		}

		$wordbag_compressed_alias_sentence = GenWordList($$general_args{"main_language"}, $compressed_alias_sentence, $wordlist_already_hash);
		if ($wordbag_compressed_alias_sentence eq $compressed_alias_sentence) {
		  $wordbag_compressed_alias_sentence = "Ç";
		} elsif ($wordbag_compressed_alias_sentence eq $wordbag_compressed_sentence) {
		  $wordbag_compressed_alias_sentence = "ç";
		}

		$compressed_sentence_save = $compressed_sentence;
		if ($throwaway_compressed) {
		  $compressed_sentence = "Ç";
		  $compressed_sentence_save = $corrected_sentence;
		}

		if ($throwaway_compressed_alias) {
		  $compressed_alias_sentence = "Ç";
		}
	  }

	  $$chosen_already_hash{$corrected_sentence} = "$compressed_sentence_save".":"."$compressed_sentence".":"."$wordbag_compressed_sentence".":"."$compressed_alias_sentence".":"."$wordbag_compressed_alias_sentence";
	}

	push @$compressed_sentence_array, $compressed_sentence;
	push @$wordbag_compressed_sentence_array, $wordbag_compressed_sentence;
	push @$compressed_alias_sentence_array, $compressed_alias_sentence;
	push @$wordbag_compressed_alias_sentence_array, $wordbag_compressed_alias_sentence;

#print "hereqqq0: corrected_sentence=$corrected_sentence\n";
#print "hereqqq1: compressed_sentence=$compressed_sentence\n";
#print "hereqqq2: wordbag_compressed_sentence=$wordbag_compressed_sentence\n";
#print "hereqqq3: compressed_alias_sentence=$compressed_alias_sentence\n";
#print "hereqqq4: wordbag_compressed_alias_sentence=$wordbag_compressed_alias_sentence\n";
#print "hereqqq5: compressed_sentence_save=$compressed_sentence_save\n";

	return ("$compressed_sentence_save");
}

sub Special_ApplyChooseCompressedSentence
{
   my($general_args, $meaning_args, $wordnet_args, $sentence, $compressed_sentence_array, $wordbag_compressed_sentence_array, $compressed_alias_sentence_array, $wordbag_compressed_alias_sentence_array, $compressed_already_hash, $wordlist_already_hash) = @_;

   my(%chosen_already_hash);

   $chosen_already_hash{"*blank*"} = "___twm___".":"."___twm___".":"."".":"."".":"."";

   if ((($$meaning_args{"scan_language"} eq "") && ($$meaning_args{"pre_string"} ne "___twm___")) || (($$meaning_args{"scan_language"} eq "esus") && ($$meaning_args{"pre_string_esus"} ne "___twm___"))) {
	 $sentence =~ s/^\º/*blank*\º/g;

	 while ($sentence =~ /\º\º/) {
	   $sentence =~ s/\º\º/\º*blank*\º/g;
	 }

	 $sentence =~ s/\º$/\º*blank*/g;

	 $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/Special_chooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $1, $compressed_sentence_array, $wordbag_compressed_sentence_array, $compressed_alias_sentence_array, $wordbag_compressed_alias_sentence_array, \%chosen_already_hash, $compressed_already_hash, $wordlist_already_hash)/eg;

	 $sentence =~ s/\ª//g;
	 $sentence =~ s/\º/\n/g;
	 $sentence = $sentence."\n";

	 open(NEWPARSEFILECOMP,">"."slmdirect_results\/createslmDIR_info_files\/info_compressed_transcription_total") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_compressed_transcription_total";
	 print NEWPARSEFILECOMP "$sentence\n";
	 close(NEWPARSEFILECOMP);
   } else {
	 if ($sentence =~ /___twm___/) {
	   $sentence =~ s/___twm___ //g;
	   $sentence =~ s/ ___twm___//g;
	   $sentence =~ s/___twm___//g;
	 }

	 @$compressed_sentence_array = ();
	 @$wordbag_compressed_sentence_array = ();
	 @$compressed_alias_sentence_array = ();
	 @$wordbag_compressed_alias_sentence_array = ();
   }

#   $alias_active = CheckIntegrity2($sentence, $compressed_sentence, $wordbag_compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_alias_sentence);

}

sub chooseCompressedSentence
{
    my($general_args, $meaning_args, $wordnet_args, $corrected_sentence, $compressed_already_hash) = @_;

	my($compressed_sentence) = "";

	if (defined $$compressed_already_hash{$corrected_sentence}) {
	  $compressed_sentence = $$compressed_already_hash{$corrected_sentence};
	} else {
	  if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
		if (not defined $$meaning_args{"pre_string"}) {
		  $compressed_sentence = $corrected_sentence;
		} else {
		  $compressed_sentence = CheckSkipPhrase("loc5", $meaning_args, $wordnet_args, $corrected_sentence);
		}
	  } elsif ($$general_args{"main_language"} eq "es-us") {
		if (not defined $$meaning_args{"pre_string_esus"}) {
		  $compressed_sentence = $corrected_sentence;
		} else {
		  $compressed_sentence = CheckSkipPhrase("loc6", $meaning_args, $wordnet_args, $corrected_sentence);
		}
	  }

	  if ($compressed_sentence eq "") {
		$compressed_sentence = "___twm___";
	  }

	  $$compressed_already_hash{$corrected_sentence} = $compressed_sentence;
	}

	return ($compressed_sentence);
}

sub ApplyChooseCompressedSentence
{
   my($general_args, $meaning_args, $wordnet_args, $sentence, $compressed_already_hash) = @_;

   if ((($$meaning_args{"scan_language"} eq "") && ($$meaning_args{"pre_string"} ne "___twm___")) || (($$meaning_args{"scan_language"} eq "esus") && ($$meaning_args{"pre_string_esus"} ne "___twm___"))) {
	 $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/chooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $1, $compressed_already_hash)/eg;
   } else {
	 if ($sentence =~ /___twm___/) {
	   $sentence =~ s/___twm___ //g;
	   $sentence =~ s/ ___twm___//g;
	   $sentence =~ s/___twm___//g;
	 }
   }

   return ($sentence);
}

sub ApplyMakeCompressedAliasSentence
{
   my($general_args, $meaning_args, $sentence, $compressed_already_alias_hash) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/MakeCompressedAliasSentence($general_args, $meaning_args, $1, $compressed_already_alias_hash)/eg;

   return ($sentence);
}

sub ApplyGenWordList
{
   my($main_language, $sentence, $wordlist_already_hash) = @_;

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/GenWordList($main_language, $1, $wordlist_already_hash)/eg;

   return ($sentence);
}

sub ApplyCompression
{
   my($general_args, $meaning_args, $wordnet_args, $sentence, $compressed_already_hash, $wordlist_already_hash) = @_;

   my($compressed_sentence);
   my($compressed_alias_sentence);
   my($wordbag_compressed_sentence);
   my($wordbag_compressed_alias_sentence);

   $compressed_sentence = ApplyChooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $sentence, $compressed_already_hash);

   if (substr($compressed_sentence, length($compressed_sentence)-1) eq "º") {
	   $compressed_sentence = $compressed_sentence." ";
   }

   $compressed_alias_sentence = ApplyMakeCompressedAliasSentence($general_args, $meaning_args, $compressed_sentence, $compressed_already_hash);

   if (substr($compressed_alias_sentence, length($compressed_alias_sentence)-1) eq "º") {
	   $compressed_alias_sentence = $compressed_alias_sentence." ";
   }

   $wordbag_compressed_sentence = ApplyGenWordList($$general_args{"main_language"}, $compressed_sentence, $wordlist_already_hash);

   if (substr($wordbag_compressed_sentence, length($wordbag_compressed_sentence)-1) eq "º") {
	   $wordbag_compressed_sentence = $wordbag_compressed_sentence." ";
   }

   $wordbag_compressed_alias_sentence = ApplyGenWordList($$general_args{"main_language"}, $compressed_alias_sentence, $wordlist_already_hash);

   if (substr($wordbag_compressed_alias_sentence, length($wordbag_compressed_alias_sentence)-1) eq "º") {
	   $wordbag_compressed_alias_sentence = $wordbag_compressed_alias_sentence." ";
   }

   return ($compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_sentence, $wordbag_compressed_alias_sentence);
}

sub TransSentence
{
   my($trans_hash, $extra_sent_hash, $cat_hash, $sentence) = @_;

   my($elem);
   my($item_category);
   my($scount) = 0;

   if (scalar keys %{$$trans_hash{$sentence}} != 0) {
	   foreach $elem ( sort { $a cmp $b } keys %{$$trans_hash{$sentence}}) {
		   if ($scount == 0) {
			   $sentence = $elem;
			   $item_category = $$cat_hash{$elem};
			   $scount++;
		   } else {
			   $$extra_sent_hash{$elem}{$item_category}++;
		   }
	   }
   } else {
	   $sentence = "***Blank***";
   }

   return ($sentence);
}

sub ApplyTransSentence
{
   my($sentence, $trans_hash, $original_cat_array) = @_;

   my($elem);
   my($elem1);
   my($i);
   my(%cat_hash);
   my(%extra_sent_hash);
   my(@sent_array) = split /\º/, $sentence;

   for ($i = 0; $i < scalar(@sent_array); $i++) {
	   $cat_hash{$sent_array[$i]} = $$original_cat_array[$i];
   }

   $sentence =~ s/(((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/TransSentence($trans_hash, \%extra_sent_hash, \%cat_hash, $1)/eg;

   foreach $elem ( sort { $a cmp $b } keys %extra_sent_hash) {
	   $sentence = $sentence."º".$elem;

	   foreach $elem1 ( sort { $a cmp $b } keys %{$extra_sent_hash{$elem}}) {
		   push @$original_cat_array, $elem1;

		   last;
	   }
   }

   return ($sentence);
}

sub ApplyGoodFragmentList
{
    my($good_fragment_list_hash, $utt) = @_;

    my($elem);

	if ($utt =~ /\-/) {
		if (scalar (keys %{$good_fragment_list_hash}) > 0) {
			if ($utt =~ /\-(\w|\'){5,}|(\w|\'){5,}\-/) {
				foreach $elem ( sort { $a cmp $b } keys %{$good_fragment_list_hash}) {
					if ($utt =~ /\-$elem/) {
						$utt =~ s/( \-$elem)|(^\-$elem)/ $elem /g;
						$utt =~ s/(\t\-$elem)/\t$elem /g;
					}

					if ($utt =~ /$elem\-/) {
						$utt =~ s/($elem\- )|($elem\-$)/ $elem /g;
				    }
			    }
		    }
	    }
	}

	$utt = TrimChars($utt);

#						$utt =~ s/( \-$elem|$elem\- )|(^\-$elem|$elem\-$)/$elem/g;
#	                    $utt =~ s/(\t\-$elem)/\t$elem/g;

	return ($utt);
}

sub BuildRepStrings
{

    my($now, $out_array) = @_;

	my($build_string1);
	my($build_string2);
	my($build_string3);
	my($build_string4);
	my($elem1);
	my(@now_array);

	@now_array = split /\>/, $now;

	@$out_array = ();

	$build_string1 = "";
	$build_string2 = "";
	$build_string3 = "";
	$build_string4 = "";
	foreach $elem1 (@now_array) {
		if ($build_string1 eq "") {
			$build_string1 = $elem1;
			$build_string2 = $elem1;
			$build_string3 = $elem1;
			$build_string4 = $elem1;
		} else {
			$build_string1 = $build_string1.$elem1;
			$build_string2 = $build_string2." ".$elem1;
			$build_string3 = $build_string3."_".$elem1;
			$build_string4 = $build_string4."-".$elem1;
		}
	}

	push @$out_array, $build_string1;
	push @$out_array, $build_string2;
	push @$out_array, $build_string3;
	push @$out_array, $build_string4;
}

sub ApplyCommonCorrectionRules_1
{
    my($cleaning_args, $utt) = @_;

	my($elem);
	my($temp_utt);
	my($pos);

	my($frag_found);

	if (1) {
	    $utt =~ s/\[fragment\]/ /;
	} else {
	    if ($utt =~ /((\w|\')+\[fragment\])/) {
		$frag_found = 1;
		while ($frag_found) {
		    $pos = index($utt, "[fragment]");
		    if ($pos == -1) {
			$frag_found = 0;
		    } elsif ($pos == 0) {
			if (substr($utt, $pos+10, 1) !~ /[a-zA-Z]/) {
			    $frag_found = 0;
			}
		    } elsif (substr($utt, $pos-1, 1) !~ /[a-zA-Z]/) {
			$frag_found = 0;
		    }
		    
		    if ($frag_found) {
			$utt =~ s/\[fragment\]/\- /;
		    }
		    
		    $frag_found = 0;
		    if ($utt =~ /((\w|\')+\[fragment\])/) {
			$frag_found = 1;
		    }
		}
		
		$utt = TrimChars($utt);
	    }
	}

	$utt =~ s/\[ah\]/ ah /g;
	$utt =~ s/\[uh\]/ uh /g;
	$utt =~ s/\[um\]/ um /g;
	$utt = TrimChars($utt);

	foreach $elem (@{$$cleaning_args{"omit"}}) {
	    if (index($elem, "\@") != -1) {
		$utt =~ s/$elem/ /g;
	    } else {
		if (($elem eq "fragment") && ($utt =~ /((\w))+\[fragment\]/)) {
		    $utt =~ s/((\w))+\[$elem\]/ /g;
		} elsif (($elem eq "fragment") && ($utt =~ /\[fragment\]((\w))+/)) {
		    $utt =~ s/\[$elem\]((\w))+/ /g;
		}
		
		$temp_utt = $utt;
		
		$utt =~ s/\[$elem\]/ /g;
	    }
	}

	$utt = TrimChars($utt);

	foreach $elem (@{$$cleaning_args{"char_omit"}}) {
		$elem =~ s/:/|/g;
		$utt =~ s/$elem/ /g;
	}

	$utt = TrimChars($utt);

	$utt = ApplyGoodFragmentList($$cleaning_args{"good_fragment_list"}, $utt);

	$utt = TrimChars($utt);

    return $utt;
}

sub ApplyCommonCorrectionRules_2
{
    my($cleaning_args, $utt) = @_;

	my($elem);
	my($elem1);
	my($temp_utt);
	my(@out_array);

	$temp_utt = $utt;
    $utt =~ s/(((^((\-|\~)+)(\w|\')+)))|((( ((\-|\~)+)(\w|\')+)))|((((\w|\')+))((\-|\~)+) )/ /g;
    $utt =~ s/(((^((\-|\~)+)(\w|\')+)))/ /g;
    $utt =~ s/((( ((\-|\~)+)(\w|\')+)))/ /g;
    $utt =~ s/((((\w|\')+))((\-|\~)+) )/ /g;

    $utt =~ s/((((\w|\')+))((\-|\~)+)\º)|(((^((\-|\~)+)(\w|\')+\º)))/\º/g;
    $utt =~ s/((((\w|\')+))((\-|\~)+)\º)/\º/g;
    $utt =~ s/(((^((\-|\~)+)(\w|\')+\º)))/\º/g;

    $utt =~ s/(^((\-|\~)+)(\w|\')+)/\º/g;
    $utt =~ s/(\º((\-|\~)+)(\w|\')+)/\º/g;

    $utt =~ s/(^((\-|\~)+)\º)/\º/g;
    $utt =~ s/(\º((\-|\~)+)\º)/\ºÂ\º/g;

    $utt =~ s/(((\t((\-|\~)+)(\w|\')+)))/\t /g;

    $utt =~ s/(\[\](((\w|\')+)))/ /g;
    $utt =~ s/((((\w|\')+))\[\])/ /g;
    $utt =~ s/(((\w|\')+)\[\]((\w|\')+))/ /g;

	$utt = TrimChars($utt);

	foreach $elem (@{$$cleaning_args{"delete_char"}}) {
		if (index($elem,">") != -1) {
			BuildRepStrings($elem, \@out_array);

			foreach $elem1 (@out_array) {
				$utt =~ s/\b$elem1\b/ /g;
			}
		} else {
			$utt = MaskEscChars($utt);
			if (($elem eq "-") || ($elem eq "~")) {
				$utt =~ s/( $elem)|($elem )/ /g;

				if ((($utt eq "-") && ($elem eq "-")) || (($utt eq "~") && ($elem eq "~"))) {
					$utt = "";
				}
			} else {
				$elem = MaskEscChars($elem);

				$utt =~ s/\b$elem\b/ /g;
			}

			$utt = RestoreEscChars($utt);
		}
	}

	$utt = TrimChars($utt);

    return $utt;
}

sub ApplySpellingCorrectionRules
{
    my($cleaning_args, $utt) = @_;

	my($elem);
	my($elem1);
	my($found);
	my($mod_now);
	my($now);
	my($correction);
	my($temp_utt) = $utt;
	my($temp_correct_spelling_test_string) = $$cleaning_args{"correct_spelling_test_string"};
	my(@out_array);

	if ($$cleaning_args{"correct_spelling_test_string"} ne "") {
		$temp_correct_spelling_test_string =~ s/\-\\b/\-/g;
		$temp_correct_spelling_test_string =~ s/\\b\-/\-/g;
		if ($temp_utt =~ /($temp_correct_spelling_test_string)/) {
			$utt = MaskEscChars($utt);
			foreach $elem (@{$$cleaning_args{"correct_spelling_list"}}) {
				$found = 0;
				($now, $correction) = split /\+/, $elem;

				if (($now ne "") && ($correction ne "")) {
					if (index($now,">") != -1) {
						BuildRepStrings($now, \@out_array);

						foreach $elem1 (@out_array) {
							$utt =~ s/\b$elem1\b/$correction/g;
						}
					} else {
						if ($now =~ /\[/) {
							$now = quotemeta($now);
							$found = 1;
						}

						if ($correction =~ /\[/) {
							$correction = quotemeta($now);
						}

						if ($found) {
						  $utt =~ s/$now/$correction/g;
						} elsif ((substr($now, length($now)-1) =~ /\-/) && (substr($now, 0, 1) =~ /\-/)) {
						  $utt =~ s/$now/$correction/g;
						} elsif (substr($now, length($now)-1) =~ /\-/) {
						  $utt =~ s/\b$now/$correction/g;
						} elsif (substr($now, 0, 1) =~ /\-/) {
						  $utt =~ s/$now\b/$correction/g;
						} elsif ((substr($now, length($now)-1) =~ /\'/) || (substr($now, 0, 1) =~ /\'/)) {
						  $mod_now = $now;
						  $mod_now =~ s/\'/\_\_\_/g;
						  $mod_now = quotemeta($mod_now);
						  $utt =~ s/$mod_now/$correction/g;
						} elsif ((substr($now, length($now)-1) =~ /\:/) || (substr($now, 0, 1) =~ /\:/)) {
						  $now = quotemeta($now);
						  $utt =~ s/$now/$correction/g;
						} elsif ((substr($now, length($now)-1) =~ /\./) || (substr($now, 0, 1) =~ /\./)) {
						  $now = quotemeta($now);
						  $utt =~ s/$now/$correction/g;
						} else {
						  $utt =~ s/\b$now\b/$correction/g;
						}
					}
				}
			}

			$utt = RestoreEscChars($utt);
		}
	}

	@out_array = ();

	$utt = TrimChars($utt);

    return $utt;
}

sub ApplyFirstCorrectionRules
{
    my($cleaning_args, $utt) = @_;

	my($first_stage_correction);

	$utt = ApplyCommonCorrectionRules_1($cleaning_args, $utt);

	$first_stage_correction = $utt;

	$utt = ApplyCommonCorrectionRules_2($cleaning_args, $utt);

    return ($utt, $first_stage_correction);

}

sub ApplyCorrectionRules
{
    my($cleaning_args, $first_stage_done, $no_response_exclusion, $utt) = @_;

	my($elem);
	my(@response_exclusion_array);

	if (!$first_stage_done) {
		$utt = ApplyCommonCorrectionRules_1($cleaning_args, $utt);
	}

	$utt = ApplySpellingCorrectionRules($cleaning_args, $utt);

	$utt = ApplyCommonCorrectionRules_2($cleaning_args, $utt);

	foreach $elem (@{$$cleaning_args{"exclude_nums"}}) {
		$utt =~ s/(\bten\b|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|\beighty\b|ninety) ($elem)/$1_$2/g;

		$utt =~ s/((twenty|thirty|forty|fifty|sixty|seventy|\beighty\b|ninety) (\bone\b|two|three|\bfour\b|five|six|seven|\beight\b|\bnine\b)) ($elem)/$2_$3_$4/g;

		$utt =~ s/(\bone\b|two|three|\bfour\b|five|six|seven|\beight\b|nine) ($elem)/$1_$2/g;
	}

	foreach $elem (@{$$cleaning_args{"exclude_words"}}) {
		$utt =~ s/$elem/ /g;
	}

	if (!$no_response_exclusion) {
		if ($$cleaning_args{"response_exclusion"} ne "") {
			if ($$cleaning_args{"response_exclusion"} !~ /\=/) {
				if ( $utt =~ /(.*$$cleaning_args{"response_exclusion"})/ )           {
					$utt = "Response Exclusion:\t$utt";
				}
			} else {
				@response_exclusion_array = split /\|/, $$cleaning_args{"response_exclusion"};
				foreach $elem (@response_exclusion_array) {
					if (substr($elem, 0, 1) eq "=") {
						$elem = substr($elem, 1);
						if ( $utt eq $elem) {
							$utt = "Response Exclusion:\t$utt";
							last;
						}
					} else {
						if ( $utt =~ /$elem/ ) {
							$utt = "Response Exclusion:\t$utt";
							last;
						}
					}
				}
			}
		}
	}

#	if ($$cleaning_args{"ramble_exclusion"} ne "") {
#	  if ( $utt =~ /(.*$$cleaning_args{"ramble_exclusion"})/ ) {
#		$utt = "Ramble Exclusion:\t$utt";
#	  }
#	}

	$utt = TrimChars($utt);

    return $utt;
}

sub ApplyCorrectionAfterModSearch
{
    my($utt, @correct_list) = @_;

	my($elem);
	my($loopcnt);
	my($now);
	my($correction);

    $loopcnt = 0;
	foreach $elem (@correct_list) {
		$loopcnt++;
	    ($now, $correction) = split /\+/, $elem;

		if ($loopcnt == (scalar @correct_list)) {
			$correction = ChopChar($correction);
		}

	    $utt =~ s/\b$now\b/$correction/g;
	}

	$utt = TrimChars($utt);

    return $utt;

}

sub getAndCleanTestData
{
	my($general_args, $cleaning_args, $osr_args, $cat_args, $test_hash, $referencetag_hash) = @_;

	my($buildstring);
	my($buildstring_underscore);
	my($corrected_sentence);
	my($filename);
	my($item_category);
	my($line);
	my($original_trans);
	my($pre_search_string) = "";
	my($pseudo_corrected_sentence);
	my($sentence_order) = 0;
	my($temp_sentence);
	my($temp_removerepeats);
	my($test_category);
	my($transcription);
	my(%classify_truth_hash);
	my(%total_truth_hash);
	my(@cat_sentence_array);
	my(@cat_temp_word_array);
	my(@corrected_array);
	my(@elem_array);
	my(@original_cat_array);
	my(@original_filename_array);
	my(@original_transcription_array);

	open(TESTFILE,"<".$$osr_args{"addtestfile"}) or die "cant open ".$$osr_args{"addtestfile"};
	while(<TESTFILE>) {
		$line = ChopChar($_);

		if (substr($line,0,1) eq "#") {
			next;
		}

		if ($line eq "") {
			next;
		}

		($filename, $transcription, $item_category) = split "\t", $line;
		$filename =~ s/\"//g;
		$transcription =~ s/\"//g;

		(@cat_temp_word_array) = split " ", $transcription;

		if (index($transcription, "/") != -1) {
			ExpandSentence ("/", \@cat_temp_word_array, \@cat_sentence_array);
		} else {
			push @cat_sentence_array, $transcription;
		}

		foreach $transcription (@cat_sentence_array) {
			$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
			push @original_cat_array, $item_category;

			$original_filename_array[$sentence_order] = $filename;
			$original_transcription_array[$sentence_order] = $transcription;

			$pre_search_string = stringBuilder($pre_search_string, $transcription."º", "");

			$sentence_order++;
		}

		@cat_sentence_array = ();
	}

	$test_category = "APPLY_CLASS_GRAMMARS_TO_ALL_CATEGORIES";

	$temp_removerepeats = $$cleaning_args{"removerepeats"};
	$$cleaning_args{"removerepeats"} = 0;
	$corrected_sentence = MakeCleanTrans($general_args, $cleaning_args, 1, 0, 1, 0, $test_category, $pre_search_string);
	$$cleaning_args{"removerepeats"} = $temp_removerepeats;

	$corrected_sentence = MoreClean($corrected_sentence);

	@corrected_array = split /\º/, $corrected_sentence;

	$sentence_order = 0;
	foreach $corrected_sentence (@corrected_array) {
		$item_category = $original_cat_array[$sentence_order];
		$filename = $original_filename_array[$sentence_order];
		$original_trans = $original_transcription_array[$sentence_order];
#		$pseudo_corrected_sentence = $pseudo_corrected_array[$sentence_order];
		$pseudo_corrected_sentence = $corrected_sentence;

		$temp_sentence = $corrected_sentence;
		if (($corrected_sentence eq "") || ($corrected_sentence eq " ")) {
			$temp_sentence = "*Blank*";
		}

		if (lc ($item_category) eq lc($$general_args{"test_reject_name"})) {
			$buildstring = $$general_args{"test_reject_name"};
		} else {
			if ($$general_args{"downcase_utt"}) {
				(@elem_array) = split " ", lc($item_category);
			} else {
				(@elem_array) = split " ", $item_category;
			}

			$buildstring = join " ", map {ucfirst} @elem_array;
		}

		$filename = ChopChar($filename);

		$buildstring = ChopChar($buildstring);
		$buildstring = NormCat($buildstring, $$general_args{"test_reject_name"});

		$buildstring_underscore = $buildstring;
		$buildstring_underscore =~ s/ /_/g;
		if (defined $$referencetag_hash{lc($buildstring)}) {
		    $buildstring = $$referencetag_hash{lc($buildstring)};
		} elsif (defined $$referencetag_hash{lc($buildstring_underscore)}) {
		    $buildstring = $$referencetag_hash{lc($buildstring_underscore)};
		}

		$classify_truth_hash{$temp_sentence}{$buildstring}++;
		$$test_hash{$temp_sentence}{$item_category}++;
		$total_truth_hash{"\"$filename\""}{$original_trans}{$pseudo_corrected_sentence}{$temp_sentence}++;

		$sentence_order++;
	}

	makeTruthFiles($general_args, $osr_args, $cat_args, 0, 0, "alltest", \%total_truth_hash, \%classify_truth_hash);
}

################# END Clean and Correction SUBROUTINES ###################

######################################################################
######################################################################
############# Category Processing SUBROUTINES ########################
######################################################################
######################################################################

sub FillBuildStrings
{
   my($meaning_args, $wordnet_args, $sentence) = @_;

   my($build_string) = "";
   my($elem1);
   my($filler_count) = 0;
   my($gsl_filler_build_string) = "";
   my($gsl_filler_counter) = 0;
   my($keep_string) = "";
   my($pos) = 0;
   my($skip_string) = "";
   my($success);
   my($valid_pending_build_string) = "";
   my($valid_start_found) = 0;
   my($within_valid) = 0;
   my(@sent_to_rule_array);

   (@sent_to_rule_array) = split " ", $sentence;

   if (scalar (@sent_to_rule_array) > $$meaning_args{"sentence_length_for_scan"}) {
	   while (scalar (@sent_to_rule_array) > $$meaning_args{"sentence_length_for_scan"}) {
		   pop @sent_to_rule_array;
	   }
   }

   while ($pos < scalar (@sent_to_rule_array)) {
	   $skip_string = "";
	   $keep_string = "";
	   ($success, $pos, $skip_string, $keep_string) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, \@sent_to_rule_array, $pos, $skip_string, $keep_string);

	   if ($skip_string ne "") {
		   if ($within_valid) {
			   if ($valid_pending_build_string ne "") {
				   $valid_pending_build_string = $valid_pending_build_string.")_FILLER5_(";
			   } else {
				   $build_string = $build_string.")_FILLER5_(";
				   $gsl_filler_build_string = $gsl_filler_build_string.") \?(\*-filler-) (";
				   $gsl_filler_counter++;
			   }

			   $filler_count++;
		   }

		   $within_valid = 0;
	   } else {
		   $elem1 = TrimChars($keep_string);

		   if ($valid_pending_build_string ne "") {
			   $build_string = $build_string." ".$valid_pending_build_string;
			   $gsl_filler_build_string = $gsl_filler_build_string." ".$valid_pending_build_string;
			   $valid_pending_build_string = "";
		   }

		   if (not defined $$meaning_args{"valid_restricted_general"}{$elem1}) {
			   if (!$valid_start_found) {
				   $build_string = "(($elem1";
				   $gsl_filler_build_string = "(($elem1";
			   } else {
				   if (defined $$meaning_args{"valid_restricted_end"}{$elem1}) {
					   if ($pos < (scalar (@sent_to_rule_array) - 1)) {
						   $valid_pending_build_string = $elem1;
					   }
				   } else {
					   $build_string = $build_string." $elem1";
					   $gsl_filler_build_string = $gsl_filler_build_string." $elem1";
				   }
			   }

			   $valid_start_found = 1;
			   $within_valid = 1;
		   } else {
			   if (!$valid_start_found) {
				   $build_string = "(($elem1";
				   $gsl_filler_build_string = "(($elem1";

				   $valid_start_found = 1;
				   $within_valid = 1;
			   }
		   }
	   }
   }

   if ($build_string ne "") {
	   $build_string = $build_string."))";
	   $gsl_filler_build_string = $gsl_filler_build_string."))";

	   $build_string =~ s/_\( /_\(/g;
	   $build_string =~ s/_FILLER5_\(\)//g;
	   $build_string =~ s/\(\)_FILLER5_//g;

	   $gsl_filler_build_string =~ s/ \( / \(/g;
	   $gsl_filler_build_string =~ s/ \?\(\*-filler-\) \(\)//g;
	   $gsl_filler_build_string =~ s/\(\) \?\(\*-filler-\) //g;
   }

# ATTENTION
#   if ($filler_count > 3) {
#	   $build_string = "";
#   }

   return ($build_string, $filler_count, $gsl_filler_build_string, $gsl_filler_counter);
}

sub Classify_Output_Format {

    my($general_args, $meaning_args, $wordnet_args, $i, $corrected_array, $keyword_2_filtered_utt_hash, $wordbag_keyword_2_filtered_utt_hash, $filename, $filename_ready, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, $assignment_source, $utt, $classify_truth_hash, $original_transcription_array, $item_category, $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash, $referencetag_hash) = @_;

	my($buildstring);
	my($buildstring_underscore);
	my($confirmed_as);
	my($corrected_utt);
	my($keep_string);
	my($original_utt);
	my($temp_corrected_utt);
	my($wordbag_keep_string);
	my(@elem_array);

	$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
	($item_category, $confirmed_as) = SetConfirm_As($item_category);

	if (lc ($item_category) eq lc($$general_args{"test_reject_name"})) {
		$buildstring = $$general_args{"test_reject_name"};
	} else {
		if ($$general_args{"downcase_utt"}) {
			(@elem_array) = split " ", lc($item_category);
		} else {
			(@elem_array) = split " ", $item_category;
		}

		$buildstring = join " ", map {ucfirst} @elem_array;
	}

	$original_utt = @$original_transcription_array[$i];
	$corrected_utt = @$corrected_array[$i];

	$filename = ChopChar($filename);

	$buildstring = ChopChar($buildstring);
	$buildstring = NormCat($buildstring, $$general_args{"test_reject_name"});

	$buildstring_underscore = $buildstring;
	$buildstring_underscore =~ s/ /_/g;
	if (defined $$referencetag_hash{lc($buildstring)}) {
	  $buildstring = $$referencetag_hash{lc($buildstring)};
	} elsif (defined $$referencetag_hash{lc($buildstring_underscore)}) {
	  $buildstring = $$referencetag_hash{lc($buildstring_underscore)};
	}

	$utt = ChopChar($utt);
	$original_utt = ChopChar($original_utt);
	$corrected_utt = ChopChar($corrected_utt);

	if (($buildstring ne "DISCARD") && ($buildstring ne "RAMBLE_EXCLUSION")) {
	  $$classify_truth_hash{$utt}{$buildstring}++;
	}

	$keep_string = "";
	$temp_corrected_utt = "";
	if (lc($corrected_utt) !~ /\*blank\*/) {
		$keep_string = CheckSkipPhrase("loc7", $meaning_args, $wordnet_args, $corrected_utt);
		$temp_corrected_utt = $corrected_utt;
	}

	WriteClassifications($general_args, "Classify_Output_Format:", $filename, $filename_ready, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, $assignment_source, $buildstring, $utt, $original_utt, $temp_corrected_utt, $keep_string, $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);

	if ($keep_string ne "") {
		$$keyword_2_filtered_utt_hash{$keep_string}{$buildstring}{"$original_utt:truth"}++;
		$wordbag_keep_string = GenWordList($$general_args{"main_language"}, $keep_string, $wordlist_already_hash);
		$$wordbag_keyword_2_filtered_utt_hash{$wordbag_keep_string}{$buildstring}{"$original_utt:truth"}++;
	}
}

sub NormCat
{
   my($item_category, $test_reject_name) = @_;

   my($temp_test_reject_name) = lc($test_reject_name);
   my($temp_test_reject_name_1) = lc($test_reject_name);

   $temp_test_reject_name_1 =~ s/\_/ /g;

   if ((lc($item_category) eq $temp_test_reject_name) || (lc($item_category) eq $temp_test_reject_name_1)) {
	   $item_category = $test_reject_name;
   }

   $item_category =~ s/\//\-/g;
   $item_category = TrimChars($item_category);

   return ($item_category);
}

sub ReadNewCats
{
   my($general_args, $cleaning_args, $read_newcats, $old_rules_file) = @_;

   my($cat_confirm_as);
   my($cat_neg);
   my($cat_nl_rules_lineout);
   my($cat_plus_conf);
   my($cat_shift);
   my($cat_title);
   my($elem);
   my($elem1);
   my($firstchar);
   my($item_category);
   my($line);
   my($newcat_created) = 0;
   my($newcats_found) = 1;
   my($old_rules_found) = 1;
   my($temp_sentence);
   my(%newcat_sent_hash);
   my(%newcat_sent_original_hash);
   my(%old_rules_added_sentences);
   my(%old_rules_sentences);
   my(@newcats_contents);
   my(@newcats_original_contents);
   my(@old_rules_contents);

   unless (open(OLDRULESIN,"<$old_rules_file")) {
	   $old_rules_found = 0;

	   print "OLDRULESIN: Can't find $old_rules_file\n\n";
   }

   unless (open(NEWCATSIN,"<$read_newcats")) {
	   $newcats_found = 0;

	   print "NEWCATSIN: Can't find $read_newcats\n\n";
   }

   if ($old_rules_found && $newcats_found) {
	   open(CATOUT,">$old_rules_file"."_changed") or die "cant write $old_rules_file"."_changed";

	   if ( not (-e "$read_newcats"."_original")) {
		   $newcat_created = 1;
		   open(NEWCATOUT,">$read_newcats"."_original") or die "cant write $read_newcats"."_original";
	   }

	   (@old_rules_contents) = (<OLDRULESIN>);
	   (@newcats_contents) = (<NEWCATSIN>);

#ATTENTION5
#	   if ( !$newcat_created ) {
	   if (0) {
		   my($errors_found) = 0;
		   my($sentence1);
		   my($sentence2);
		   my($item_category1);
		   my($item_category2);
		   my($target_sentences) = "slmdirect_results\/createslm_init_sentences";
		   my(@sentcat_contents2_array);
		   my($sent_count);

		   open(NEWCATORIG,"<$read_newcats"."_original") or die "cant open $read_newcats"."_original";
		   (@newcats_original_contents) = (<NEWCATORIG>);
		   close(NEWCATORIG);

		   foreach $elem ( @newcats_original_contents ) {
			   $elem = ChopChar($elem);

			   if (substr($elem,0,1) eq "#") {
				   next;
			   }

			   ($item_category, $temp_sentence) = split "\t", $elem;

			   $newcat_sent_original_hash{lc($item_category)}{$temp_sentence}++;
		   }

		   CALL_SLMDirect(0, 0, $vanilla_callingProg, $$general_args{"main_language"}, "", "", $$general_args{"grammar_type"}, "", "createslm_init_nlrules", "temp1234", $$general_args{"downcase_utt"}, $$cleaning_args{"removerepeats"}, $target_sentences, "", ".", 0, "", 0, "", "");

			open(SENTCATIN2,"<temp1234_category_only") or die "cant open temp1234_category_only";
			(@sentcat_contents2_array) = (<SENTCATIN2>);
			close(SENTCATIN2);

			open(SENTERROR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts";

			$sent_count = 0;
			foreach $elem (@newcats_original_contents) {
				($item_category1, $sentence1) = split "\t", $elem;
				$elem1 = $sentcat_contents2_array[$sent_count];
				($sentence2, $item_category2) = split "\t", $elem1;
				$sentence1 = ChopChar($sentence1);
				$item_category2 = ChopChar($item_category2);
				if (lc($item_category1) ne lc($item_category2)) {
					$errors_found = 1;
					if ($item_category2 eq "") {
						print SENTERROR "Hand-Assigned: $item_category1\t$sentence1\nRule-Assigned: *UNK*\t$sentence2\n\n";
					} else {
						print SENTERROR "Hand-Assigned: $item_category1\t$sentence1\nRule-Assigned: $item_category2\t$sentence2\n\n";
					}
				}

				$sent_count++;
			}

			close(SENTCATOUT);

			unlink "temp1234";
			unlink "temp1234_category_only";

			if ($errors_found) {
				DebugPrint ("BOTH", 2, "ReadNewCats", $debug, $err_no++, "RULE INCONSISTENCIES: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts");
			}
	   }
# ---------------------------------------------------------------------------

	   foreach $elem ( @newcats_contents ) {
		   if ( $newcat_created ) {
			   print NEWCATOUT "$elem";
		   }

		   $elem = ChopChar($elem);

		   if (substr($elem,0,1) eq "#") {
			   next;
		   }

		   ($item_category, $temp_sentence) = split "\t", $elem;

		   $newcat_sent_hash{lc($item_category)}{$temp_sentence}++;
	   }

	   close(NEWCATOUT);

	   $cat_shift = "";
	   $line = shift @old_rules_contents;
	   while (scalar @old_rules_contents > 0) {

		   ($line, $firstchar) = ProcessCharsPlus($line);

		   if (($line =~ /Rule Container Format/) || ($line =~ /Rule_Definition_Line/) || ($line =~ /If Category_Name contains/)) {
			   print CATOUT "$line\n";

			   $line = shift @old_rules_contents;
			   next;
		   }

		   if ($line eq "") {
			   $line = shift @old_rules_contents;
			   next;
		   }

		   if (substr($line,0,1) eq "#") {
			   $line =~ s/\#//;
			   $line = TrimChars($line);

			   if ($line =~ /\>\>\>ADDED:/) {
				   $line =~ s/\>\>\>ADDED: //;
				   $line = TrimChars($line);
				   $old_rules_added_sentences{$line}++;
			   } else {
				   $old_rules_sentences{$line}++;
			   }

			   $line = shift @old_rules_contents;
			   next;
		   }

		   ($cat_plus_conf, $cat_nl_rules_lineout) = split ":", $line;
		   ($item_category, $cat_confirm_as, $cat_title, $cat_neg) = split ",", $cat_plus_conf;
		   $cat_nl_rules_lineout = lc($cat_nl_rules_lineout);

		   if ($cat_title eq "") {
			   $cat_title = lc($cat_confirm_as);
		   }

		   if ($cat_title eq "") {
			   $cat_title = lc($item_category);
		   }

		   if ($cat_shift ne $cat_title) {
			   $cat_shift = $cat_title;
			   print CATOUT "\n\n";
			   foreach $elem ( sort { $a cmp $b } keys %{ $newcat_sent_hash{$cat_title} }) {
				   if (defined $old_rules_sentences{$elem}) {
					   print CATOUT "\#", "$elem\n";
				   } elsif (defined $old_rules_added_sentences{$elem}) {
					   print CATOUT "\#>>>ADDED: ", "$elem\n";
				   } else {
					   print CATOUT "\#>>>ADDED: ", "$elem\n";
				   }
			   }
		   }

		   print CATOUT "$line\n";
		   $line = shift @old_rules_contents;
	   }

	   close(CATOUT);

	   if ( $newcat_created ) {
		   DebugPrint ("BOTH", 1, "ReadNewCats", $debug, $err_no++, "File created: $read_newcats"."_original");
	   }

	   DebugPrint ("BOTH", 1, "ReadNewCats", $debug, $err_no++, "File created: $old_rules_file"."_changed");
   }
}

sub WriteClassifications
{
    my($general_args, $where, $filename, $filename_ready, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, $assignment_source, $item_category, $changed_utt, $original_utt, $corrected_utt, $keep_string, $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash) = @_;

	my($wordbag_keep_string);

	$item_category = ChopChar($item_category);
	$item_category = TrimChars($item_category);
	$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
	$changed_utt = ChopChar($changed_utt);
	$changed_utt = TrimChars($changed_utt);
	$original_utt = ChopChar($original_utt);
	$original_utt = TrimChars($original_utt);

	if (!$do_suppress_grammar) {
		if ($keep_string ne "") {
			$wordbag_keep_string = GenWordList($$general_args{"main_language"}, $keep_string, $wordlist_already_hash);
			print $filename "$wavfilename\t$original_utt\t$changed_utt\t$assignment_source\t$item_category\t$wordbag_keep_string\n";
#		print $filename "A: where=$where, wavfilename=$wavfilename, original_utt=$original_utt,changed_utt=$changed_utt,assignment_source=$assignment_source,item_category=$item_category,wordbag_keep_string=$wordbag_keep_string\n";
		} else {
#		print $filename "B: where=$where, wavfilename=$wavfilename, original_utt=$original_utt,changed_utt=$changed_utt,assignment_source=$assignment_source,item_category=$item_category\n";

			print $filename "$wavfilename\t$original_utt\t$changed_utt\t$assignment_source\t$item_category\n";
		}

		if (($$general_args{"no_tag_unknown"}) && (lc($item_category) eq "unknown")) {
		  print $filename_ready "$wavfilename\t$original_utt\n";
		} else {
		  print $filename_ready "$wavfilename\t$original_utt\t$item_category\n";
		}
	}

	if (($where eq "BLANK_INPUT_LINE:") || ($where eq "RESPONSE_EXCLUSION:") || ($where eq "RAMBLE_EXCLUSION:") || ($where eq "item_category blank:") || ($where eq "changed_utt empty:") || ($where eq "changed_utt No Rule:")) {
		print $classifyfileout_unknown "$wavfilename\t$original_utt\n";
	} else {
		print $classifyfileout_vanilla "$wavfilename\t$original_utt\t$item_category\n";
	}

	if (!$do_suppress_grammar) {
		if (lc ($assignment_source) !~ /blank/) {
			$assignment_source =~ s/ /_/g;
			$assignment_source =~ s/_Stored//g;
			if (lc($assignment_source) =~ /reject/) {
				$assignment_source = "REJECT";
			} elsif (lc($assignment_source) =~ /no_rule/) {
				$assignment_source = "UNKNOWN";
			} elsif ((lc($assignment_source) =~ /known_assignment/) && (lc($assignment_source) !~ /wordbag/)) {
				$assignment_source = "KNOWN_ASSIGNMENT";
			} elsif ((lc($assignment_source) =~ /known_assignment/) && (lc($assignment_source) =~ /wordbag/)) {
				$assignment_source = "KNOWN_ASSIGNMENT_WORDBAG";
			}

			$$classify_result_hash{$assignment_source}{"$corrected_utt\t$item_category"}++;
		}
	}
}

sub SqueezeSentence
{
   my($meaning_args, $wordnet_args, $changed_utt) = @_;

   my($elem1);
   my($pos) = 0;
   my(@skip_array);
   my(@keep_array);
   my($skip_string) = "";
   my($keep_string) = "";
   my($success);
   my(@sent_to_rule_array);
   my($filtered_utt);

   my($sent_totally_squeezed);

   $sent_totally_squeezed = 0;
   (@sent_to_rule_array) = split " ", $changed_utt;

   if (scalar (@sent_to_rule_array) > $$meaning_args{"sentence_length_for_scan"}) {
	   while (scalar (@sent_to_rule_array) > $$meaning_args{"sentence_length_for_scan"}) {
		   pop @sent_to_rule_array;
	   }

	   $changed_utt = join " ", @sent_to_rule_array;
   }

   $filtered_utt = $changed_utt;
   # >>>>>>> filter changed_utt for skip words on either side
   (@sent_to_rule_array) = split " ", $filtered_utt;

   $pos = 0;
   $skip_string = "";
   $keep_string = "";
   $success = 1;
   while ($success) {
	   ($success, $pos, $skip_string, $keep_string) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, \@sent_to_rule_array, $pos, $skip_string, $keep_string);
   }

   @skip_array = split " ", $skip_string;

   foreach $elem1 (@skip_array) {
	   shift @sent_to_rule_array;
   }

   if (scalar (@sent_to_rule_array) > 0) {
	   $keep_string = CheckSkipPhrase2($meaning_args, $wordnet_args, \@sent_to_rule_array);
	   @keep_array = split " ", $keep_string;
	   while (((scalar @keep_array) > 0) && ((defined $$meaning_args{"valid_restricted_end"}{$keep_array[-1]}) ||(defined $$meaning_args{"valid_restricted_general"}{$keep_array[-1]}) )) {
		   pop @keep_array;
	   }

	   while (((scalar @sent_to_rule_array) > 0) && ($sent_to_rule_array[-1] ne $keep_array[-1])) {
		   pop @sent_to_rule_array;
	   }

	   if (scalar (@sent_to_rule_array) > 0) {
		   $filtered_utt = join " ", @sent_to_rule_array;
	   }
   } else {
	   $sent_totally_squeezed = 1;
	   $filtered_utt = "";
   }

   return ($sent_totally_squeezed, $changed_utt, $filtered_utt);
}

sub	MakeMCLGrammar {
    my($general_args, $meaning_args, $response_exclusion_tag_string, $wordnet_args, $gen_grammar_elem_hash, $do_include_garbagereject, $changed_utt_repeat_hash, $repeat_num, $item_category, $cat_sentence_array, $utt_source, $gsl_filler_hash, $rule_multiplier, $allow_general_hash, $disallow_general_hash, $do_addmainrules_only) = @_;

	my($ambig_active) = 0;
	my($changed_utt);
	my($confirmed_as);
	my($do_the_add);
	my($elem);
	my($elem1);
	my($filtered_utt);
	my($sent_totally_squeezed);
	my($temp_item_category);
	my($temp_test_reject_name) = lc($$general_args{"test_reject_name"});

	$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
	($item_category, $confirmed_as) = SetConfirm_As($item_category);
	$temp_item_category = lc($item_category);

	foreach $changed_utt (@$cat_sentence_array) {
		$changed_utt = TrimChars($changed_utt);

		if (($changed_utt ne "") && (lc($changed_utt) !~ /\*blank\*/)) {
#			if (not defined $$changed_utt_repeat_hash{"$changed_utt"."_"."$item_category"}) {

				($sent_totally_squeezed, $changed_utt, $filtered_utt) = SqueezeSentence($meaning_args, $wordnet_args, $changed_utt);

				if ($sent_totally_squeezed) {
					$item_category = $$general_args{"test_reject_name"};
					$confirmed_as = $$general_args{"test_reject_name"};
				}

				$$changed_utt_repeat_hash{"$changed_utt"."_"."$item_category"} = "$item_category:$confirmed_as:$filtered_utt";
#			} else {
#				($item_category, $confirmed_as, $filtered_utt) = split ":", $$changed_utt_repeat_hash{"$changed_utt"."_"."$item_category"};
#			}

			$do_the_add = 1;
			if ($do_addmainrules_only) {
				if ($changed_utt !~ / /) {
					if (not defined $$allow_general_hash{$changed_utt}) {
						$$disallow_general_hash{$changed_utt}++;
						$do_the_add = 0;
					}
				}
			}

			if ($do_the_add) {
			  if (($do_include_garbagereject) || (lc($item_category) !~ /$temp_test_reject_name/)) {
				if ($response_exclusion_tag_string ne "") {
				  if (lc($response_exclusion_tag_string) =~ /\b($temp_item_category)\b/) {
#					print "hereaaa2: changed_utt=$changed_utt, item_category=$item_category\n";

					next;
				  }
				}

				FillGrammarElements($general_args, $gen_grammar_elem_hash, $repeat_num, $changed_utt, $filtered_utt, $item_category, $ambig_active, $$general_args{"grammar_type"}, $utt_source);
			  }
			}
		 }
	  }
  }

sub CheckKeywordHashes
{
   my($type_suffix, $language_suffix, $keyword_hash, $keyword_single_hash, $keyword_cat_sentence_hash, $line_2_keyword_hash, $orig_2_line_hash, $filename_2_line_hash, $keyword_2_orig_hash, $orig_touched_hash) = @_;

   my(@temp_array);
   my($elem1);
   my($elem2);
   my($elem3);
   my($elem4);
   my($elem5);
   my($min_num) = 1;
   my(%wordbag_cats_hash);

   if (scalar (keys %{$keyword_hash}) > 0) {
	   open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_vs_keywords"."$type_suffix"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_vs_keywords"."$type_suffix"."$language_suffix";

	   foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_hash}) {
		 print KEYOUT "$elem1\t";
		 foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_hash{$elem1}}) {
		   print KEYOUT "($elem2) ";
		 }

		 if ($keyword_single_hash ne "") {
		   foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_single_hash{$elem1}}) {
			 print KEYOUT "($elem2) ";
		   }
		 }

		 print KEYOUT "\n\n";
	   }

	   if ($type_suffix ne "") {
		   foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_hash}) {
			   foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_hash{$elem1}}) {
				   @temp_array = split " ", $elem2;
				   foreach $elem3 (@temp_array) {
					   $wordbag_cats_hash{$elem3}{$elem1}++;
				   }
			   }
		   }

		   print KEYOUT "\n\nWORDS in Multi-CATS:\n\n";
		   foreach $elem1 ( sort { $a cmp $b } keys %wordbag_cats_hash) {
			   if (scalar (keys %{$wordbag_cats_hash{$elem1}}) > 1) {
				   print KEYOUT "$elem1\t";
				   foreach $elem2 ( sort { $a cmp $b } keys %{$wordbag_cats_hash{$elem1}}) {
					   print KEYOUT "($elem2) ";
				   }

				   print KEYOUT "\n\n";
			   }
		   }

	   }

	   close(KEYOUT);
   } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_vs_keywords"."$type_suffix"."$language_suffix";
   }

   if (scalar (keys %{$keyword_cat_sentence_hash}) > 0) {
	   open(KEYOUT,">"."slmdirect_results\/createslmDIR_info_files\/info_multi_keyword_category_xref"."$type_suffix"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_info_files\/info_multi_keyword_category_xref"."$type_suffix"."$language_suffix";

	   foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_cat_sentence_hash}) {
		   if (scalar keys %{$$keyword_cat_sentence_hash{$elem1}} > $min_num) {
			   print KEYOUT "$elem1\t";
		   }

		   if (scalar keys %{$$keyword_cat_sentence_hash{$elem1}} > $min_num) {
			   foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_cat_sentence_hash{$elem1}}) {
				   print KEYOUT "\n\t($elem2: ";
				   foreach $elem3 ( sort { $a cmp $b } keys %{$$keyword_cat_sentence_hash{$elem1}{$elem2}}) {
					   print KEYOUT "[$elem3] ";
					   foreach $elem4 ( sort { $a cmp $b } keys %{$$line_2_keyword_hash{$elem1}{$elem3}}) {
						   foreach $elem5 ( sort { $a cmp $b } keys %{$$orig_2_line_hash{$elem4}}) {
							 if ($elem5 eq "ç") {
							   $elem5 = $elem4;
							 }

							 $$keyword_2_orig_hash{$elem1}{$elem5}{$elem3}++;
							 $$orig_touched_hash{$elem5}++;
						   }
					   }
				   }

				   print KEYOUT ") ";
			   }

		   }

		   if (scalar keys %{$$keyword_cat_sentence_hash{$elem1}} > $min_num) {
			   print KEYOUT "\n\n";
		   }
	   }
   } else {
	   unlink "slmdirect_results\/createslmDIR_info_files\/info_multi_keyword_category_xref"."$type_suffix"."$language_suffix";
   }

   close(KEYOUT);

   if (scalar (keys %{$keyword_2_orig_hash}) > 0) {
	   my($orcat);
	   my($cleansent);
	   my($orsent);
	   my($newsent);
	   my(%newhash);
	   my(%new_clean_hash);

	   open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts"."$type_suffix"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts"."$type_suffix"."$language_suffix";

	   open(KEYOUTFLAT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts_flat"."$type_suffix"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts_flat"."$type_suffix"."$language_suffix";

#	   foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_2_orig_hash}) {
#		   print KEYOUT "\n# ----$elem1---\n";
#		   foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_2_orig_hash{$elem1}}) {
#			   print KEYOUT ChopChar($elem2), "\n";
#			   foreach $elem3 ( sort { $a cmp $b } keys %{$$keyword_2_orig_hash{$elem1}{$elem2}}) {
#				   $elem3 =~ s/\ª/\?/g;
#				   print KEYOUT "\t", ChopChar($elem3), "\n";
#			   }
#
#			   print KEYOUT "\n";
#		   }
#
#		   print KEYOUT "\n";
#	   }

	   foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_2_orig_hash}) {
		   foreach $elem2 ( sort { $a cmp $b } keys %{$$keyword_2_orig_hash{$elem1}}) {
			   ($orcat, $orsent) = split "\t", $elem2;
			   foreach $elem3 ( sort { $a cmp $b } keys %{$$keyword_2_orig_hash{$elem1}{$elem2}}) {
				   $elem3 =~ s/\ª/\?/g;
				   if ($elem3 eq $orsent) {
					   $newsent = $orsent;
				   } else {
					   $newsent = $orsent."|".$elem3;
				   }

				   $new_clean_hash{$elem1}{$orcat}{$elem3}{$orsent}++;
				   $newhash{$elem1}{$orcat}{$elem3}{$newsent}++;
			   }
		   }
	   }

	   foreach $elem1 ( sort { $a cmp $b } keys %new_clean_hash) {
		   print KEYOUT "\n# ----$elem1---\n\n";
		   print KEYOUTFLAT "º$elem1";
		   foreach $orcat ( sort { $a cmp $b } keys %{$new_clean_hash{$elem1}}) {
			   print KEYOUT "\t$orcat -: \n";
			   print KEYOUTFLAT "ª$orcat";
			   foreach $elem3 ( sort { $a cmp $b } keys %{$new_clean_hash{$elem1}{$orcat}}) {
#				   print "1: elem1=$elem1, orcat=$orcat, elem3=$elem3\n";
				   if (scalar (keys %{$new_clean_hash{$elem1}{$orcat}{$elem3}}) > 1) {
#				   print "2: elem1=$elem1, orcat=$orcat, elem3=$elem3\n";
					   print KEYOUT "\t\tCORR---> $elem3 \n";
					   print KEYOUTFLAT "+$elem3";
					   foreach $elem4 ( sort { $a cmp $b } keys %{$new_clean_hash{$elem1}{$orcat}{$elem3}}) {
						   print KEYOUT "\t\t\t", ChopChar($elem4), "\n";
						   print KEYOUTFLAT "#", ChopChar($elem4);
					   }

					   print KEYOUT "\n";
				   } else {
					   foreach $elem4 ( sort { $a cmp $b } keys %{$newhash{$elem1}{$orcat}{$elem3}}) {
						   ($orsent, $cleansent) = split /\|/, $elem4;
						   if ($cleansent ne "") {
							   print KEYOUT "\t\t", ChopChar($orsent), " ---CORR---> $cleansent\n";
							   print KEYOUTFLAT "+$cleansent#", ChopChar($orsent);
						   } else {
							   print KEYOUT "\t\t", ChopChar($orsent), "\n";
							   print KEYOUTFLAT "+", ChopChar($orsent);
						   }

						   print KEYOUT "\n";
					   }
				   }
			   }

			   print KEYOUT "\n";
		   }

		   print KEYOUT "\n";
	   }

	   close(KEYOUT);
	   close(KEYOUTFLAT);
   } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts"."$type_suffix"."$language_suffix";
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts_flat"."$type_suffix"."$language_suffix";
   }
}

sub MakeCatList1
{
    my($general_args, $meaning_args, $wordnet_args, $cleaning_args, $gen_grammar_elem_hash, $allow_general_hash, $changed_utt_repeat_hash, $disallow_general_hash, $do_addmainrules_only, $do_tagsdirect, $do_include_garbagereject, $gsl_filler_hash, $init_cat_file, $line_hash, $orig_2_line_hash, $filename_2_line_hash, $real_corpus, $rule_multiplier, $utt_source, $vocabfile, $wordlist_already_hash) = @_;

	my($build_string) = "";
	my($cat_compare_result_found) = 0;
	my($cat_count);
	my($cat_count_text);
	my($cat_external_count);
	my($cat_external_count_text);
	my($cat_general_count);
	my($cat_general_count_text);
	my($elem);
	my($elem1);
	my($elem2);
	my($elem3);
	my($elem_change);
	my($filler_count);
	my($filler_text);
	my($filtered_result_sentence);
	my($first_part);
	my($gsl_filler_build_string) = "";
	my($gsl_filler_counter) = 0;
	my($gsl_filler_result_sentence);
	my($init_cat_found) = 1;
	my($item_category);
	my($keyword_build_string);
	my($line);
	my($prev_cat);
	my($raw_instance_label);
	my($raw_instance_num);
	my($raw_orig_line);
	my($raw_string);
	my($rawword);
	my($rawword_cat);
	my($repeat_num);
	my($response_exclusion_tag_string);
	my($rest_string);
	my($result_sentence);
	my($rule_is_external);
	my($rule_is_general);
	my($save_line);
	my($second_part);
	my($temp_elem);
	my($temp_result_sentence);
	my($test_part);
	my($test_rest);
	my($wordbag_keyword_build_string);
	my(%cat_compare_result_hash);
	my(%cat_dupe_hash);
	my(%cat_result_hash);
	my(%cat_sent_hash);
	my(%cat_temp_result_hash);
	my(%external_hash);
	my(%external_sentence_hash);
	my(%general_conflict_compare_hash);
	my(%general_conflict_hash);
	my(%general_sentence_conflict_hash);
	my(%general_sentence_hash);
	my(%keyword_2_orig_hash);
	my(%keyword_cat_sentence_hash);
	my(%keyword_hash);
	my(%keyword_single_hash);
	my(%line_2_keyword_hash);
	my(%orig_touched_hash);
	my(%result_sentence_used_hash);
	my(%rawword_hash);
	my(%rawword_single_hash);
	my(%rule_parts_hash);
	my(%rule_parts_retry_hash);
	my(%rule_parts_used_hash);
	my(%wordbag_keyword_2_orig_hash);
	my(%wordbag_keyword_cat_sentence_hash);
	my(%wordbag_keyword_hash);
	my(%wordbag_line_2_keyword_hash);
	my(@cat_sentence_array) = ();
	my(@rest);
	my(@temp_word_array);

	DebugPrint ("BOTH", 0, "MakeCatList1", $debug, $err_no++, "Creating Rules Container");

	$filler_text = "filler";
	if ($$general_args{"language_suffix"} ne "") {
		$filler_text = $filler_text."_".$$general_args{"language_suffix"};
	}

	if ($init_cat_file ne "") {
		unless (open(CATLIST,"<$init_cat_file")) {
			DebugPrint ("BOTH", 2, "MakeCatList1", $debug, $err_no++, "Can\'t open the file: $init_cat_file"."!");
			$init_cat_found = 0;
		}

		if ($init_cat_found) {
			open(CATOUT,">"."slmdirect_results\/createslm_init_rules_container".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslm_init_rules_container".$$general_args{"language_suffix"};

			$response_exclusion_tag_string = "";
			if ($$cleaning_args{"response_exclusion_tags"} ne "") {

			  DebugPrint ("BOTH", 0.1, "MakeCatList1", $debug, $err_no++, "Actively removing TAG Response Exclusion lines ...");
				  $response_exclusion_tag_string = $$cleaning_args{"response_exclusion_tags"};
				  $response_exclusion_tag_string =~ s/\|/ /g;
				  $response_exclusion_tag_string = " ".$response_exclusion_tag_string." ";
			}

			$prev_cat = "";
			foreach $line ( sort { $a cmp $b } keys %{$line_hash}) {
			  $save_line = 0;
				($item_category, @cat_sentence_array) = split "\t", $line;
				$item_category = NormCat($item_category, $$general_args{"test_reject_name"});

				if ($item_category ne $prev_cat) {
					$cat_general_count = 1;
					$cat_external_count = 1;
				}

#				if ((!$do_filtercorpus_direct) && ($do_tagsdirect)) {
				if ($do_tagsdirect) {
				  MakeMCLGrammar ($general_args, $meaning_args, $response_exclusion_tag_string, $wordnet_args, $gen_grammar_elem_hash, $do_include_garbagereject, $changed_utt_repeat_hash, $$line_hash{$line}, $item_category, \@cat_sentence_array, $utt_source, $gsl_filler_hash, $rule_multiplier, $allow_general_hash, $disallow_general_hash, $do_addmainrules_only);
				}

				foreach $elem (@cat_sentence_array) {
					$elem = TrimChars($elem);
					$rule_is_external = 0;
					$rule_is_general = 0;
					$result_sentence = $elem;
					$gsl_filler_result_sentence = "";
					if (($elem ne "") && (lc($elem) !~ /\*blank\*/)) {
						if ((scalar keys %{$$meaning_args{"pre"}{"filler"}} > 0) || (scalar keys %{$$meaning_args{"pre"}{"filler_esus"}} > 0)) {
							$keyword_build_string = "";
							($build_string, $filler_count, $gsl_filler_build_string, $gsl_filler_counter) = FillBuildStrings ($meaning_args, $wordnet_args, $elem);

							if ($build_string ne "") {
								$keyword_build_string = TrimChars($build_string);
								$keyword_build_string =~ s/_FILLER5_\(\)\)/\)/g;
								$keyword_build_string =~ s/\(//g;
								$keyword_build_string =~ s/\)//g;
								if ($keyword_build_string ne "") {
									$keyword_build_string = TrimChars($keyword_build_string);

									$raw_string = "(".$keyword_build_string.")";
									$raw_string =~ s/_FILLER5_/\)\(.*?\)\(/g;

									$wordbag_keyword_build_string = $keyword_build_string;
									if ((index($keyword_build_string, " ") != -1) || (index($keyword_build_string, "_FILLER5_") != -1)) {
										$keyword_build_string =~ s/_FILLER5_/_/g;
										$wordbag_keyword_build_string = $keyword_build_string;
										$wordbag_keyword_build_string =~ s/___/ /g;
										$keyword_build_string =~ s/ /_/g;
										$keyword_hash{$item_category}{$keyword_build_string}++;
										for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
										  $rawword_hash{$item_category}{$raw_string}{$elem}++;
										}
									} else {
									  $keyword_single_hash{$item_category}{$keyword_build_string}++;
									  for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
										$rawword_single_hash{$item_category}{$raw_string}{$elem}++;
									  }
									}

									$keyword_cat_sentence_hash{$keyword_build_string}{$item_category}{$elem}++;
									$line_2_keyword_hash{$keyword_build_string}{$elem}{$line}++;

									$wordbag_keyword_build_string = TrimChars($wordbag_keyword_build_string);
									$wordbag_keyword_build_string = GenWordList($$general_args{"main_language"}, $wordbag_keyword_build_string, $wordlist_already_hash);
									$wordbag_keyword_hash{$item_category}{$wordbag_keyword_build_string}++;
									$wordbag_keyword_cat_sentence_hash{$wordbag_keyword_build_string}{$item_category}{$elem}++;
									$wordbag_line_2_keyword_hash{$wordbag_keyword_build_string}{$elem}{$line}++;
									$keyword_build_string = "";
									$wordbag_keyword_build_string = "";
								} else {
								  for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
									$rawword_hash{$item_category}{"KEYWORD_NULL"}{$elem}++;
								  }
								}

								$rule_is_external = 0;
								$rule_is_general = 0;
								if ($build_string !~ /_FILLER5_/) {
									$build_string =~ s/\(\(//g;
									$build_string =~ s/\)\)//g;

									$gsl_filler_build_string =~ s/\(\(//g;
									$gsl_filler_build_string =~ s/\)\)//g;

									if (index($build_string, " ") == -1) {
										$rule_is_general = 1;
									}
								}

								if ($item_category =~ /\+/) {
									$rule_is_external = 1;
									$rule_is_general = 0;
								}
							} else {
							  for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
								$rawword_hash{$item_category}{"BUILDSTRING_NULL"}{$elem}++;
							  }
							}

							if ($do_addmainrules_only) {
								if ($rule_is_general) {
									if (not defined $$allow_general_hash{$build_string}) {
										$$disallow_general_hash{$build_string}++;
										$build_string = "";
									}
								}
							}

							$result_sentence = "";
							if ($build_string ne "") {
								$result_sentence = $build_string;
								$gsl_filler_result_sentence = $gsl_filler_build_string;

								if ($filler_count == 1) {
									if ($result_sentence =~ /\(\(((\w| |\')+)\)_FILLER5_\(((\w| |\')+)\)\)/) {
										$first_part = $1;
										$second_part = $3;
										$rule_parts_hash{$item_category}{$first_part}{$second_part}++;
									}
								}
							}

						} else {
						  for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
							$rawword_hash{$item_category}{"MEANING_NULL"}{$elem}++;
						  }
						}
					} else {
					  for ($repeat_num = 0; $repeat_num < $$line_hash{$line}; $repeat_num++) {
						$rawword_hash{$item_category}{"SENTENCE_NULL"}{$elem}++;
					  }
					}

#print "herezzz0a2: line=$line\n";
					if ($result_sentence ne "") {
						$filtered_result_sentence = $result_sentence;
						$filtered_result_sentence =~ s/\ª//g;

						if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
							if (($gsl_filler_result_sentence ne "") && ($gsl_filler_counter <= 3)) {
								$$gsl_filler_hash{$item_category}{$gsl_filler_result_sentence}++;
							}
						}

						if (((scalar @cat_sentence_array) > 1) || ($real_corpus)) {
							if ($rule_is_general) {
							  $filtered_result_sentence = ApplyAliases($general_args, $meaning_args, $filtered_result_sentence);
								if (((not defined $$meaning_args{"pre"}{$filler_text}{$filtered_result_sentence}) && (lc($item_category) ne lc($$general_args{"test_reject_name"}))) || ((defined $$meaning_args{"pre"}{$filler_text}{$filtered_result_sentence}) && (lc($item_category) eq lc($$general_args{"test_reject_name"})))) {
								  $cat_general_count_text = $cat_general_count;
								  if (length($cat_general_count_text) == 1) {
									$cat_general_count_text = "00".$cat_general_count_text;
								  } elsif (length($cat_general_count_text) == 2) {
									$cat_general_count_text = "0".$cat_general_count_text;
								  }

								  $general_conflict_hash{$filtered_result_sentence}{$item_category}++;
								  if ((scalar keys %{$general_conflict_hash{$filtered_result_sentence}} > 1)) {
									foreach $temp_elem ( sort { $a cmp $b } keys %{$general_conflict_hash{$filtered_result_sentence}}) {
									  $general_conflict_compare_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"." <<<<< CONFLICT"}{$temp_elem}++;
									}

#									$general_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"." <<<<< CONFLICT"}++;
#									$general_sentence_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"." <<<<< CONFLICT"} = "\# $elem";
									$general_sentence_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"." <<<<< CONFLICT"}{"\# $elem"}++;
								  } else {
#									$general_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"}++;
#									$general_sentence_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"} = "\# $elem";
									$general_sentence_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"}{"\# $elem"}++;
								  }

								  $cat_general_count++;
								}
							} elsif ($rule_is_external) {
								$cat_external_count_text = $cat_external_count;
								if (length($cat_external_count_text) == 1) {
									$cat_external_count_text = "00".$cat_external_count_text;
								} elsif (length($cat_external_count_text) == 2) {
									$cat_external_count_text = "0".$cat_external_count_text;
								}

								$external_hash{$item_category."_slmp_external_".$cat_external_count_text.",".$item_category.":$filtered_result_sentence"}++;
								$external_sentence_hash{$item_category."_slmp_external_".$cat_external_count_text.",".$item_category.":$filtered_result_sentence"} = "\# $elem";

								$cat_external_count++;
							} else {
							    $save_line = 1;
#								$cat_sent_hash{$item_category}{$elem}++;
								$first_part = "";
								if ($filtered_result_sentence !~ /_FILLER5_/) {
									if (index($filtered_result_sentence, " ") != -1) {
										(@temp_word_array) = split " ", $filtered_result_sentence;
										$rest_string = "";
										while (scalar(@temp_word_array) > 0) {
											$test_rest = pop @temp_word_array;
											$test_part = "";
											if ((scalar (@temp_word_array)) > 0) {
											  $test_part = join " ", @temp_word_array;
											}

											if ($test_part ne "") {
											  $rest_string = stringBuilder($rest_string, $test_rest, " ");

												if (scalar keys %{$rule_parts_hash{$item_category}{$test_part}} > 0) {
													$first_part = $test_part;
													$rule_parts_hash{$item_category}{$first_part}{$rest_string}++;

													last;
												} else {
													$rule_parts_retry_hash{$filtered_result_sentence}{"$item_category:$test_part:$rest_string"}++;
												}
											}
										}
									}
								}

								if ($first_part eq "") {
									$cat_temp_result_hash{$item_category}{$filtered_result_sentence}++;
								}
							}
						} else {
							if ($rule_is_general) {
								if (((not defined $$meaning_args{"pre"}{$filler_text}{$filtered_result_sentence}) && (lc($item_category) ne lc($$general_args{"test_reject_name"}))) || ((defined $$meaning_args{"pre"}{$filler_text}{$filtered_result_sentence}) && (lc($item_category) eq lc($$general_args{"test_reject_name"})))) {
#									$general_hash{$item_category."_slmp_general,".$item_category.":$filtered_result_sentence"}++;
#									$general_sentence_hash{$item_category."_slmp_general_".$cat_general_count_text.",".$item_category.":$filtered_result_sentence"}++;
									$general_sentence_hash{$item_category."_slmp_general,".$item_category.":$filtered_result_sentence"}{"\# $elem"}++;
								}
							} elsif ($rule_is_external) {
								$external_hash{$item_category."_slmp_external,".$item_category.":$filtered_result_sentence"}++;
								$external_sentence_hash{$item_category."_slmp_external_".$cat_external_count_text.",".$item_category.":$filtered_result_sentence"}++;
							} else {
								if (not defined $cat_dupe_hash{$item_category}{"$filtered_result_sentence"}) {
									$cat_dupe_hash{$item_category}{"$filtered_result_sentence"}++;
									$save_line = 1;
#									$cat_sent_hash{$item_category}{$elem}++;

									$temp_elem = $item_category;
									$temp_elem =~ s/ /_/g;

									$cat_result_hash{$item_category}{"$temp_elem:$filtered_result_sentence"}++;
									$cat_compare_result_hash{"$filtered_result_sentence"}{$item_category}{$elem}++;
								}
							}
						}
					}
				}

#print "herezzz0a3: line=$line\n";
				$prev_cat = $item_category;
			    if (!$save_line) {
				  delete $$line_hash{$line};
				}

				@cat_sentence_array = ();
#print "herezzz0b\n";
			}

#print "herezzz1a\n";
			if ($$general_args{"create_regexp"}) {
			    if (scalar (keys %rawword_hash) > 0) {
				open(RAWOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/createslm_raw_rules".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/createslm_raw_rules".$$general_args{"language_suffix"};

				foreach $rawword_cat ( sort { $a cmp $b } keys %rawword_hash) {
				    foreach $rawword ( sort { $a cmp $b } keys %{$rawword_hash{$rawword_cat}}) {
					foreach $raw_orig_line ( sort { $a cmp $b } keys %{$rawword_hash{$rawword_cat}{$rawword}}) {
#				      for ($repeat_num = 0; $repeat_num < $rawword_hash{$rawword_cat}{$rawword}{$raw_orig_line}; $repeat_num++) {
					    foreach $raw_instance_num ( sort { $a cmp $b } keys %{$$filename_2_line_hash{$raw_orig_line}}) {
						$raw_instance_label = $$filename_2_line_hash{$raw_orig_line}{$raw_instance_num};
						print RAWOUT $raw_instance_label."\t$raw_orig_line\t$rawword_cat\t$rawword\n";
					    }
					}
				    }
				}
			    }

			    if (scalar (keys %rawword_single_hash) > 0) {
				foreach $rawword_cat ( sort { $a cmp $b } keys %rawword_single_hash) {
				    foreach $rawword ( sort { $a cmp $b } keys %{$rawword_single_hash{$rawword_cat}}) {
					foreach $raw_orig_line ( sort { $a cmp $b } keys %{$rawword_single_hash{$rawword_cat}{$rawword}}) {
#					for ($repeat_num = 0; $repeat_num < $rawword_single_hash{$rawword_cat}{$rawword}{$raw_orig_line}; $repeat_num++) {
					    foreach $raw_instance_num ( sort { $a cmp $b } keys %{$$filename_2_line_hash{$raw_orig_line}}) {
						$raw_instance_label = $$filename_2_line_hash{$raw_orig_line}{$raw_instance_num};
						print RAWOUT $raw_instance_label."\t$raw_orig_line\t$rawword_cat\t$rawword\n";
#					  print RAWOUT $$filename_2_line_hash{$raw_orig_line}."\t$raw_orig_line\t$rawword_cat\t$rawword\n";
					    }
					}
				    }
				}
			    }

			    close (RAWOUT);
			}

			DebugPrint ("BOTH", 0, "MakeCatList1", $debug, $err_no++, "Checking Keyword Conflicts");
			CheckKeywordHashes("", $$general_args{"language_suffix"}, \%keyword_hash, \%keyword_single_hash, \%keyword_cat_sentence_hash, \%line_2_keyword_hash, $orig_2_line_hash, $filename_2_line_hash, \%keyword_2_orig_hash, \%orig_touched_hash);

			CheckKeywordHashes("_wordbag", $$general_args{"language_suffix"}, \%wordbag_keyword_hash, "", \%wordbag_keyword_cat_sentence_hash, \%wordbag_line_2_keyword_hash, $orig_2_line_hash, $filename_2_line_hash, \%wordbag_keyword_2_orig_hash, \%orig_touched_hash);

			undef %keyword_hash;
			undef %keyword_cat_sentence_hash;
			undef %line_2_keyword_hash;
			undef %{$orig_2_line_hash};
			undef %{$filename_2_line_hash};
			undef %orig_touched_hash;

			undef %wordbag_keyword_hash;
			undef %wordbag_keyword_cat_sentence_hash;
			undef %wordbag_line_2_keyword_hash;
#print "herezzz1b\n";

			foreach $result_sentence ( sort { $a cmp $b } keys %rule_parts_retry_hash) {
				$first_part = "";
				foreach $elem1 ( sort { $a cmp $b } keys %{$rule_parts_retry_hash{$result_sentence}}) {
					($item_category,$test_part,$rest_string) = split ":", $elem1;
					if (scalar keys %{$rule_parts_hash{$item_category}{$test_part}} > 0) {
						$first_part = $test_part;
						$rule_parts_hash{$item_category}{$first_part}{$rest_string}++;
					}
				}

				if ($first_part eq "") {
					$cat_temp_result_hash{$item_category}{$result_sentence}++;
				}

                delete $rule_parts_retry_hash{$result_sentence};
			}

#print "herezzz2a\n";
			foreach $item_category ( sort { $a cmp $b } keys %cat_temp_result_hash) {
				$cat_count = 1;
				foreach $elem2 ( sort { $a cmp $b } keys %{ $cat_temp_result_hash{$item_category} }) {
					$first_part = "";
					if ($elem2 =~ /\(\(((\w| |\')+)\)_FILLER5_\(((\w| |\')+)\)\)/) {
						$first_part = $1;
						$second_part = $3;

						if (not defined $rule_parts_hash{$item_category}{$first_part}{$second_part}) {
							$first_part = "";
						}
					}

					if ($first_part ne "") {
						if (not defined $rule_parts_used_hash{$item_category}{$first_part}) {
							$rule_parts_used_hash{$item_category}{$first_part}++;
							$result_sentence = "";
							foreach $elem3 ( sort { length($b) <=> length($a) } keys %{ $rule_parts_hash{$item_category}{$first_part} }) {
								if ($result_sentence eq "") {
									$result_sentence = "(($first_part)_FILLER5_(($elem3)";
								} else {
									$result_sentence = $result_sentence."|($elem3)";
								}

								$cat_compare_result_hash{"$first_part:$elem3"}{$item_category}{"$elem2"}++;
								$filtered_result_sentence = "$first_part:$elem3";
							}

							$result_sentence = $result_sentence."))";
						} else {
							next;
						}
					} else {
						$result_sentence = $elem2;
						$cat_compare_result_hash{"$elem2"}{$item_category}{"$elem2"}++;
						if (not defined $result_sentence_used_hash{$item_category}{$result_sentence}) {
							$result_sentence_used_hash{$item_category}{$result_sentence}++;
						} else {
							next;
						}
					}

					$cat_count_text = $cat_count;
					if (length($cat_count_text) == 1) {
						$cat_count_text = "00".$cat_count_text;
					} elsif (length($cat_count_text) == 2) {
						$cat_count_text = "0".$cat_count_text;
					}

					$temp_result_sentence = $result_sentence;

					$result_sentence = ApplyAliases($general_args, $meaning_args, $result_sentence);

					if (not defined $cat_dupe_hash{$item_category}{"$result_sentence"}) {
						$cat_dupe_hash{$item_category}{"$result_sentence"}++;

						if ($result_sentence ne $temp_result_sentence) {
							$cat_compare_result_hash{"$result_sentence"}{$item_category}{"$elem2"}++;
						}

						$temp_elem = $item_category;
						$temp_elem =~ s/ /_/g;

						$cat_result_hash{$item_category}{"$temp_elem"."_".$cat_count_text.",$item_category:$result_sentence"}++;

						$cat_count++;
					}

					delete $cat_temp_result_hash{$item_category}{$elem2};
				}

                delete $cat_temp_result_hash{$item_category};
			}

#print "herezzz2b\n";
			print CATOUT "\# Rule Container Format:\n";
			print CATOUT "\#\tCategory_Name[,Category_Confirm_As,Category_Title_Out,Category_Negation]:Rule_Definition_Line\n";
			print CATOUT "\#\t\t(If Category_Name contains \'slmp_external\', then Rule will be External (ER)).\n\n";
			print CATOUT "\#\t\t(If Category_Name contains \'slmp_general\', then Rule will be General (GR)).\n\n";

			foreach $line ( sort { $a cmp $b } keys %{$line_hash}) {
			  ($item_category, @cat_sentence_array) = split "\t", $line;
			  $item_category = NormCat($item_category, $$general_args{"test_reject_name"});

			  foreach $elem (@cat_sentence_array) {
				$elem = TrimChars($elem);
				if (($elem ne "") && (lc($elem) !~ /\*blank\*/)) {
				  $cat_sent_hash{$item_category}{$elem}++;
				}
			  }

			  delete $$line_hash{$line};
			}

			foreach $elem1 ( sort { $a cmp $b } keys %cat_sent_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$cat_sent_hash{$elem1}}) {
					print CATOUT "\#", "$elem2\n";
				}

				foreach $elem2 ( sort { $a cmp $b } keys %{$cat_result_hash{$elem1}}) {
#print "herezzz0a: elem2=$elem2\n";
			  $elem2 =~ s/\,\_/_/g;
			  $elem2 =~ s/\,\ /_/g;
			  $elem2 =~ s/\&/-/g;
#print "herezzz0b: elem2=$elem2\n";
					print CATOUT "$elem2\n";
				}

				print CATOUT "\n";
			}

			print CATOUT "\n";

#			if (scalar (keys %general_hash) > 0) {
			if (scalar (keys %general_sentence_hash) > 0) {
				print CATOUT "\n";
				print CATOUT "\#General Rules\n";
				print CATOUT "\#-------------\n\n";

			}

			$elem2 = "";
#			foreach $elem1 ( sort { $a cmp $b } keys %general_hash) {
			foreach $elem1 ( sort { $a cmp $b } keys %general_sentence_hash) {
				$elem_change = $elem2;

				if ($elem1 =~ /\<\<\<\<\< CONFLICT/) {
					$general_sentence_conflict_hash{$elem1}++;

					next;
				}

				($elem2, @rest) = split "_", $elem1;
				if ($elem_change ne "") {
					if ($elem_change ne $elem2) {
					  foreach $elem3 ( sort { $a cmp $b } keys %{$general_sentence_hash{$elem1}}) {
#						print CATOUT "\n".$general_sentence_hash{$elem1}."\n";
						print CATOUT "\n".$elem3."\n";
						print CATOUT "$elem1\n";
					  }
					} else {
					  foreach $elem3 ( sort { $a cmp $b } keys %{$general_sentence_hash{$elem1}}) {
#						print CATOUT $general_sentence_hash{$elem1}."\n";
						print CATOUT $elem3."\n";
						print CATOUT "$elem1\n";
					  }
					}
				} else {
				  foreach $elem3 ( sort { $a cmp $b } keys %{$general_sentence_hash{$elem1}}) {
#					print CATOUT $general_sentence_hash{$elem1}."\n";
					print CATOUT $elem3."\n";
					print CATOUT "$elem1\n";
				  }
				}
			}

			close(CATLIST);
			close(CATOUT);

			$cat_compare_result_found = 0;
			open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts".$$general_args{"language_suffix"}) or die "cant write "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts".$$general_args{"language_suffix"};
			foreach $elem ( sort { $a cmp $b } keys %cat_compare_result_hash) {
				if (scalar keys %{$cat_compare_result_hash{$elem}} > 1) {
					$cat_compare_result_found = 1;
					print KEYOUT "$elem:\n";
					foreach $elem1 ( sort { $a cmp $b } keys %{$cat_compare_result_hash{$elem}}) {
						print KEYOUT "\t$elem1\n";
						foreach $elem2 ( sort { $a cmp $b } keys %{$cat_compare_result_hash{$elem}{$elem1}}) {
							print KEYOUT "\t\t$elem2\n";
						}
					}

					print KEYOUT "\n";
				}
			}

			close(KEYOUT);

			if (scalar (keys %keyword_2_orig_hash) > 0) {
				DebugPrint ("BOTH", 2, "MakeCatList1", $debug, $err_no++, "CATEGORY CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts".$$general_args{"language_suffix"});

				$hard_error = 1;
			}

			if ($cat_compare_result_found) {
				DebugPrint ("BOTH", 2, "MakeCatList1", $debug, $err_no++, "CATEGORY/FILLER CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts".$$general_args{"language_suffix"});

				$hard_error = 1;
			} else {
				unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts".$$general_args{"language_suffix"};
			}

			if (scalar (keys %general_sentence_conflict_hash) > 0) {
				open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_general_category_conflicts".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_general_category_conflicts".$$general_args{"language_suffix"};

				foreach $elem1 ( sort { $a cmp $b } keys %general_sentence_conflict_hash) {
				  foreach $elem2 ( sort { $a cmp $b } keys %{$general_sentence_hash{$elem1}}) {
					print KEYOUT "\n$elem2\n";
					print KEYOUT "$elem1\n";
				  }

				  foreach $elem2 ( sort { $a cmp $b } keys %{$general_conflict_compare_hash{$elem1}}) {
					print KEYOUT ">>>CAT: $elem2\n";
				  }
				}

				close(KEYOUT);

				DebugPrint ("BOTH", 2, "MakeCatList1", $debug, $err_no++, "GENERAL_CATEGORY CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_general_category_conflicts".$$general_args{"language_suffix"});
			} else {
				unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_general_category_conflicts".$$general_args{"language_suffix"};
			}

			if (scalar (keys %wordbag_keyword_2_orig_hash) > 0) {
				DebugPrint ("BOTH", 2, "MakeCatList1", $debug, $err_no++, "WORDBAG CATEGORY CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts_wordbag".$$general_args{"language_suffix"});
			}

			DebugPrint ("BOTH", 1, "MakeCatList1", $debug, $err_no++, "File created: "."slmdirect_results\/createslm_init_rules_container".$$general_args{"language_suffix"});
			DebugPrint ("BOTH", 1, "MakeCatList1", $debug, $err_no++, "File created: "."slmdirect_results\/createslm_init_sentences".$$general_args{"language_suffix"});
		}
	}

	WriteVocabs ($general_args, $cleaning_args, $meaning_args, $vocabfile);
}

sub MakeCatList2
{
    my($general_args, $cleaning_args, $meaning_args, $cat_nl_rules_fileout, $cat_template_name, $container_file_in, $do_filtercorpus_direct, $do_tagsdirect, $do_make_nlrule_init_test, $dont_do_additional_command_vars, $vocabfile, $do_put_defaults) = @_;

	my($alias_name);
	my($alias_rules_out);
	my($cat_company_name)= "default_company_name";
	my($cat_confirm_as);
	my($cat_neg);
	my($cat_nl_rules_lineout);
	my($cat_plus_conf);
	my($cat_title) = "";
	my($elem);
	my($elem1);
	my($elem2);
	my($firstchar);
	my($item_category);
	my($line);
	my($nl_out_confirm_phrase);
	my($nl_out_rule_type);
	my($nl_out_rule_type_external);
	my($nl_out_rule_type_general);
	my($nl_out_test_name);
	my($sent_count);
	my($temp);
	my($temp1);
	my($temp_elem);
	my($template_found) = 1;
	my(%alias_hash);
	my(%nl_out_external_rules);
	my(%nl_out_general_rules);
	my(%nl_out_rules);
	my(%nl_out_tests);
	my(%nl_temp_test_name_only);
	my(%nl_temp_tests);
	my(%senterror_hash);
	my(%temp_compare_hash);
	my(%temp_sentence_hash);
	my(%temp_word_only_hash);
	my(@cat_neg_array);
	my(@sentcat_contents1_array);
	my(@sentcat_contents2_array);
	my(@temp_word_array);
	my(@template_contents);

	if (index($container_file_in, ":") != -1) {
		($container_file_in, $cat_company_name) = split ":", $container_file_in;
	}

	DebugPrint ("BOTH", 0, "MakeCatList2", $debug, $err_no++, "Creating Rules File from ".NormalizeFilename($container_file_in));

	unless (open(TEMPLATE,"<$cat_template_name")) {
		$template_found = 0;
	}

	if ($template_found) {
		(@template_contents) = (<TEMPLATE>);
	}

	open(CATLIST,"<$container_file_in") or die "cant open $container_file_in";

	open(NLRULESOUT,">$cat_nl_rules_fileout") or die "cant write $cat_nl_rules_fileout";

	if ($do_put_defaults) {
	  print NLRULESOUT "LO,background noise:background voices:bad-audio:breath:breath_noise:breath_noisne:clicks:cough:dtmf:expletive:garble:garbled:garbeld:hang-up:hang_up:mobile-phone:no speech:no-speech:other:pause:side_speech:speech-in-noise:system self-barge-in:system-self-barge-in:tones:transcription-error:within-car-noise:noise:non-native:bad-audio:ah:b:c:d:er:e:g:hm:h:ip:l:n:px:p:q:r:um:w:x:z\nCO,\\?:\\(:\\):\\*:,\nDC,~:-:umm:um:uh:ahhh:ahh:ah:er:eh:mm:errr:ab:ac:acc:ag:ano:auth:b:bala:c:ca:ch:co:cr:cu:d:de:di:dis:e:em:es:ex:f:g:h:i':j:k:l:li:n:o:op:p:paym:prog:r:recei:s:se:ser:sig:so:t:ta:w:x:y\n\n";
	}

	open(COMPARERULESOUT,">"."slmdirect_results\/createslmDIR_info_files\/compare_first_words_in_rules") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/compare_first_words_in_rules";

	$nl_out_rule_type = "MR";
	$nl_out_rule_type_general = "GR";
	$nl_out_rule_type_external = "ER";

	while(<CATLIST>) {
	  $line = $_;
	  ($line, $firstchar) = ProcessCharsPlus($line);

	  if ($line eq "") {
		next;
	  }

	  if (substr($line,0,1) eq "#") {
		next;
	  }

	  if (substr($line,0,1) eq "^") {
		($alias_name, $alias_rules_out) = split ":", $line;
		if ($$general_args{"downcase_utt"}) {
		  $alias_name = lc($alias_name);
		  $alias_rules_out = lc($alias_rules_out);
		}

		$alias_name =~ s/\^//g;
		$alias_rules_out =~ s/\, /\|/g;
		$alias_rules_out =~ s/\,/\|/g;
		$alias_hash{$alias_name} = $alias_rules_out;
	  } else {
#AccountChanges_ChangeOwner_001,AccountChanges.ChangeOwner:((ACTION_Transfer|ACTION_Change|ACTION_Update)_FILLER5_(NOUN_Owner|DG_Phone))
		($cat_plus_conf, $cat_nl_rules_lineout) = split ":", $line;
		if ($$general_args{"downcase_utt"}) {
		  $cat_nl_rules_lineout = lc($cat_nl_rules_lineout);
		}

		$cat_neg = "";

		if (lc($cat_plus_conf) =~ /slmp_external/) {
		  $nl_out_test_name = "test_external_$cat_plus_conf";

		  $nl_temp_tests{"$nl_out_test_name"}{"$cat_nl_rules_lineout"}++;
		  $nl_temp_test_name_only{"$nl_out_test_name"}++;

		  $nl_out_external_rules{"$nl_out_rule_type_external,\$".$nl_out_test_name.",,...external..."}++;
		} else {
		  ($item_category, $cat_confirm_as, $cat_title, $cat_neg) = split ",", $cat_plus_conf;
		  if (lc($item_category) eq "discard") {
			next;
		  }

		  $item_category = NormCat($item_category, $$general_args{"test_reject_name"});
		  $cat_confirm_as = NormCat($cat_confirm_as, $$general_args{"test_reject_name"});
		  $cat_title = NormCat($cat_title, $$general_args{"test_reject_name"});

		  if ($cat_title eq "") {
			$cat_title = $cat_confirm_as;
		  }

		  if ($cat_title eq "") {
			$cat_title = $item_category;
		  }

		  if ($cat_neg ne "") {
			@cat_neg_array = split "=", lc($cat_neg);

			$cat_neg = "";
			foreach $elem (@cat_neg_array) {
			  if ($cat_neg eq "") {
				$cat_neg = "\$test_".$elem;
			  } else {
				$cat_neg = $cat_neg."="."\$test_".$elem;
			  }
			}
		  }

		  $temp1 = $cat_nl_rules_lineout;
		  $temp1 =~ s/_(\d*)filler(\d*)_/ /g;

		  $temp1 =~ s/[\!\$\%\^\&\*\(\)\[\]\{\}\-\+\=\;\:\@\#\~\\\|\,\<\.\>\/\?]/ /g;
#			$temp1 =~ s/[!\$\%\^\&\*\-\+\=\;\:\@\#\~\\\|\,\<\.\>\/\?]/ /g;

		  $temp1 = TrimChars($temp1);
		  $temp_sentence_hash{$temp1}{$cat_title}++;
		  (@temp_word_array) = split " ", $temp1;

		  foreach $elem (@temp_word_array) {
			$temp_word_only_hash{$elem}++;
		  }

		  $cat_nl_rules_lineout =~ s/\, /\|/g;
		  $cat_nl_rules_lineout =~ s/\,/\|/g;

		  $nl_out_test_name = "test_$item_category";

		  $nl_out_confirm_phrase = "$cat_title";

		  if (($cat_confirm_as ne "") && ($cat_confirm_as ne $cat_title)) {
			$nl_out_test_name = "test_$item_category"."_"."$cat_confirm_as";
			$nl_out_confirm_phrase = "$cat_title:$cat_confirm_as";
		  }

		  if ($$general_args{"downcase_utt"}) {
			$nl_out_test_name = lc($nl_out_test_name);
		  }

		  $cat_nl_rules_lineout =~ s/\^/\$/g;

		  $nl_out_test_name =~ s/ /_/g;

		  $nl_temp_tests{"$nl_out_test_name"}{"$cat_nl_rules_lineout"}++;
		  $nl_temp_test_name_only{"$nl_out_test_name"}++;

		  if (lc($nl_out_test_name) =~ /slmp_general/) {
			if ($cat_neg eq "") {
			  $nl_out_general_rules{"$nl_out_rule_type_general,\$".$nl_out_test_name.",,$nl_out_confirm_phrase"}++;
			} else {
			  $nl_out_general_rules{"$nl_out_rule_type_general,\$".$nl_out_test_name.",$cat_neg,$nl_out_confirm_phrase"}++;
			}
		  } else {
			if ($cat_neg eq "") {
			  $nl_out_rules{"$nl_out_rule_type,\$".$nl_out_test_name.",,$nl_out_confirm_phrase"}++;
			} else {
			  $nl_out_rules{"$nl_out_rule_type,\$".$nl_out_test_name.",$cat_neg,$nl_out_confirm_phrase"}++;
			}
		  }
		}
	  }
	}

	foreach $elem ( sort { $a cmp $b } keys %nl_temp_test_name_only) {
	  $cat_nl_rules_lineout = "";
	  foreach $elem1 ( sort { $a cmp $b } keys %{ $nl_temp_tests{$elem} }) {
		$cat_nl_rules_lineout = stringBuilder($cat_nl_rules_lineout, $elem1, "|");
	  }

	  $cat_nl_rules_lineout =~ s/_(\d*)filler(\d*)_/_$1FILLER$2_/g;

	  $nl_out_tests{"^,$elem,($cat_nl_rules_lineout)"}++;
	}

	if ($template_found) {
	  $line = shift @template_contents;
	  while($line !~ /INSERT GENERATED ALIASES HERE/) {
		($line, $firstchar) = ProcessCharsPlus($line);
		$line =~ s/\<company name\>/$cat_company_name/g;
		print NLRULESOUT "$line\n";
		$line = shift @template_contents;
	  }
	}

	foreach $elem ( sort { $a cmp $b } keys %alias_hash) {
	  $temp = $alias_hash{$elem};
	  print NLRULESOUT "\$,$elem,\($temp\)\n";
	}

	if ($template_found) {
	  $line = shift @template_contents;
	  while($line !~ /INSERT GENERATED SYMBOLIC VARIABLES HERE/) {
		($line, $firstchar) = ProcessCharsPlus($line);
		$line =~ s/\<company name\>/$cat_company_name/g;
		print NLRULESOUT "$line\n";
		$line = shift @template_contents;
	  }
	}

	foreach $elem ( sort { $a cmp $b } keys %nl_out_tests) {
	  $elem =~ s/ \<\<\<\<\< conflict//g;
	  print NLRULESOUT "$elem\n";
	}

	if ($template_found) {
	  $line = shift @template_contents;
	  while($line !~ /INSERT UNAMBIGUOUS PARSING RULES HERE/) {
		($line, $firstchar) = ProcessCharsPlus($line);
		$line =~ s/\<company name\>/$cat_company_name/g;
		print NLRULESOUT "$line\n";
		$line = shift @template_contents;
	  }
	}

	foreach $elem ( sort { $a cmp $b } keys %nl_out_rules) {
	  print NLRULESOUT "$elem\n";
	}

	if ($template_found) {
	  $line = shift @template_contents;
	  while($line !~ /INSERT GENERAL PARSING RULES HERE/) {
		($line, $firstchar) = ProcessCharsPlus($line);
		$line =~ s/\<company name\>/$cat_company_name/g;
		print NLRULESOUT "$line\n";
		$line = shift @template_contents;
	  }
	}

	if (scalar (keys %nl_out_general_rules) > 0) {
	  open(NLRULESOUT_GENERAL,">"."slmdirect_results\/createslmDIR_info_files\/info_general_ruleset") or die "cant write NLRULESOUT_GENERAL";

	  foreach $elem ( sort { $a cmp $b } keys %nl_out_general_rules) {
		print NLRULESOUT "$elem\n";
		print NLRULESOUT_GENERAL "$elem\n";
	  }

	  close(NLRULESOUT_GENERAL);
	}

	if (scalar (keys %nl_out_external_rules) > 0) {
	  open(NLRULESOUT_EXTERNAL,">"."slmdirect_results\/createslmDIR_info_files\/info_external_ruleset") or die "cant write NLRULESOUT_EXTERNAL";

	  print NLRULESOUT "\#\n";

	  foreach $elem ( sort { $a cmp $b } keys %nl_out_external_rules) {
		print NLRULESOUT "$elem\n";
		print NLRULESOUT_EXTERNAL "$elem\n";
	  }

	  close(NLRULESOUT_EXTERNAL);
	}

	if ($template_found) {
	  foreach $elem (@template_contents) {
		($elem, $firstchar) = ProcessCharsPlus($elem);
		$elem =~ s/\<company name\>/$cat_company_name/g;
		print NLRULESOUT "$elem\n";
	  }
	}

	close(NLRULESOUT);

	foreach $elem ( sort { $a cmp $b } keys %temp_sentence_hash) {
	  foreach $elem1 ( sort { $a cmp $b } keys %{ $temp_sentence_hash{$elem} }) {
		(@temp_word_array) = split " ", $elem;
		$temp_compare_hash{$temp_word_array[0]}{$elem1}{$elem}++;
	  }
	}

	foreach $elem ( sort { $a cmp $b } keys %temp_compare_hash) {
	  if (scalar(keys %{ $temp_compare_hash{$elem}}) > 1) {
		foreach $elem1 ( sort { $a cmp $b } keys %{ $temp_compare_hash{$elem} }) {
		  foreach $elem2 ( sort { $a cmp $b } keys %{ $temp_compare_hash{$elem}{$elem1} }) {
			print COMPARERULESOUT "$elem2: $elem1\n";
		  }
		}

		print COMPARERULESOUT "\n";
	  }
	}

	close (COMPARERULESOUT);

	DebugPrint ("BOTH", 1, "MakeCatList2", $debug, $err_no++, "File created: ".NormalizeFilename($cat_nl_rules_fileout));

# ATTENTION3 ???????????????????????????????????????? What to do here ????????????????????????????
	if ((!$dont_do_additional_command_vars && !$do_tagsdirect) && (($do_make_nlrule_init_test) || $do_filtercorpus_direct)) {
	  my($errors_found) = 0;
	  my($sentence1);
	  my($sentence2);
	  my($item_category1);
	  my($item_category2);
	  my($original_template_found) = 1;
	  my($original_sentences) = "info_init_sentence_category_assignment".$$general_args{"language_suffix"};
	  my($target_sentences) = "info_target_sentences";

	  unless (open(SENTCATIN1,"<"."slmdirect_results\/createslmDIR_temp_files\/$original_sentences")) {
		$original_template_found = 0;
	  }

	  if (!$original_template_found) {
		DebugPrint ("BOTH", 2, "MakeCatList2", $debug, $err_no++, "Can\'t find "."slmdirect_results\/createslmDIR_temp_files\/$original_sentences.  Can\'t assess RULE INCONSISTENCIES.");
	  } else {
		(@sentcat_contents1_array) = (<SENTCATIN1>);
		close(SENTCATIN1);

		open(INFOTEMPSENT,">"."slmdirect_results\/createslmDIR_temp_files\/$target_sentences") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/$target_sentences";
		foreach $elem (@sentcat_contents1_array) {
		  ($sentence1, $item_category1) = split "\t", $elem;

		  print INFOTEMPSENT "$sentence1\n";
		}

		close(INFOTEMPSENT);

		CALL_SLMDirect(0, 0, $vanilla_callingProg, $$general_args{"main_language"}, "", "", $$general_args{"grammar_type"}, "", "createslm_init_nlrules", "temp1234", $$general_args{"downcase_utt"}, $$cleaning_args{"removerepeats"}, "\""."slmdirect_results\/createslmDIR_temp_files\/$target_sentences\"", "", ".", 0, "", 0, "", "");

		open(SENTCATIN2,"<temp1234_category_only") or die "cant open temp1234_category_only";
		(@sentcat_contents2_array) = (<SENTCATIN2>);
		close(SENTCATIN2);

		$sent_count = 0;
		foreach $elem (@sentcat_contents1_array) {
		  ($sentence1, $item_category1) = split "\t", $elem;
		  $elem1 = $sentcat_contents2_array[$sent_count];
		  ($sentence2, $item_category2) = split "\t", $elem1;
		  $item_category1 = ChopChar($item_category1);
		  $item_category2 = ChopChar($item_category2);
		  if (lc($item_category1) ne lc($item_category2)) {
			$errors_found = 1;
			if ($item_category2 eq "") {
			  $temp_elem = "$item_category1\t*UNK*\t$sentence1";
			  if ($sentence1 ne $sentence2) {
				$temp_elem = "$item_category1\t*UNK*\t$sentence1 ($sentence2)";
			  }
			} else {
			  $temp_elem = "$item_category1\t$item_category2\t$sentence1";
			  if ($sentence1 ne $sentence2) {
				$temp_elem = "$item_category1\t$item_category2\t$sentence1 ($sentence2)";
			  }
			}

			$senterror_hash{$item_category1}{$temp_elem}++;
		  }

		  $sent_count++;
		}

		if ((scalar keys %senterror_hash) > 0 ) {
		  open(SENTERROR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts";

		  print SENTERROR "Col1: Hand-Assigned\tCol2: Rule-Assigned\tCol3: Sentence(s)\n\n";
		  foreach $elem ( sort { $a cmp $b } keys %senterror_hash) {
			foreach $elem1 ( sort { $a cmp $b } keys %{$senterror_hash{$elem}}) {
			  print SENTERROR "$elem1\n";
			}

			print SENTERROR "\n\n";
		  }

		  close(SENTERROR);
		} else {
		  unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts";
		}

		unlink "temp1234";
		unlink "temp1234_category_only";

		if ($errors_found) {
		  DebugPrint ("BOTH", 2, "MakeCatList2", $debug, $err_no++, "RULE INCONSISTENCIES: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_rule_conflicts");
		}
	  }
	}

	WriteVocabs ($general_args, $cleaning_args, $meaning_args, $vocabfile);
}

sub WriteNewCatsFile
{
   my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $mode, $newcatsfile_in, $newcatsfile, $debug, $err_no, $compressed_already_hash, $wordlist_already_hash) = @_;

   my($compressed_alias_sentence);
   my($compressed_sentence);
   my($corrected_sentence);
   my($elem);
   my($elem1);
   my($interim_corrected_sentence);
   my($item_category);
   my($newcats_conflicts_found) = 0;
   my($newcats_wordbag_conflicts_found) = 0;
   my($orig_sentence);
   my($pseudo_corrected_sentence);
   my($sent_totally_squeezed);
   my($sentence_order);
   my($squeezed_utt);
   my($string_mode);
   my($temp_removerepeats);
   my($wordbag_compressed_alias_sentence);
   my($wordbag_compressed_sentence);
   my(%catline_hash);
   my(%newcats_hash);
   my(%newcats_sent2origcat_hash);
   my(%wordbag_newcats_hash);
   my(%wordbag_newcats_sent2origcat_hash);
   my(@cat_order_array);
   my(@original_transcription_array);
   my(@pre_search_array);
   my(@pseudo_search_array);
   my(@vanilla_cat_array);
   my(@write_array);

   $string_mode = lc($mode);
   $string_mode =~ s/ /_/g;

	if ($$general_args{"main_language"} eq "es-us") {
		$newcatsfile = $newcatsfile."_esus";
	}

   if (lc($newcatsfile_in) eq "remove") {
	   unlink $newcatsfile;

	   DebugPrint ("BOTH", 2, "WriteNewCatsFile_1", $debug, $err_no++, "$mode FILE: $newcatsfile removed");
   } else {
	 DebugPrint ("BOTH", 0.1, "WriteNewCatsFile_1", $debug, $err_no++, "Checking $mode FILE: $newcatsfile_in ...");

	 $temp_removerepeats = $$cleaning_args{"removerepeats"};
	 $$cleaning_args{"removerepeats"} = 0;
	 FillSearchString($general_args, $cleaning_args, $mode, 0, $newcatsfile_in, \@original_transcription_array, \@cat_order_array, \@vanilla_cat_array, \@write_array, \@pre_search_array, \@pseudo_search_array);
	 $$cleaning_args{"removerepeats"} = $temp_removerepeats;

	 open(NEWCATSOUT,">$newcatsfile") or die "cant write $newcatsfile";

	 $sentence_order = 0;
	 foreach $interim_corrected_sentence (@pre_search_array) {
	   $orig_sentence = $original_transcription_array[$sentence_order];
	   $item_category = $cat_order_array[$sentence_order];

	   $corrected_sentence = $interim_corrected_sentence;

	   if ($$cleaning_args{"removerepeats"}) {
		 $corrected_sentence = RemoveRepeats($corrected_sentence);
#		 $pseudo_corrected_sentence = RemoveRepeats($pseudo_corrected_sentence);
	   }

	   $pseudo_corrected_sentence = $corrected_sentence;

	   if (not defined $catline_hash{$item_category}{$corrected_sentence}) {
		 ($sent_totally_squeezed, $corrected_sentence, $squeezed_utt) = SqueezeSentence($meaning_args, $wordnet_args, $corrected_sentence);

		 $compressed_sentence = chooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $corrected_sentence, $compressed_already_hash);

		 if ($compressed_sentence eq "___twm___") {
		   $compressed_alias_sentence = $compressed_sentence;
		   $wordbag_compressed_sentence = $compressed_sentence;
		   $wordbag_compressed_alias_sentence = $compressed_sentence;
		   $item_category = $$general_args{"test_reject_name"};
		   #				   print NEWCATSOUT "$item_category\t$orig_sentence\t$corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$compressed_sentence\t$newcatsfile_in\n";
		 } else {
		   $compressed_alias_sentence = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_sentence, $compressed_already_hash);
		   $wordbag_compressed_sentence = GenWordList($$general_args{"main_language"}, $compressed_sentence, $wordlist_already_hash);
		   $wordbag_compressed_alias_sentence = GenWordList($$general_args{"main_language"}, $compressed_alias_sentence, $wordlist_already_hash);

		   #				   $wordbag_newcats_hash{$wordbag_compressed_sentence}{uc($item_category)}++;
		   $wordbag_newcats_hash{$wordbag_compressed_sentence}{$item_category}++;
		   $wordbag_newcats_sent2origcat_hash{$wordbag_compressed_sentence}{"$orig_sentence:$item_category"}++;

		   if ($compressed_alias_sentence ne $compressed_sentence) {
			 if ($wordbag_compressed_alias_sentence ne $wordbag_compressed_sentence) {
			   #						   $wordbag_newcats_hash{$wordbag_compressed_alias_sentence}{uc($item_category)}++;
			   $wordbag_newcats_hash{$wordbag_compressed_alias_sentence}{$item_category}++;
			   $wordbag_newcats_sent2origcat_hash{$wordbag_compressed_alias_sentence}{"$orig_sentence:$item_category"}++;
			 }
		   }
		 }

		 $catline_hash{$item_category}{$corrected_sentence}++;

		 if (lc($mode) =~ /reclass/) {
		   print NEWCATSOUT "$item_category\t$orig_sentence\t$corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$wordbag_compressed_sentence\t$wordbag_compressed_alias_sentence\t$squeezed_utt\t$newcatsfile_in\n";
		 } elsif (lc($mode) =~ /known/) {
		   print NEWCATSOUT "$item_category\t$orig_sentence\t$corrected_sentence\t$pseudo_corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$wordbag_compressed_sentence\t$wordbag_compressed_alias_sentence\t$squeezed_utt\t$newcatsfile_in\n";
		 }

		 #			   $newcats_hash{$compressed_sentence}{uc($item_category)}++;
		 $newcats_hash{$compressed_sentence}{$item_category}++;
		 $newcats_sent2origcat_hash{$compressed_sentence}{"$orig_sentence:$item_category"}++;
		 if ($compressed_sentence ne $compressed_alias_sentence) {
		   if ($compressed_alias_sentence ne "") {
			 #					   $newcats_hash{$compressed_alias_sentence}{uc($item_category)}++;
			 $newcats_hash{$compressed_alias_sentence}{$item_category}++;
			 $newcats_sent2origcat_hash{$compressed_alias_sentence}{"$orig_sentence:$item_category"}++;
		   }
		 }
	   }

	   $sentence_order++;
	 }

	 @pre_search_array = ();

	 close(NEWCATSOUT);

	 open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts") or die "cant write "."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts";
	 foreach $elem ( sort { $a cmp $b } keys %newcats_hash) {
	   if (scalar (keys %{$newcats_hash{$elem}}) > 1) {
		 $newcats_conflicts_found = 1;
		 print KEYOUT "$elem\t";
		 foreach $elem1 ( sort { $a cmp $b } keys %{$newcats_hash{$elem}}) {
		   print KEYOUT "($elem1) ";
		 }

		 print KEYOUT "\n\n\t";

		 foreach $elem1 ( sort { $a cmp $b } keys %{$newcats_sent2origcat_hash{$elem}}) {
		   print KEYOUT "($elem1) ";
		 }

		 print KEYOUT "\n\n";
	   }
	 }

	 close(KEYOUT);

	 if ($newcats_conflicts_found) {
	   DebugPrint ("BOTH", 2, "WriteNewCatsFile_2", $debug, $err_no++, "$mode FILE CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts");
	 } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts";
	 }

	 open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts_wordbag") or die "cant write "."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts_wordbag";
	 foreach $elem ( sort { $a cmp $b } keys %wordbag_newcats_hash) {
	   if (scalar (keys %{$wordbag_newcats_hash{$elem}}) > 1) {
		 $newcats_wordbag_conflicts_found = 1;
		 print KEYOUT "$elem\t";
		 foreach $elem1 ( sort { $a cmp $b } keys %{$wordbag_newcats_hash{$elem}}) {
		   print KEYOUT "($elem1) ";
		 }

		 print KEYOUT "\n\n\t";

		 foreach $elem1 ( sort { $a cmp $b } keys %{$wordbag_newcats_sent2origcat_hash{$elem}}) {
		   print KEYOUT "($elem1) ";
		 }

		 print KEYOUT "\n\n";
	   }
	 }

	 close(KEYOUT);

	 if ($newcats_wordbag_conflicts_found) {
	   DebugPrint ("BOTH", 2, "WriteNewCatsFile_3", $debug, $err_no++, "WORDBAG $mode FILE CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts_wordbag");
	 } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_".$string_mode."_conflicts_wordbag";
	 }
   }
}

sub WriteOutNewKnownCats
{
   my($general_args, $knowncatsfile, $do_filtercorpus_direct, $original_transcription_array, $original_cat_array, $reclass_hash, $keyword_2_filtered_utt_hash, $wordbag_keyword_2_filtered_utt_hash, $sentence_cat_hash, $corrected_array, $compressed_sentence_array, $compressed_alias_sentence_array, $wordbag_compressed_sentence_array, $wordbag_compressed_alias_sentence_array, $truth_knowncats_hash, $inputfilename) = @_;

   my($cmd);
   my($compressed_alias_sentence);
   my($compressed_sentence);
   my($corrected_sentence);
   my($elem);
   my($elem1);
   my($elem2);
   my($item_category);
   my($original_trans);
   my($pseudo_corrected_sentence);
   my($reclass_cat);
   my($sentence_order) = 0;
   my($temp_test_reject_name) = lc($$general_args{"test_reject_name"});
   my($wordbag_compressed_alias_sentence);
   my($wordbag_compressed_sentence);
   my(%garb_rej_with_keywords_hash);
   my(@reclass_keys);

   if (scalar (@$corrected_array) > 0) {
	 open(KNOWNOUT,">$knowncatsfile".$$general_args{"language_suffix"}."_temp") or die "cant write $knowncatsfile".$$general_args{"language_suffix"}."_temp";
   }

   foreach $corrected_sentence (@$corrected_array) {
	   $original_trans = @$original_transcription_array[$sentence_order];
	   $pseudo_corrected_sentence = $corrected_sentence;
	   $item_category = @$original_cat_array[$sentence_order];
	   $compressed_sentence = @$compressed_sentence_array[$sentence_order];
	   $compressed_alias_sentence = @$compressed_alias_sentence_array[$sentence_order];
	   $wordbag_compressed_sentence = @$wordbag_compressed_sentence_array[$sentence_order];
	   $wordbag_compressed_alias_sentence = @$wordbag_compressed_alias_sentence_array[$sentence_order];

	   if ((lc($corrected_sentence) =~ /\*blank\*/) || (lc($corrected_sentence) =~ /\*response exclusion\*/) || (lc($corrected_sentence) =~ /ramble exclusion/)) {
		   $item_category = $$general_args{"test_reject_name"};
		   if (lc $corrected_sentence =~ /response exclusion/) {
			   $item_category = "RESPONSE_EXCLUSION";
		   } elsif (lc $corrected_sentence =~ /ramble exclusion/) {
			   $item_category = "RAMBLE_EXCLUSION";
		   }

		   @$original_cat_array[$sentence_order] = $item_category;

		   print KNOWNOUT "$item_category\t$corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$wordbag_compressed_sentence\t$wordbag_compressed_alias_sentence\t\t$inputfilename\n";
	   } else {
		   if (scalar keys %{$$reclass_hash{$corrected_sentence}} > 0) {
			   @reclass_keys = sort { $a cmp $b } keys %{$$reclass_hash{$corrected_sentence}};
			   $reclass_cat = NormCat($reclass_keys[0], $$general_args{"test_reject_name"});
			   if (lc($reclass_cat) ne lc($item_category)) {
				   $item_category = $reclass_cat;
			   }
		   } elsif ($compressed_sentence ne "") {
			   if (scalar keys %{$$reclass_hash{$compressed_sentence}} > 0) {
				   @reclass_keys = sort { $a cmp $b } keys %{$$reclass_hash{$compressed_sentence}};
				   $reclass_cat = NormCat($reclass_keys[0], $$general_args{"test_reject_name"});
				   if (lc($reclass_cat) ne lc($item_category)) {
					   $item_category = $reclass_cat;
				   }
			   }
		   }

		   if (($item_category ne "DISCARD") && ($item_category ne "RAMBLE_EXCLUSION")) {
			   $$truth_knowncats_hash{$item_category}{$original_trans}{$pseudo_corrected_sentence}{$corrected_sentence}++;
		   }

		   if (($compressed_sentence eq "") || ($compressed_sentence eq "___twm___")) {
			   $compressed_sentence = "___twm___";
			   $compressed_alias_sentence = $compressed_sentence;
			   $wordbag_compressed_sentence = $compressed_sentence;
			   $wordbag_compressed_alias_sentence = $compressed_sentence;
			   $item_category = $$general_args{"test_reject_name"};

			   @$original_cat_array[$sentence_order] = $item_category;
			   @$compressed_sentence_array[$sentence_order] = $compressed_sentence;
			   @$compressed_alias_sentence_array[$sentence_order] = $compressed_alias_sentence;
			   @$wordbag_compressed_sentence_array[$sentence_order] = $wordbag_compressed_sentence;
			   @$wordbag_compressed_alias_sentence_array[$sentence_order] = $wordbag_compressed_alias_sentence;

			   if ($corrected_sentence ne "") {
				   $compressed_sentence = $corrected_sentence;
				   $compressed_alias_sentence = $compressed_sentence;
				   $wordbag_compressed_sentence = $compressed_sentence;
				   $wordbag_compressed_alias_sentence = $compressed_sentence;

				   print KNOWNOUT "$item_category\t$original_trans\t$corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$wordbag_compressed_sentence\t$wordbag_compressed_alias_sentence\t\t$inputfilename\n";
			   }
		   } else {
			 if (($compressed_sentence eq "ç") || ($compressed_sentence eq "Ç")) {
			   $compressed_sentence = $corrected_sentence;
			 }
			   if (lc($item_category) eq $temp_test_reject_name) {
				   $garb_rej_with_keywords_hash{$inputfilename}{$corrected_sentence}{$compressed_sentence}++;
			   } else {
				   if ($compressed_sentence eq $corrected_sentence) {
					   $$general_args{"just_keywords"}{$corrected_sentence}++;
				   }
			   }

			   if ($do_filtercorpus_direct) {
				   $$keyword_2_filtered_utt_hash{$compressed_sentence}{$item_category}{"$corrected_sentence:$inputfilename"}++;
				   $$wordbag_keyword_2_filtered_utt_hash{$wordbag_compressed_sentence}{$item_category}{"$corrected_sentence:$inputfilename"}++;
			   }

			   print KNOWNOUT "$item_category\t$original_trans\t$corrected_sentence\t$compressed_sentence\t$compressed_alias_sentence\t$wordbag_compressed_sentence\t$wordbag_compressed_alias_sentence\t\t$inputfilename\n";
		   }

		   $$sentence_cat_hash{$corrected_sentence} = $item_category;
	   }

	   $sentence_order++;
   }

   close(KNOWNOUT);

   if (scalar (@$corrected_array) > 0) {
	 $knowncatsfile =~ s/\\/\//g;
	 $cmd = "sort -u $knowncatsfile".$$general_args{"language_suffix"}."_temp>"."$knowncatsfile".$$general_args{"language_suffix"};
	 system($cmd."\n");
   }

   if ((scalar keys %garb_rej_with_keywords_hash) > 0) {
	   open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_garbage_reject_keywords") or die "cant write "."slmdirect_results\/createslmDIR_analyze_files\/analyze_garbage_reject_keywords";
	   foreach $elem ( sort { $a cmp $b} keys %garb_rej_with_keywords_hash) {
		   print KEYOUT "FILE: $elem:\n";
		   foreach $elem1 ( sort { $a cmp $b } keys %{$garb_rej_with_keywords_hash{$elem}}) {
			   print KEYOUT "\t$elem1\n";
			   foreach $elem2 ( sort { $a cmp $b } keys %{$garb_rej_with_keywords_hash{$elem}{$elem1}}) {
				   print KEYOUT "\t\t$elem2\n";
			   }

			   print KEYOUT "\n";
		   }

		   print KEYOUT "\n";
	   }

	   close(KEYOUT);

	   DebugPrint ("BOTH", 2, "Main::READ_CATLIST", $debug, $err_no++, "GARBAGE_REJECTS With KEYWORDS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_garbage_reject_keywords");
   } else {
	   unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_garbage_reject_keywords";
   }
}

sub GetKnownCatsInfo
{
    my($general_args, $findReference_args, $debug, $err_no, $knowncatsfile, $reclass_hash, $truth_knowncats_hash, $sentence_cat_hash) = @_;

	my($item_category);
	my($compressed_alias_sentence);
	my($compressed_sentence);
	my($corrected_sentence);
	my($line);
	my($orig_sentence);
	my($reclass_cat);
	my($pseudo_corrected_sentence);
	my($source_file);
	my($squeezed_utt);
	my($wordbag_compressed_alias_sentence);
	my($wordbag_compressed_sentence);

	my(@focus_item_id_array);
	my(@reclass_keys);

	if ($$general_args{"main_language"} eq "es-us") {
		$knowncatsfile = $knowncatsfile."_esus";
	}

	if (-e "$knowncatsfile") {
		open(KNOWNCATS,"<$knowncatsfile") or die "cant open $knowncatsfile";
		while(<KNOWNCATS>) {
			$line = ChopChar($_);
			if (substr($line,0,1) eq "#") {
				next;
			}

			($item_category, $orig_sentence, $corrected_sentence, $pseudo_corrected_sentence, $compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_sentence, $wordbag_compressed_alias_sentence, $squeezed_utt, $source_file) = split "\t", $line;

			if ($compressed_sentence eq "Ç") {
			  $compressed_sentence = $corrected_sentence;
			}

			if ($wordbag_compressed_sentence eq "Ç") {
			  $wordbag_compressed_sentence = $compressed_sentence;
			}

			if ($compressed_alias_sentence eq "Ç") {
			  $compressed_alias_sentence = $compressed_sentence;
			}

			if ($wordbag_compressed_alias_sentence eq "Ç") {
			  $wordbag_compressed_alias_sentence = $compressed_alias_sentence;
			} elsif ($wordbag_compressed_alias_sentence eq "ç") {
			  $wordbag_compressed_alias_sentence = $wordbag_compressed_sentence;
			}

			$$sentence_cat_hash{$corrected_sentence} = $item_category;

			$$findReference_args{"FindReference_KWN"}{$compressed_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";

			$focus_item_id_array[0] = $squeezed_utt;
			$$findReference_args{"FindReference_focus_KWN"}{$compressed_sentence} = [ @focus_item_id_array ];

			if ($compressed_sentence ne "___twm___") {
				if (scalar keys %{$$reclass_hash{$corrected_sentence}} > 0) {
					@reclass_keys = sort { $a cmp $b } keys %{$$reclass_hash{$corrected_sentence}};
					$reclass_cat = NormCat($reclass_keys[0], $$general_args{"test_reject_name"});
					if (lc($reclass_cat) ne lc($item_category)) {
						$item_category = $reclass_cat;
					}
				} elsif ($compressed_sentence ne "") {
					if (scalar keys %{$$reclass_hash{$compressed_sentence}} > 0) {
						@reclass_keys = sort { $a cmp $b } keys %{$$reclass_hash{$compressed_sentence}};
						$reclass_cat = NormCat($reclass_keys[0], $$general_args{"test_reject_name"});
						if (lc($reclass_cat) ne lc($item_category)) {
							$item_category = $reclass_cat;
						}
					}
				}

				$$truth_knowncats_hash{$item_category}{$orig_sentence}{$pseudo_corrected_sentence}{$corrected_sentence}++;
				if ($compressed_alias_sentence ne $compressed_sentence) {
					$$findReference_args{"FindReference_KWN"}{$compressed_alias_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
					$$findReference_args{"FindReference_focus_KWN"}{$compressed_alias_sentence} = [ @focus_item_id_array ];
				}

				$$findReference_args{"FindReference_KWN_wordbag"}{$wordbag_compressed_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
				$$findReference_args{"FindReference_focus_KWN_wordbag"}{$wordbag_compressed_sentence} = [ @focus_item_id_array ];

				if ($wordbag_compressed_alias_sentence ne $wordbag_compressed_sentence) {
					$$findReference_args{"FindReference_KWN_wordbag"}{$wordbag_compressed_alias_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
					$$findReference_args{"FindReference_focus_KWN_wordbag"}{$wordbag_compressed_alias_sentence} = [ @focus_item_id_array ];
				}
			}

			@focus_item_id_array = ();
		}

		DebugPrint ("BOTH", 1, "Main::KNOWNCATS", $debug, $err_no++, "File loaded: ".NormalizeFilename($knowncatsfile));
	} else {
		DebugPrint ("BOTH", 2, "Main::KNOWNCATS", $debug, $err_no++, "Known Classifications File: ".NormalizeFilename($knowncatsfile)." NOT Found");
	}

	DebugPrint ("BOTH", -1, "Main::RECLASS", $debug, $err_no++, "\n");
}

sub GetReclassInfo
{
    my($general_args, $findReference_args, $debug, $err_no, $reclassfile, $reclassification_file, $reclass_hash) = @_;

	my($item_category);
	my($compressed_alias_sentence);
	my($compressed_sentence);
	my($corrected_sentence);
	my($line);
	my($orig_sentence);
	my($source_file);
	my($squeezed_utt);
	my($wordbag_compressed_alias_sentence);
	my($wordbag_compressed_sentence);

	my(@focus_item_id_array);

	if ($$general_args{"main_language"} eq "es-us") {
		if ($reclassification_file ne "") {
			$reclassification_file = $reclassification_file."_esus";
		}
	}

	if (-e "$reclassification_file") {
		open(RECLASS,"<$reclassification_file") or die "cant open $reclassification_file";
		while(<RECLASS>) {
			$line = ChopChar($_);
			if (substr($line,0,1) eq "#") {
				next;
			}

			($item_category, $orig_sentence, $corrected_sentence, $compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_sentence, $wordbag_compressed_alias_sentence, $squeezed_utt, $source_file) = split "\t", $line;

			$$findReference_args{"FindReference_MR_reclassifications"}{$compressed_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";

			$focus_item_id_array[0] = $squeezed_utt;
			$$findReference_args{"FindReference_focus_MR_reclassifications"}{$compressed_sentence} = [ @focus_item_id_array ];

			if ($compressed_sentence ne "___twm___") {
				$$reclass_hash{$compressed_sentence}{$item_category}++;
				if ($compressed_alias_sentence ne $compressed_sentence) {
#					$$reclass_hash{$compressed_alias_sentence}{uc($item_category)}++;
					$$reclass_hash{$compressed_alias_sentence}{$item_category}++;
					$$findReference_args{"FindReference_MR_reclassifications"}{$compressed_alias_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
					$$findReference_args{"FindReference_focus_MR_reclassifications"}{$compressed_alias_sentence} = [ @focus_item_id_array ];
				}


				$$findReference_args{"FindReference_MR_wordbag_reclassifications"}{$wordbag_compressed_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
				$$findReference_args{"FindReference_focus_MR_wordbag_reclassifications"}{$wordbag_compressed_sentence} = [ @focus_item_id_array ];

				if ($wordbag_compressed_alias_sentence ne $wordbag_compressed_sentence) {
					$$findReference_args{"FindReference_MR_wordbag_reclassifications"}{$wordbag_compressed_alias_sentence} = $compressed_sentence.":".$item_category.":".$corrected_sentence.":".$item_category.":"."1".":"."".":"."".":"."1".":"."1";
					$$findReference_args{"FindReference_focus_MR_wordbag_reclassifications"}{$wordbag_compressed_alias_sentence} = [ @focus_item_id_array ];
				}
			}

			@focus_item_id_array = ();
		}

		DebugPrint ("BOTH", 1, "Main::RECLASS", $debug, $err_no++, "File loaded: ".NormalizeFilename($reclassification_file));
	} else {
		DebugPrint ("BOTH", 2, "Main::RECLASS", $debug, $err_no++, "Reclassification File: ".NormalizeFilename($reclassfile)." NOT Found");
	}

	DebugPrint ("BOTH", -1, "Main::RECLASS", $debug, $err_no++, "\n");
}

sub WriteAssignmentFile
{
    my($main_language, $sentence_cat_hash) = @_;

	my($elem);
	my($elem1);

	if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
		open(SENTCATOUT,">"."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment";
	} elsif ($main_language eq "es-us") {
		open(SENTCATOUT,">"."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment_esus") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment_esus";
	}

	foreach $elem ( sort { $a cmp $b } keys %{$sentence_cat_hash}) {
		$elem1 = $$sentence_cat_hash{$elem};
		print SENTCATOUT "$elem\t$elem1\n";
	}

	close(SENTCATOUT);
}

sub GetMeaning_new {

    my($myhash, $lineHshRef, $general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $compressed_already_hash) = @_;

	my($assignment_source);
	my($changed_utt);
	my($compressed_utt);
	my($do_classify) = 0;
	my($do_testparsefile) = 0;
	my($do_testsentence) = 0;
	my($elem);
	my($expand_vanilla);
	my($formatted_string);
	my($i);
	my($j);
	my($item_category);
	my($item_id);
	my($main_search_string);
	my($make_failparse) = 0;
	my($nl_blank_utts);
	my($nl_not_handled);
	my($nl_total_records);
	my($original_utt);
	my($sent_begin);
	my($sent_end);
	my($sentence_order) = 0;
	my($use_reclassifications) = 0;
	my($utt);
	my($wavfilename);
	my(%check_expand_hash);
	my(%classify_truth_hash);
	my(%rule_sentence_hash);
	my(@compressed_sentence_array);
	my(@focus_item_id_array);
	my(@original_transcription_array);
	my(@original_wavfile_array);
	my(@sentence_corpus_array);

	undef %$lineHshRef;
	$expand_vanilla = 1;
	$main_search_string = "";
	foreach $elem ( sort { $$myhash{$b} <=> $$myhash{$a} } keys %{$myhash}) {
		$original_utt = $elem;

		$utt = ChopChar(TrimChars($elem));

		if (($utt eq "") || ($utt eq " ") || lc($utt) =~ /\*blank\*/) {
			($main_search_string, $sent_begin, $sent_end) = storeLocationInfoOrdered("___", $main_search_string, $sentence_order);

#				$sentence_corpus_limits_array[$sentence_order] = "___:$sent_begin:$sent_end";
			$sentence_corpus_array[$sentence_order] = "*Blank*:$original_utt";
			$original_transcription_array[$sentence_order] = $original_utt;
			$sentence_order++;

			next;
		}

		$changed_utt = $utt;

		$sentence_corpus_array[$sentence_order] = $changed_utt;
		$original_transcription_array[$sentence_order] = $original_utt;

		$compressed_utt = "";
		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			if (not defined $$meaning_args{"pre_string"}) {
				$compressed_utt = $changed_utt;
			} else {
				$compressed_utt = CheckSkipPhrase("loc8", $meaning_args, $wordnet_args, $changed_utt);
			}
		} elsif ($$general_args{"main_language"} eq "es-us") {
			if (not defined $$meaning_args{"pre_string_esus"}) {
				$compressed_utt = $changed_utt;
			} else {
				$compressed_utt = CheckSkipPhrase("loc9", $meaning_args, $wordnet_args, $changed_utt);
			}
		}

		if ($compressed_utt eq "") {
			$compressed_utt = "___twm___";
		}

		($main_search_string, $sent_begin, $sent_end) = storeLocationInfoOrdered($compressed_utt, $main_search_string, $sentence_order);

#		$sentence_corpus_limits_array[$sentence_order] = "$compressed_utt:$sent_begin:$sent_end";
		$compressed_sentence_array[$sentence_order] = $compressed_utt;

		$sentence_order++;
	}

	ApplyParsingRules($general_args, $meaning_args, $findReference_args, "getmeaning", "", $sentence_order, $main_search_string, \@sentence_corpus_array, \@compressed_sentence_array, $compressed_already_hash);

	$j = 0;
	for ($i = 0; $i < $sentence_order; $i++) {
		($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled) = DetermineSourceAssignment($general_args, $meaning_args, $wordnet_args, $findReference_args, $i, $j, "", "", "", "", $expand_vanilla, \@sentence_corpus_array, \@original_wavfile_array, $make_failparse, $do_classify, $do_testparsefile, $do_testsentence, $nl_total_records, $nl_blank_utts, $nl_not_handled, $use_reclassifications, \@compressed_sentence_array, \@original_transcription_array, \%classify_truth_hash, \%rule_sentence_hash, \@focus_item_id_array, \%check_expand_hash, "", 0, "", "");

		$original_utt = $sentence_corpus_array[$i];
		if ($item_category ne "") {
			$focus_item_id_array[0] = $changed_utt;
			$formatted_string = Write_Output_Format($general_args, $cleaning_args, "to_string", $assignment_source, $changed_utt, "", "", 0, "", \@focus_item_id_array, 0, $item_category, "<".$$meaning_args{"slotname"}." \"%s\">\t<".$$meaning_args{"confirm_as"}." \"%s\">\n", "<ambig_key \"%s\">\t<".$$meaning_args{"confirm_as"}." \"%s\">\n", "<tag>".$$meaning_args{"slotname_nuance_speakfreely"}."=\'%s\'</tag><tag>".$$meaning_args{"confirm_as_nuance_speakfreely"}."=\'%s\'</tag><tag>category=\'%s\'</tag>\n", "<tag>ambig_key=\'%s\'</tag><tag>".$$meaning_args{"confirm_as_nuance_speakfreely"}."=\'%s\'</tag><tag>category=\'%s\'</tag>\n", 0);
			$$lineHshRef{$original_utt} = $formatted_string;
		} else {
			$$lineHshRef{$original_utt} = "UNKNOWN";
		}
	}
}

############# END Category Processing SUBROUTINES ####################

######################################################################
######################################################################
############# String Processing SUBROUTINES ##########################
######################################################################
######################################################################

sub createSearchString
{
    my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $use_original_wavfiles, $do_testsentence, $pre_search_string, $corrected_array, $original_transcription_array, $original_wavfile_array, $compressed_sentence_array, $compressed_alias_sentence_array, $original_cat_array, $synfile_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash, $compressed_already_hash) = @_;

	my($compressed_alias_sentence);
	my($compressed_sentence);
	my($corrected_sentence);
	my($firstchar);
	my($keyword_weight) = 4000000;
	my($main_search_string);
	my($original_utt);
	my($pos_corrected_sentence);
	my($sent_begin);
	my($sent_end);
	my($sentence_length);
	my($sentence_order);
	my($synonym_corrected_sentence);
	my($synonym_sentence_order);
	my($synonym_sentence_order_start);
	my($temp_corrected_sentence);
	my($temp_removerepeats);
	my($temp_sentence_order);
	my($test_category) = "APPLY_CLASS_GRAMMARS_TO_ALL_CATEGORIES";
	my(%default_pos_hash);
	my(%pos_only_hash);
	my(%seen_hash);
	my(%wordnet_hash);
	my(%wordnet_pointer_hash);
	my(@pos_corrected_array);
	my(@synonym_corrected_array);

	$original_utt = $pre_search_string;
	$original_utt =~ s/\º//g;

	$temp_removerepeats = $$cleaning_args{"removerepeats"};
	$$cleaning_args{"removerepeats"} = 0;
	$corrected_sentence = MakeCleanTrans($general_args, $cleaning_args, 0, 0, 1, 0, $test_category, $pre_search_string);
	$$cleaning_args{"removerepeats"} = $temp_removerepeats;

	$corrected_sentence = MoreClean($corrected_sentence);
	@$corrected_array = split /\º/, $corrected_sentence;

#	   print "herexxxfinalarray1999: exit: corrected_sentence=$corrected_sentence\n";
	if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
		FillWordNetHash($general_args, $meaning_args, $wordnet_args, $keyword_weight, $corrected_sentence, \%wordnet_pointer_hash, \%wordnet_hash, \%pos_only_hash, \%default_pos_hash, \%seen_hash, 0);
	}

	$synonym_sentence_order_start = scalar(@$corrected_array);
	$synonym_sentence_order = -1;
	if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
	    $pos_corrected_sentence = FindPreWordsInSentence($corrected_sentence, $meaning_args, $wordnet_args);
#	   print "herexxxfinalarray18888: pos_corrected_sentence=$pos_corrected_sentence\n";
	    @pos_corrected_array = split /\º/, $pos_corrected_sentence;

		undef $pos_corrected_sentence;

		$sentence_order = 0;
		$temp_sentence_order = 0;
		$synonym_sentence_order = $synonym_sentence_order_start;
		foreach $synonym_corrected_sentence (@$corrected_array) {
#	   print "herexxxfinalarray2a1: $synonym_corrected_sentence - ENTER\n";

			$temp_corrected_sentence = $synonym_corrected_sentence;
			$temp_corrected_sentence =~ s/ //g;
			$sentence_length = length($synonym_corrected_sentence) - length($temp_corrected_sentence) + 1;
			if ($sentence_length <= $$wordnet_args{"max_wordnet_sentence_length"}) {
			    $seen_hash{$synonym_corrected_sentence}++;
				($synonym_sentence_order, $temp_sentence_order) = autoSynonym($wordnet_args, $use_original_wavfiles, $do_testsentence, 0, "", $sentence_order, $synonym_sentence_order, $temp_sentence_order, $synonym_corrected_sentence, \%seen_hash, \%wordnet_pointer_hash, \%wordnet_hash, \%pos_only_hash, \%default_pos_hash, \@pos_corrected_array, $original_wavfile_array, $original_transcription_array, $corrected_array, \@synonym_corrected_array, $original_cat_array, $synfile_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash);

				$sentence_order++;
#	   print "herexxxfinalarray2a2: $synonym_corrected_sentence - EXIT\n";
			}
		}

		foreach $synonym_corrected_sentence (@synonym_corrected_array) {
			$corrected_sentence = $corrected_sentence.$synonym_corrected_sentence."º"
		}
	}

	undef %seen_hash;

#	   print "herexxxfinalarray2b: exit:\n";

	$corrected_sentence = ApplyClassGrammars ($general_args, $cleaning_args, $test_category, $corrected_sentence);
	@$corrected_array = split /\º/, $corrected_sentence;

	$sentence_order = 0;
	$main_search_string = "";
	foreach $corrected_sentence (@$corrected_array) {
		$compressed_sentence = "";
		$compressed_alias_sentence = "";
		if ($corrected_sentence ne "") {
			if ($$cleaning_args{"removerepeats"}) {
				$corrected_sentence = RemoveRepeats($corrected_sentence);
			}

			($corrected_sentence, $firstchar) = ProcessCharsPlus($corrected_sentence);

			$compressed_sentence = chooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $corrected_sentence, $compressed_already_hash);

			if ($compressed_sentence ne "") {
				$compressed_alias_sentence = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_sentence, $compressed_already_hash);
			}

			if ($compressed_sentence eq "Ç") {
			  $compressed_sentence = $corrected_sentence;
			}

			if ($compressed_alias_sentence eq "Ç") {
			  $compressed_alias_sentence = $compressed_sentence;
			}

			@$corrected_array[$sentence_order] = $corrected_sentence;
			@$compressed_sentence_array[$sentence_order] = $compressed_sentence;
			@$compressed_alias_sentence_array[$sentence_order] = $compressed_alias_sentence;
		}

		($main_search_string, $sent_begin, $sent_end) = storeLocationInfoOrdered($corrected_sentence, $main_search_string, $sentence_order);

		$sentence_order++;
	}

   if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
	   $sentence_order = $synonym_sentence_order_start;
   }

   return ($main_search_string, $sentence_order, $synonym_sentence_order);
}

sub WriteGenRefFile
{
  my($general_args, $category_pre_search_string, $gen_referencetagfile) = @_;

  my($elem);
  my($elem1);
  my($found);
  my($genref_string);
  my(%cat_seen_hash);
  my(@real_cat_array);
  my(@temp_cat_array);

  @temp_cat_array = grep {! $cat_seen_hash{$_} ++ } (split /\º/, $category_pre_search_string);

  undef %cat_seen_hash;
  foreach $elem (@temp_cat_array) {
	if ($elem ne "") {
	  $cat_seen_hash{uc($elem)}{$elem}++;
	  push @real_cat_array, $elem;
	}
  }

  if ($gen_referencetagfile ne "") {
	$genref_string = join "\n", sort { $a cmp $b } @real_cat_array;
	$genref_string =~ s/\n\n//g;

	$genref_string = $genref_string."\n";

	open(GENREF,">$gen_referencetagfile") or die "cant open $gen_referencetagfile";
	print GENREF "$genref_string";
	close(GENREF);
  }

  open(CATERROR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch".$$general_args{"language_suffix"};

  $found = 0;
  foreach $elem ( sort { $a cmp $b } keys %cat_seen_hash) {
	if (scalar (keys %{$cat_seen_hash{$elem}}) > 1) {
	  $found = 1;
	  print CATERROR "$elem: ";
	  foreach $elem1 ( sort { $a cmp $b } keys %{$cat_seen_hash{$elem}}) {
		print CATERROR "\t$elem1";
	  }

	  print CATERROR "\n";
	}
  }

  close(CATERROR);

  if (!$found) {
	unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch".$$general_args{"language_suffix"};
  } else {
	DebugPrint ("BOTH", 2, "WriteGenRefFile", $debug, $err_no++, "CATEGORY SPELLING CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch".$$general_args{"language_suffix"});
  }
}

sub CheckIntegrity1
{
  my($use_original_wavfiles, $pre_search_string, $filename_pre_search_string, $category_pre_search_string) = @_;

  my($pre_search_string_count);
  my($filename_pre_search_string_count);
  my($category_pre_search_string_count);

  $pre_search_string_count = scalar(split /\º/, $pre_search_string);
  $filename_pre_search_string_count = scalar(split /\º/, $filename_pre_search_string);

  if ($category_pre_search_string eq "") {
	$category_pre_search_string_count = $pre_search_string_count;
  } else {
	$category_pre_search_string_count = scalar(split /\º/, $category_pre_search_string);
  }

  if ($use_original_wavfiles) {
	if (($pre_search_string_count != $category_pre_search_string_count) || ($pre_search_string_count != $filename_pre_search_string_count) || ($filename_pre_search_string_count != $category_pre_search_string_count)) {
	  DebugPrint ("BOTH", 3, "CheckIntegrity1", $debug, $err_no++, "Inconsistent Counts ***:\n\n\t\tpre_search_string_count=$pre_search_string_count\n\t\tfilename_pre_search_string_count=$filename_pre_search_string_count\n\t\tcategory_pre_search_string_count=$category_pre_search_string_count");
		DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "CheckIntegrity1", $debug, $err_no++, "\n");
	}
  } else {
	if (($pre_search_string_count != $category_pre_search_string_count)) {
	  DebugPrint ("BOTH UNDERLINE $called_from_gui", 3, "CheckIntegrity1", $debug, $err_no++, "Inconsistent Counts ***:\n\n\t\tpre_search_string_count=$pre_search_string_count\n\t\tcategory_pre_search_string_count=$category_pre_search_string_count");
	  DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "CheckIntegrity1", $debug, $err_no++, "\n");
	}
  }
}

sub CheckIntegrity2
{
  my($corrected_sentence, $compressed_sentence, $wordbag_compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_alias_sentence) = @_;

  my($alias_active);
  my($compressed_alias_count);
  my($compressed_count);
  my($corrected_count);
  my($pseudo_corrected_count);
  my($squeezed_count);
  my($wordbag_compressed_alias_count);
  my($wordbag_compressed_count);

  $corrected_count = scalar(split /\º/, $corrected_sentence);
#	   $pseudo_corrected_count = scalar(@$pseudo_corrected_array);
  $compressed_count = scalar(split /\º/, $compressed_sentence);
  $wordbag_compressed_count = scalar(split /\º/, $wordbag_compressed_sentence);
#	   $squeezed_count = scalar(split /\º/, $squeezed_sentence);

  if ($compressed_alias_sentence ne "") {
	$alias_active = 1;
	$compressed_alias_count = scalar(split /\º/, $compressed_alias_sentence);
	$wordbag_compressed_alias_count = scalar(split /\º/, $wordbag_compressed_alias_sentence);
  } else {
	$alias_active = 0;
	$compressed_alias_count = $compressed_count;
	$wordbag_compressed_alias_count = $wordbag_compressed_count;
  }

  if ($corrected_count != (($corrected_count+$compressed_count+$compressed_alias_count+$wordbag_compressed_count+$wordbag_compressed_alias_count)/5) ) {
	DebugPrint ("BOTH UNDERLINE $called_from_gui", 3, "CheckIntegrity2", $debug, $err_no++, "Inconsistent Counts ***:\n\n\t\tcorrected_count=$corrected_count\n\t\tpseudo_corrected_count=$pseudo_corrected_count\n\t\tcompressed_count=$compressed_count\n\t\tcompressed_alias_count=$compressed_alias_count\n\t\twordbag_compressed_count=$wordbag_compressed_count\n\t\twordbag_compressed_alias_count=$wordbag_compressed_alias_count\n\t\tsqueezed_count=$squeezed_count");
	DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "CheckIntegrity2", $debug, $err_no++, "\n");
  }

  return ($alias_active);
}

sub BuildDataStrings_FlatFile
{
   my($do_split_train_test, $with_retag, $general_args, $cleaning_args, $use_original_wavfiles, $parsefile, $tagged_sentence_file, $untagged_sentence_file, $retagged_categories_file, $referencetag_hash) = @_;

   my($achange);
   my($category_pre_search_string);
   my($contains_categories);
   my($elem);
   my($elem1);
   my($filename);
   my($filename_pre_search_string) = "";
   my($filesize);
   my($lastchar);
   my($line);
   my($nl_total_records);
   my($ord_char);
   my($pre_search_string);
   my($pre_search_string_count);
   my($range_begin);
   my($range_char);
   my($range_end);
   my($readlen);
   my($tagged_found) = 0;
   my($tagged_there) = 0;
   my($temp_char);
   my($temp_char186);
   my($temp_pre_search_string);
   my($temp_search_string);
   my($total_lines);
   my($transcription);
   my($untagged_found) = 0;
   my($untagged_there) = 0;
   my(@rest);

   if ($with_retag) {
	 open(TESTFILE,"<$parsefile") or die "cant open $parsefile";
	 $line = <TESTFILE>;
	 $line = ChopChar($line);
	 ($filename, $transcription, @rest) = split "\t", $line;

	 if (($rest[0] ne "") && ($rest[0] ne " ")) {
	   $contains_categories = 1;
	 }

	 close (TESTFILE);

	 if ($contains_categories) {
	   DebugPrint ("BOTH", 1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "Input file contains categories");
	 } else {
	   DebugPrint ("BOTH", 1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "Input file does NOT contain categories");
	 }
   }

   open(TESTFILE,"<$parsefile") or die "cant open $parsefile";
   $filesize = -s TESTFILE;
   $readlen = sysread TESTFILE, $pre_search_string, $filesize;
   close (TESTFILE);

#   print "herettt111: $pre_search_string\n";
   $pre_search_string = ChopChar($pre_search_string);
#  if ($pre_search_string =~ /([^a-zA-Z0-9 \n\t\s\f\r])/g) {
   if ($pre_search_string =~ /([^ a-zA-Z0-9\n\s\f\r\/\@\\\.\:\#\*\~\|\!\"\$\%\^\&\,\<\>\?\'\-\_\+\(\)\[\]\{\}])/g) {
#   if ($pre_search_string =~ /[^(a-zA-Z0-9\n\t\s\/\@\\\.\:\#\*\~\|\!\"\$\%\^\&\,\<\>\?\'\-\_\+\(\)\[\]\{\})]/g) {
	 $range_begin = (pos $pre_search_string) - 30;
	 $range_end = 60;
	 $range_char = substr($pre_search_string, (pos $pre_search_string)-1, 1);
	 $ord_char = ord($range_char);
	 $temp_search_string = substr($pre_search_string, $range_begin, $range_end);
	 DebugPrint ("BOTH", 3, "BuildDataStrings_FlatFile", $debug, $err_no++, "Non-standard character found ***:\tposition=".(pos $pre_search_string).", character=$range_char, ASCII=$ord_char, input section=$temp_search_string\n");
   }
#   $pre_search_string =~ s/\Â\ / /g;
#   $pre_search_string =~ s/\Â/ /g;
   $pre_search_string =~ s/$char13\n/\º/g;
   $pre_search_string =~ s/$char13/\º/g;
   $pre_search_string =~ s/\n/\º/g;

   if ($pre_search_string =~ /RAMBLE_EXCLUSION/) {
	 $pre_search_string = "º".$pre_search_string."º";
	 $pre_search_string =~ s/((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\t)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\tRAMBLE_EXCLUSION)\º//g;
	 $pre_search_string = substr($pre_search_string, 1);
	 chop($pre_search_string);

	 DebugPrint ("BOTH", 0.1, "BuildDataStrings_FlatFile", $debug, $err_no++, "Removing Ramble Exclusion lines in file before analysis ... <done>");
   }

   $lastchar = substr($pre_search_string,length($pre_search_string)-1,1);
   if (ord($lastchar) == 9) {
	 chop($pre_search_string);
   }

#	 print "hereqqq1: pre_search_string=$pre_search_string\n";
#   $char186 = quotemeta($char186);
#   $pre_search_string =~ tr/\º/\º/s;
#   $temp_char186 = quotemeta($char186);
   $pre_search_string =~ tr/º/º/s;

   if (!$with_retag) {
	 $pre_search_string = "º".$pre_search_string."º";

	 if ($pre_search_string =~ /(\º((\s)*)\º)/) {
	   $achange = quotemeta($1);
	   DebugPrint ("BOTH", 0.1, "BuildDataStrings_FlatFile", $debug, $err_no++, "Removing Blank lines in file before analysis ... <done>");

	   $pre_search_string =~ s/$achange/\º/g;
	 }

	 if ($pre_search_string =~ /((^\#.*?\º)|(\#.*?\º))/) {
	   my($remove_comment);
	   my($remove_elem);
	   my(%remove_comment_hash);
	   while ($pre_search_string =~ /((^\#.*?\º)|(\#.*?\º))/g) {
		 $remove_comment_hash{$1}++;
	   }

	   foreach $remove_elem ( sort { $a cmp $b } keys %remove_comment_hash) {
		 $remove_elem = quotemeta($remove_elem);
		 $pre_search_string =~ s/$remove_elem//g;
	   }
	 }

	 if ($pre_search_string =~ /((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\t)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\t((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+))/) {
	   $tagged_there = 1;
	 }

	 if ($pre_search_string =~ /(\º)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\t)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)((\t(( )*)\º)|((( )*)\º))/) {
	   $untagged_there = 1;
	   while ($pre_search_string =~ /(\º)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)(\t)((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)((\t(( )*)\º)|((( )*)\º))/g) {
		 $temp_search_string = $2;
		 $untagged_there = 0;

		 $temp_search_string =~ s/\ //g;
		 if (substr($temp_search_string,0,1) ne "#") {
		   $untagged_there = 1;
		   last;
		 }
	   }
#	 print "hereqqq1a1: 1=$1, pre_search_string=$pre_search_string\n";
#	 print "hereqqq1a1: 2=$2, 5=$5\n";
#	 print "hereqqq1a2: pre_search_string=$pre_search_string\n";
	 }

	 $pre_search_string = substr($pre_search_string, 1);
	 chop($pre_search_string);

 #print "hereaaa2: untagged_there=$untagged_there, tagged_there=$tagged_there\n";
	 if ($untagged_there) {
	   $contains_categories = 0;
	   if ($tagged_there) {
		 DebugPrint ("BOTH", 2, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "[Input file contains categories with some untagged sentences: see the file $untagged_sentence_file]");
		 DebugPrint ("BOTH", 1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "Removing untagged sentences ... done");
		 $contains_categories = 1;

		 ($tagged_found, $untagged_found, $total_lines) = SeparateTaggedSentences("BuildDataStrings_FlatFile", $parsefile, $tagged_sentence_file, $untagged_sentence_file, $retagged_categories_file);

		 open(TESTFILE,"<$tagged_sentence_file") or die "cant open $tagged_sentence_file";
		 $filesize = -s TESTFILE;
		 $readlen = sysread TESTFILE, $pre_search_string, $filesize;
		 close (TESTFILE);

		 $pre_search_string = ChopChar($pre_search_string);
		 $pre_search_string =~ s/$char13\n/\º/g;
		 $pre_search_string =~ s/$char13/\º/g;
#		 $pre_search_string =~ s/\Â\ / /g;
#		 $pre_search_string =~ s/\Â/ /g;
		 $pre_search_string =~ s/\n/\º/g;
#		 $pre_search_string =~ s/\<partial\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/partial\>/ /g;
#		 $pre_search_string =~ s/\<sidespeech\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/sidespeech\>/ /g;
#		 $pre_search_string =~ s/\<\//\[/g;
#		 $pre_search_string =~ s/\</\[/g;
#		 $pre_search_string =~ s/\/\>/\]/g;
#		 $pre_search_string =~ s/\>/\]/g;
#   print "herettt222: $pre_search_string\n";

		 $lastchar = substr($pre_search_string,length($pre_search_string)-1,1);
		 if (ord($lastchar) == 9) {
		   chop($pre_search_string);
		 }

		 $pre_search_string =~ tr/º/º/s;
	   } else {
		 DebugPrint ("BOTH", 1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "[Input file does NOT contain categories]");
	   }
	 } elsif ($tagged_there) {
	   $contains_categories = 1;
	   DebugPrint ("BOTH", 1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "[Input file contains categories]");
	 }
   }

   if (($$general_args{"create_regexp"}) || ($do_split_train_test ne "") || ($use_original_wavfiles) ) {
	 $filename_pre_search_string = $pre_search_string;
	 $lastchar = substr($filename_pre_search_string,length($filename_pre_search_string)-1,1);
	 if ($lastchar ne "º") {
	   $filename_pre_search_string = $filename_pre_search_string."º";
	 }
   }

   $pre_search_string =~ s/^(.*?)\t//g;
   $pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
   $pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
   $pre_search_string =~ s/ \º/\º/g;

#ATTENTION
#   if ($pre_search_string =~ /\#/) {
#	 $pre_search_string = ApplySplitSentences($pre_search_string);
#   }

   $pre_search_string_count = scalar(split /\º/, $pre_search_string);
   $nl_total_records = $pre_search_string_count;

   if (($$general_args{"create_regexp"}) || ($do_split_train_test ne "") || ($use_original_wavfiles) ) {
	 $filename_pre_search_string =~ s/\t(.*?)\º/\º/g;
	 chop($filename_pre_search_string);
  }

#   ATTENTION if (($contains_categories) && ($pre_search_string !~ /\//)) {
   if (($contains_categories)) {

	 DebugPrint ("BOTH", 0.1, "Sub::BuildDataStrings_FlatFile", $debug, $err_no++, "Collecting sentences and categories ... done");

	 $category_pre_search_string = $pre_search_string;
	 $pre_search_string = $pre_search_string."º";
	 $pre_search_string =~ s/\t(.*?)\º/\º/g;
	 chop ($pre_search_string);

	 $category_pre_search_string =~ s/^(.*?)\t//g;
	 $category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
	 $category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
	 $category_pre_search_string =~ s/ \º/\º/g;
	 $category_pre_search_string =~ s/^(\t)//g;
	 $category_pre_search_string =~ s/\º\t/\º/g;

	 $category_pre_search_string = ApplyReferenceTags($$general_args{"language_suffix"}, $$general_args{"test_reject_name"}, $category_pre_search_string, $referencetag_hash);

	 undef %{$referencetag_hash};
   }

   return($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories);
 }

sub BuildDataStrings_Other
{
   my($do_classify, $input_is_transcription, $parsefile, $parsefile_array, $grammar_pointer, $grammar_type) = @_;

   my($category_pre_search_string) = "";
   my($contains_categories);
   my($elem);
   my($filename);
   my($filename_pre_search_string) = "";
   my($i);
   my($lastchar);
   my($line);
   my($lname);
   my($nl_total_records);
   my($pre_search_string);
   my($pre_search_string_count);
   my($transcription);
   my($use_original_wavfiles) = 0;
   my(%data_store_hash);

   if ($do_classify && $input_is_transcription) {
	 $use_original_wavfiles = 1;
   }

   if (($grammar_pointer ne "___MULTI___") && (!opendir("TRANSDIR", $parsefile))) {
	 open(TESTFILE,"<$parsefile") or die "cant open $parsefile";
	 while(<TESTFILE>) {
	   $line = ChopChar($_);

	   $line =~ s/FILE \:/FILE:/g;
	   $line =~ s/TRANSCRIPTION \:/TRANSCRIPTION:/g;

	   if (substr($line,0,1) eq "#") {
		 next;
	   }

	   if ($line eq "") {
		 next;
	   }

	   if ($grammar_type eq "NUANCE_GSL" || $grammar_type eq "NUANCE9") {
		 if (!$input_is_transcription) {
		   if ($line =~ /FILE:/) {
			 $input_is_transcription = 1;
		   } else {
			 last;
		   }
		 }

		 if ($input_is_transcription) {
		   if ($line =~ /FILE: (.*)/) {
			 $filename = $1;
			 next;
		   }

		   if ($do_classify) {
			 $use_original_wavfiles = 1;
		   }

		   if ($line =~ /TRANSCRIPTION: (.*)/) {
			 $nl_total_records++;
			 $transcription = $1;

			$pre_search_string = stringBuilder($pre_search_string, $transcription."º", "");

			 if ($use_original_wavfiles) {
			   $filename_pre_search_string = stringBuilder($filename_pre_search_string, $filename."º", "");
			 }
		   }
		 }
	   } elsif ($grammar_type eq "NUANCE_SPEAKFREELY") {
		 if (!$input_is_transcription) {
		   if ($line =~ /TranscriptionManifest/) {
			 $input_is_transcription = 1;
			 next;
		   } else {
			 last;
		   }
		 }

		 if ($input_is_transcription) {
		   if( $line =~ /\<Utt/ )           {
			 if($line =~ /audio=\"(([0-9a-z]|\,|\.|\-)+)\" /)           {
			   $filename = $1;
			   $filename =~ s/\"//g;
			 }

			 if ($line =~ /transcribedText=\"(.*)\"/) {
			   $nl_total_records++;
			   $transcription = $1;
			   $transcription =~ s/\"//g;

			   $pre_search_string = stringBuilder($pre_search_string, $transcription."º", "");

			   if ($do_classify) {
				 $use_original_wavfiles = 1;
			   }

			   if ($use_original_wavfiles) {
				 $filename_pre_search_string = stringBuilder($filename_pre_search_string, $filename."º", "");
			   }
			 }
		   }
		 }
	   }
	 }

	 close (TESTFILE);
   } else {
	 my($target) = "$parsefile/*.trmxml";
	 my($loop_counter) = 1;
	 my($loc_grammar_pointer) = $grammar_pointer;

	 if ($grammar_type eq "NUANCE_GSL") {
	   $target = "$parsefile/*";
	 }

	 closedir("TRANSDIR");
	 $input_is_transcription = 1;

	 if ($loc_grammar_pointer eq "___MULTI___") {
	   $loop_counter = scalar (@$parsefile_array);
	 }

	 for ($i = 0; $i < $loop_counter; $i++) {
	   if ($loc_grammar_pointer eq "___MULTI___") {
		 ($parsefile, $grammar_pointer) = split "=", @$parsefile_array[$i];
		 if ($grammar_pointer eq "") {
		   $grammar_pointer = "G2";
		 }

		 $target = "$parsefile/*.trmxml";
	   }

	   while(glob("$target")) {
		 #		   while(<$parsefile>) {
		 chomp;

		 $lname = $_;

		 open(LOGFILE,"<$_")|| die "cant open LOGFILE";

		 while($line = <LOGFILE>) {
		   $line = ChopChar($line);

		   if (substr($line,0,1) eq "#") {
			 next;
		   }

		   if ($line eq "") {
			 next;
		   }

		   if ($grammar_type eq "NUANCE_GSL") {
			 if ($line =~ /FILE: (.*)/) {
			   $filename = $1;
			   next;
			 }

			 if ($line =~ /TRANSCRIPTION: (.*)/) {
			   $nl_total_records++;
			   $transcription = $1;

			   if (not defined $data_store_hash{$filename}) {
				 $data_store_hash{$filename} = $transcription;
			   } else {
				 if (($data_store_hash{$filename} eq "") && ($transcription ne "")) {
				   $data_store_hash{$filename} = $transcription;
				 }
			   }
			 }
		   } elsif ($grammar_type eq "NUANCE_SPEAKFREELY" || $grammar_type eq "NUANCE9") {
			 if( $line =~ /\<Utt/ )           {
					 if($line !~ /grammarSet=\"$grammar_pointer\" /)           {
					   next;
					 }

					 if($line =~ /audio=\"(([0-9a-z]|\,|\.|\-)+)\" /)           {
					   $filename = $1;
					   $filename =~ s/\"//g;
					 }

					 if ($line =~ /transcribedText=\"(.*?)\"/) {
					   $transcription = $1;
					   $transcription =~ s/\"//g;
					   $transcription =~ s/\&((\w|\_)+)\;/convertCharEntity($1)/eg;

					   if (lc($transcription) !~ /no_transcription/) {
						 $nl_total_records++;

						 if (not defined $data_store_hash{$filename}) {
						   if ($transcription eq "") {
							 $transcription = "___NULL___";
						   }

						   $data_store_hash{$filename} = $transcription;
						 } else {
						   if (($data_store_hash{$filename} eq "___NULL___") && ($transcription ne "")) {
							 $data_store_hash{$filename} = $transcription;
						   }
						 }
					   }
					 }
				   }
				 }
			   }

		 close(LOGFILE);
	   }
	 }

	 foreach $elem ( sort { $a cmp $b } keys %data_store_hash) {
	   if ($data_store_hash{$elem} ne "___NULL___") {
		 if ($use_original_wavfiles) {
		   $filename_pre_search_string = stringBuilder($filename_pre_search_string, $elem."º", "");
		 }

		 $pre_search_string = stringBuilder($pre_search_string, $data_store_hash{$elem}."º", "");
	   }
	 }

	 undef %data_store_hash;

	 $pre_search_string = substr($pre_search_string,0, length($pre_search_string)-1);
	 if ($use_original_wavfiles) {
	   $filename_pre_search_string = substr($filename_pre_search_string,0, length($filename_pre_search_string)-1);
	 }

	 $lastchar = substr($pre_search_string,length($pre_search_string)-1,1);
	 if (ord($lastchar) == 9) {
	   chop($pre_search_string);
	 }

	 $pre_search_string =~ tr/º/º/s;
	 $pre_search_string =~ s/ \º/\º/g;
#	 $pre_search_string =~ s/\<partial\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/partial\>/ /g;
#	 $pre_search_string =~ s/\<sidespeech\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/sidespeech\>/ /g;
#	 $pre_search_string =~ s/\Â\ / /g;
#	 $pre_search_string =~ s/\Â/ /g;
#	 $pre_search_string =~ s/\<\//\[/g;
#	 $pre_search_string =~ s/\</\[/g;
#	 $pre_search_string =~ s/\/\>/\]/g;
#	 $pre_search_string =~ s/\>/\]/g;

	 $pre_search_string_count = scalar(split /\º/, $pre_search_string);
	 $nl_total_records = $pre_search_string_count;

	 $category_pre_search_string = "";
	 $contains_categories = 0;

	 CheckIntegrity1($use_original_wavfiles, $pre_search_string, $filename_pre_search_string, $category_pre_search_string);
   }

   return($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription);
 }

sub WriteDataStrings
{
  my($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription) = @_;

  if ($pre_search_string ne "") {
	open(WOUT,">"."slmdirect_results/createslmDIR_temp_files/temp_pre_search_string") or die "cant write "."slmdirect_results/createslmDIR_temp_files/temp_pre_search_string";
	print WOUT "$pre_search_string\n";
	close(WOUT);
  } else {
	unlink "slmdirect_results/createslmDIR_temp_files/temp_pre_search_string";
  }

  if ($filename_pre_search_string ne "") {
	open(WOUT,">"."slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string") or die "cant write "."slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string";
	print WOUT "$filename_pre_search_string\n";
	close(WOUT);
  } else {
	unlink "slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string";
  }

  if ($category_pre_search_string ne "") {
	open(WOUT,">"."slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string") or die "cant write "."slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string";
	print WOUT "$category_pre_search_string\n";
	close(WOUT);
  } else {
	unlink "slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string";
  }

  open(WOUT,">"."slmdirect_results/createslmDIR_temp_files/temp_data_booleans") or die "cant write "."slmdirect_results/createslmDIR_temp_files/temp_data_booleans";
  print WOUT "$pre_search_string_count\t$nl_total_records\t$contains_categories\t$input_is_transcription\n";
  close(WOUT);
}

sub ReadDataStrings
{
  my($general_args, $wordnet_args, $use_original_wavfiles, $input_is_transcription, $do_classify) = @_;

  my($category_pre_search_string);
  my($contains_categories);
  my($filename_pre_search_string);
  my($filesize);
  my($line);
  my($nl_total_records);
  my($pre_search_string);
  my($pre_search_string_count);
  my($readlen);

  if (-e "slmdirect_results/createslmDIR_temp_files/temp_pre_search_string") {
	open(WIN,"<"."slmdirect_results/createslmDIR_temp_files/temp_pre_search_string") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_pre_search_string";
	$filesize = -s WIN;
	$readlen = sysread WIN, $pre_search_string, $filesize;
	close (WIN);

	$pre_search_string = ChopChar($pre_search_string);
  }

  open(WIN,"<"."slmdirect_results/createslmDIR_temp_files/temp_data_booleans") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_data_booleans";
  while(<WIN>) {
	$line = ChopChar($_);
	($pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription) = split "\t", $line;
  }

  close(WIN);

  if (($input_is_transcription && $do_classify) || $$wordnet_args{"do_autotag"}) {
	$use_original_wavfiles = 1;
  }

  if (($$general_args{"create_regexp"}) || ($$general_args{"split_train_test"}) || ($use_original_wavfiles) ) {
	if (-e "slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string") {
	  open(WIN,"<"."slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_filename_pre_search_string";
	  $filesize = -s WIN;
	  $readlen = sysread WIN, $filename_pre_search_string, $filesize;
	  close (WIN);

	  $filename_pre_search_string = ChopChar($filename_pre_search_string);
	}
  }

  if (-e "slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string") {
	open(WIN,"<"."slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string") or die "cant open "."slmdirect_results/createslmDIR_temp_files/temp_category_pre_search_string";
	$filesize = -s WIN;
	$readlen = sysread WIN, $category_pre_search_string, $filesize;
	close (WIN);

	$category_pre_search_string = ChopChar($category_pre_search_string);
  }

  return($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription, $use_original_wavfiles);
}

sub storeLocationInfo
{
   my($string_entry, $main_search_string, $sentence_order) = @_;

   if ($sentence_order == 0) {
	   $main_search_string = $string_entry."º";
   } else {
	   $main_search_string = $main_search_string.$string_entry."º";
   }

   return ($main_search_string);
}

sub storeLocationInfoOrdered
{
   my($string_entry, $main_search_string, $sentence_order) = @_;

   my($searchlen) = length($main_search_string);
   my($add_len) = length($string_entry)+length($sentence_order)+2;

   if ($sentence_order == 0) {
	   $main_search_string = $string_entry."[$sentence_order]"."º";
	   return ($main_search_string, 0, $add_len-1);
   } else {
	   $main_search_string = $main_search_string.$string_entry."[$sentence_order]"."º";
	   return ($main_search_string, ($searchlen+1), (($searchlen+1)+$add_len-1));
   }
}

sub storeLocationInfoOrderedCombo
{
   my($string_entry, $main_search_string, $sentence_order) = @_;

   my($add_len) = length($string_entry)+length($sentence_order)+2;
   my($loc);
   my($match_len);
   my($old_sentence_order);
   my($searchlen) = length($main_search_string);
   my($so_end_loc);
   my($so_start_loc);

   if ($sentence_order == 0) {
	   $main_search_string = $string_entry."[$sentence_order]"."º";
	   return ($main_search_string, 0, $add_len-1);
   } else {
	   $main_search_string = "º".$main_search_string;
	   $loc = index($main_search_string, "º".$string_entry."[");
	   if ($loc != -1) {
		   $match_len = length($string_entry);
		   $so_start_loc = index($main_search_string, "[", $loc);
		   $so_end_loc = index($main_search_string, "]", $so_start_loc);
		   $old_sentence_order = substr($main_search_string, $so_start_loc+1, $so_end_loc-$so_start_loc-1);

		   $main_search_string = substr($main_search_string, 0, $loc+1).$string_entry."[$old_sentence_order+$sentence_order]"."º".substr($main_search_string, $so_end_loc+2);
	   } else {
		   $main_search_string = $main_search_string.$string_entry."[$sentence_order]"."º";
	   }

	   $main_search_string =~ s/\º//;

	   return ($main_search_string, ($searchlen+1), (($searchlen+1)+$add_len-1));
   }
}

sub CheckSkipPhrase
{
   my($calling_location, $meaning_args, $wordnet_args, $corrected_sentence) = @_;

   my($pos) = 0;
   my($skip_string) = "";
   my($compressed_sentence) = "";
   my($success);
   my(@sent_to_rule_array);

   if (not defined $$meaning_args{"check_skip"}{$corrected_sentence}) {
	   (@sent_to_rule_array) = split " ", $corrected_sentence;
	   while ($pos < scalar (@sent_to_rule_array)) {
		 ($success, $pos, $skip_string, $compressed_sentence) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, \@sent_to_rule_array, $pos, $skip_string, $compressed_sentence);
	   }

	   $$meaning_args{"check_skip"}{$corrected_sentence} = $compressed_sentence;
   } else {
	   $compressed_sentence = $$meaning_args{"check_skip"}{$corrected_sentence};
   }

   return ($compressed_sentence);
}

sub CheckSkipPhrase2
{
   my($meaning_args, $wordnet_args, $sent_to_rule_array) = @_;

   my($pos) = 0;
   my($skip_string) = "";
   my($compressed_sentence) = "";
   my($success);
   my($corrected_sentence) = join " ", @$sent_to_rule_array;

   if (not defined $$meaning_args{"check_skip"}{$corrected_sentence}) {
	   while ($pos < scalar (@$sent_to_rule_array)) {
		   ($success, $pos, $skip_string, $compressed_sentence) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, $sent_to_rule_array, $pos, $skip_string, $compressed_sentence);
	   }

	   $$meaning_args{"check_skip"}{$corrected_sentence} = $compressed_sentence;
   } else {
	   $compressed_sentence = $$meaning_args{"check_skip"}{$corrected_sentence};
   }

   return ($compressed_sentence);
}

sub TestSkipPhrase {

    my($mode, $meaning_args, $wordnet_args, $line, $pos, $skip_build_string, $keep_build_string) = @_;

	my($i);
	my($j);
	my($success) = 0;
	my($test_build_string);
	my($testcnt);
	my($hold_testcnt);
	my($used) = 0;
	my($unlessed) = 0;
	my($skip_unless) = 0;

	my($filler_text);
	my($combo_text);
	my($combo_first_text);
	my($unless_text);
	my($unless_first_text);
	my($pass_text);
	my($pass_first_text);
	my($take_pass) = 0;

	$filler_text = "filler";
	$combo_text = "combo";
	$combo_first_text = "combo_first";
	$unless_text = "unless";
	$unless_first_text = "unless_first";
	$pass_text = "pass";
	$pass_first_text = "pass_first";

	if ($$meaning_args{"scan_language"} ne "") {
		$filler_text = $filler_text."_".$$meaning_args{"scan_language"};
		$combo_text = $combo_text."_".$$meaning_args{"scan_language"};
		$combo_first_text = $combo_first_text."_".$$meaning_args{"scan_language"};
		$unless_text = $unless_text."_".$$meaning_args{"scan_language"};
		$unless_first_text = $unless_first_text."_".$$meaning_args{"scan_language"};
		$pass_text = $pass_text."_".$$meaning_args{"scan_language"};
		$pass_first_text = $pass_first_text."_".$$meaning_args{"scan_language"};
	}

	if (($$line[$pos] =~ /\?/) || ($$line[$pos] =~ /\ª/)) {
		$skip_build_string = stringBuilder($skip_build_string, $$line[$pos], " ");

		$pos++;
		$success = 1;
	}

	if (defined $$meaning_args{"pre"}{$pass_first_text}{$$line[$pos]}) {
		$take_pass = 0;
		$testcnt = (scalar @$line) - $pos;
		if ($testcnt > 5) {
			$testcnt = 5;
		}

		for ($i = $testcnt; $i > 1; $i--) {
			$test_build_string = "";
			for ($j = $pos; $j < $pos+$i; $j++) {
			  $test_build_string = stringBuilder($test_build_string, $$line[$j], " ");
			}

			if (defined $$meaning_args{"pre"}{$pass_text}{$$line[$pos]}{$test_build_string}) {
				if ($mode eq "SCAN") {
					$testcnt = 1;
				} else {
					$testcnt = $i;
				}

				$take_pass = 1;

				last;
			}
		}

		if (!$take_pass) {
			if (defined $$meaning_args{"pre"}{$pass_text}{$$line[$pos]}{$$line[$pos]}) {
				$testcnt = 1;
				$take_pass = 1;
				$test_build_string = $$line[$pos];
			}
		}
	}

	if ((!$take_pass)&& ((defined $$meaning_args{"pre"}{$filler_text}{$$line[$pos]} || defined $$meaning_args{"pre"}{$combo_first_text}{$$line[$pos]} || defined $$meaning_args{"pre"}{$unless_first_text}{$$line[$pos]}))) {
		if (defined $$meaning_args{"pre"}{$unless_first_text}{$$line[$pos]}) {
			$unlessed = 1;
			$skip_unless = 0;
			$testcnt = (scalar @$line) - $pos;
			if ($testcnt > 5) {
				$testcnt = 5;
			}

			for ($i = $testcnt; $i > 1; $i--) {
				$test_build_string = "";
				for ($j = $pos; $j < $pos+$i; $j++) {
				  $test_build_string = stringBuilder($test_build_string, $$line[$j], " ");
				}

				if (defined $$meaning_args{"pre"}{$unless_text}{$$line[$pos]}{$test_build_string}) {
					if ($mode eq "SCAN") {
						$testcnt = 1;
					} else {
						$unlessed = 0;
						$testcnt = $i;
					}

					$hold_testcnt = $testcnt;
					$skip_unless = 1;
					last;
				}
			}

		}

		if ((!$unlessed) && (defined $$meaning_args{"pre"}{$combo_first_text}{$$line[$pos]})) {
			$testcnt = (scalar @$line) - $pos;
			if ($testcnt > 5) {
				$testcnt = 5;
			}

			for ($i = $testcnt; $i > 1; $i--) {
				$test_build_string = "";
				for ($j = $pos; $j < $pos+$i; $j++) {
				  $test_build_string = stringBuilder($test_build_string, $$line[$j], " ");
				}

				if (defined $$meaning_args{"pre"}{$combo_text}{$$line[$pos]}{$test_build_string}) {
					$testcnt = $i;
					$used = 1;

					last;
				}
			}

		    if (!$used) {
				$testcnt = $hold_testcnt;
			}
	    }

		if ($skip_unless) {
		  $keep_build_string = stringBuilder($keep_build_string, $test_build_string, " ");

			$pos += ($testcnt);
			$success = 0;
		} elsif ($used) {
		  $skip_build_string = stringBuilder($skip_build_string, $test_build_string, " ");

			$pos += ($testcnt);
			$success = 1;
		} elsif (($unlessed) || ((!$used) && defined $$meaning_args{"pre"}{$filler_text}{$$line[$pos]})) {
		  $skip_build_string = stringBuilder($skip_build_string, $$line[$pos], " ");

			$pos++;
			$success = 1;
		}
	}

	if ($take_pass) {
	  $keep_build_string = stringBuilder($keep_build_string, $test_build_string, " ");

		$pos += ($testcnt);
		$success = 0;
	} else {
		if ((!$skip_unless)&& (!$success)) {
		  $keep_build_string = stringBuilder($keep_build_string, $$line[$pos], " ");
		  $pos++;
		}
	}

	return ($success, $pos, $skip_build_string, $keep_build_string);
}

############# END String Processing SUBROUTINES ######################

######################################################################
######################################################################
############# FILTERCORPUS Processing SUBROUTINES ####################
######################################################################
######################################################################

sub SearchAppHash
{

    my($main_language, $line, $app_hash, $pos, $string_type, $max_len) = @_;

	my($found) = 0;
	my($i);
	my($j);
	my($testcnt);
	my($test_phrase);

	if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
		if (index($string_type,"verb") != -1) {
			if ($pos >= 1) {
				if ($$line[$pos-1] =~ /\ba\b|\ban\b|\bthe\b|\bmy\b|\bour\b|\byour\b|\bhis\b|\bher\b/) {
					return 0;
				}
			}
		}

		if (index($string_type,"noun") != -1) {
			if ($pos >= 1) {
				if ($$line[$pos-1] =~ /\bto\b|\band\b|\bor\b|\bbut\b/) {
					return 0;
				}
			}
		}
	}

	$testcnt = (scalar @{$line}) - $pos;
	if ($testcnt > $max_len) {
		$testcnt = $max_len;
	}

	for ($i = $testcnt; $i >= 1; $i--) {
		$test_phrase = "";
		for ($j = $pos; $j < $pos+$i; $j++) {
		  $test_phrase = stringBuilder($test_phrase, $$line[$j], " ");
		}

		if (defined $$app_hash{"$string_type"."_"."$i"}{$test_phrase}) {
			$found = 1;
			last;
		}
	}

	return $found;
}

sub AssignLineType {

    my($general_args, $meaning_args, $wordnet_args, $inline, $item_category, $mycorpus_filename, $debug, $app_hash, $pre_phrases_hash, $grammar_elems, $grammar_elems_other, $do_filtercorpus_direct, $gram_elem_cat_hash) = @_;

	my($addin);
	my($build_letters);
	my($build_string);
	my($comp_line);
	my($elem);
	my($elem1);
	my($elem1_q);
	my($first_word_index);
	my($last_word_index);
	my($first_word);
	my($last_word);
	my($i);
	my($j);
	my($keep_string);
	my($line_type_actual);
	my($line_type);
	my($max_word);
	my($min_word);
	my($myline);
	my($pos);
	my($save_noun);
	my($skip);
	my($temp);
	my($temp_line);
	my($temp_word);
	my(%first_word_hash);
	my(%grammar_elems_no_pre_first_word);
	my(%repeat_hash_grammar);
	my(%repeat_hash_pre);

	my(@line);
	my(@repeat_array);
	my(@rest);
	my(@temp_line);

	my($success);

	my($fline);

	$debug = 0;

	$myline = $inline;
	if ($do_filtercorpus_direct) {
		if ($item_category eq "") {
			$fline = ChopChar($inline);
			($item_category, $myline) = split "\t", $fline;
#			$item_category = NormCat($item_category, $test_reject_name);
		}
	}

	$myline = ProcessCharsInitial($myline);

	if ($myline eq "") {
		next;
	}

	if (($myline ne "") && substr($myline,0,1) ne "#"){
		if ($$general_args{"downcase_utt"}) {
			$myline = lc($myline);
		}

		if (defined $repeat_hash_pre{$myline} || defined $repeat_hash_grammar{$myline}) {
			if (defined $repeat_hash_pre{$myline}) {
				(@repeat_array) = split ",", $repeat_hash_pre{$myline};
				$line_type_actual = $repeat_array[2];
				if ($repeat_array[0] eq "pre") {
					$$pre_phrases_hash{$repeat_array[1]}{$repeat_array[3]}++;
				} elsif ($repeat_array[0] eq "unknown") {
					$$pre_phrases_hash{"unknown"}{$repeat_array[3]}++;
				}
			}

			if (defined $repeat_hash_grammar{$myline}) {
				(@repeat_array) = split ",", $repeat_hash_grammar{$myline};
				$line_type_actual = $repeat_array[2];
				if ($repeat_array[0] eq "unattached") {
					if ($repeat_array[3] ne "") {
						$$grammar_elems_other{$repeat_array[1]}{$repeat_array[3]}++;
					}
				} elsif ($repeat_array[0] eq "grammar") {
					$$grammar_elems{$repeat_array[1]}{$repeat_array[3]}++;
					$first_word_hash{$repeat_array[1]}{$repeat_array[4]}++;
				} elsif ($repeat_array[0] eq "grammar_other") {
					$$grammar_elems_other{$repeat_array[1]}{$repeat_array[3]}++;
					$grammar_elems_no_pre_first_word{$repeat_array[3]} = $repeat_array[4];
				} elsif ($repeat_array[0] eq "unknown") {
					$$grammar_elems_other{"full"}{$myline}++;
				}
			}

			DebugPrint ("", 1, "AssignLineType ", $debug, $err_no++, "1: line_type_actual_hash = $line_type_actual\n\n");

			if ($mycorpus_filename ne "STDIN") {
				next;
			}
		}

		@temp_line = split / /, $myline;
		@line = ();

		$build_letters = "";
		for ($i = $0; $i < (scalar @temp_line); $i++) {
			$elem = $temp_line[$i];
			if (index($elem,"-") == -1) {
# í á ñ ú é ó ú
				if (($elem =~ /\b[abcdefghijklmnopqrstuvwxyzíáñúéó]\b/) && index($elem, "'") == -1) {
					for ($j = $i + 1; $j < (scalar @temp_line); $j++) {
						$elem1 = $temp_line[$j];
						if (index($elem1,"-") == -1) {
							if (($elem1 =~ /\b[abcdefghijklmnopqrstuvwxyzíáñúéó]\b/) && index($elem1, "'") == -1) {
								if ($build_letters eq "") {
									$build_letters = $elem."_".$elem1;
								} else {
									$build_letters = $build_letters."_".$elem1;
								}
							} else {
								last;
							}
						} else {
							last;
						}
					}
				}

				if ($build_letters ne "") {
					push @line, $build_letters;
					$i = $j - 1;
					$build_letters = "";
				} else {
					push @line, $elem;
				}
			}
		}

# Scan through input line to first "meaningful" word, skipping all pre-defined words.
		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$pos = 0;
			$build_string = "";
			$keep_string = "";
			$success = 1;
			while ($success) {
				($success, $pos, $build_string, $keep_string) = TestSkipPhrase ("SCAN", $meaning_args, $wordnet_args, \@line, $pos, $build_string, $keep_string);
			}

			$pos--;
		}

		if ($$general_args{"main_language"} eq "es-us") {
			$pos = 0;
			$build_string = "";
			$keep_string = "";
			$success = 1;
			while ($success) {
				($success, $pos, $build_string, $keep_string) = TestSkipPhrase ("SCAN", $meaning_args, $wordnet_args, \@line, $pos, $build_string, $keep_string);
			}
			$pos--;
		}

# Replace 'my', 'a', 'the', etc. by the sub-grammar MY

		$line_type = "unknown";
		$line_type_actual = "unknown>>0>>$myline";
		if ($build_string ne "") {
			if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
				if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
					$build_string = ReplaceMy($$general_args{"main_language"}, " my", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " a", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " an", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " the", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " his", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " her", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " our", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " your", $build_string);
				}

# Try to determine what type of sentence it is, based on word sequence patterns

				if ($pos >= 1) {
					if ($line_type eq "unknown") {
						$comp_line = "";
						for ($i = 0; $i <= $pos; $i++) {
						  $comp_line = stringBuilder($comp_line, $line[$i], " ");
						}

						$max_word = -9999;
						$min_word = 9999;
						$save_noun = "";
						foreach $elem ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}}) {
							if (($elem !~ /_esus/) && ($elem !~ /unknown/) && ($elem !~ /unless/) && ($elem !~ /pass/) && ($elem !~ /filler/) && ($elem !~ /combo/)) {
								foreach $elem1 ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}{$elem}}) {
									$addin = "";
									$elem1_q = quotemeta($elem1);

									if ($elem1 eq $elem1_q) {
										$addin = " ";
									}

									if ($comp_line =~ /\b$elem1_q$addin/) {
										($first_word, @rest) = split " ", $elem1;
										$first_word_index = index($myline, $first_word);
										$temp = scalar(@rest)-1;

										if ($temp == -1) {
											$last_word = $first_word;
											$last_word_index = $first_word_index;
										} else {
											$last_word = $rest[scalar(@rest)-1];
											$last_word_index = index($myline, $last_word);
										}

										if ($first_word_index <= $min_word && $last_word_index >= $max_word) {
											if ($elem eq "noun") {
												if (($pos < 3) || ($first_word_index < 3)) {
													$save_noun = "$elem";
													next;
												}
											}

											$min_word = $first_word_index;
											$max_word = $last_word_index;
											$line_type = "$elem";
											$line_type_actual = "$elem >> $pos >> $myline";

										}
									}
								}
							}
						}

						if ($line_type eq "i_am") {
							if ((substr($line[$pos], length($line[$pos])-3, 3) eq "ing") || (substr($line[$pos], length($line[$pos])-3, 3) eq "nna")) {
								$line_type = "noun_ing";
								$line_type_actual = "i_am_noun_ing >> $pos >> $myline";
							} elsif ((substr($line[$pos], length($line[$pos])-1, 1) eq "d") || ($line[$pos] eq "never") || ($line[$pos] eq "not")) {
								$line_type = "i_am_ed";
								$line_type_actual = "i_am_ed >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_am_additional") {
							if ((substr($line[$pos], length($line[$pos])-3, 3) eq "ing") || (substr($line[$pos], length($line[$pos])-3, 3) eq "nna")) {
								$line_type = "noun_ing";
								$line_type_actual = "i_am_additional_noun_ing >> $pos >> $myline";
							} elsif ((substr($line[$pos], length($line[$pos])-1, 1) eq "d") || ($line[$pos] eq "never") || ($line[$pos] eq "not")) {
								$line_type = "i_am_additional_ed";
								$line_type_actual = "i_am_additional_ed >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_have") {
							if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun", 5)) {
								$line_type = "noun";
								$line_type_actual = "i_have_noun >> $pos >> $myline";
							} elsif ((substr($line[$pos], length($line[$pos])-1, 1) eq "d") || ($line[$pos] eq "never") || ($line[$pos] eq "not")) {
								$line_type = "i_not_have_am_ed";
								$line_type_actual = "i_not_have_am_ed >> $pos >> $myline";
							} else {
								$line_type = "noun";
								$line_type_actual = "i_have_am >> $pos >> $myline";
							}
						} elsif ($line_type eq "what_is") {
							if ((substr($line[$pos], length($line[$pos])-2, 2) eq "ed")) {
								$line_type = "what_is";
								$line_type_actual = "what_is >> $pos >> $myline";
							} else {
								$line_type = "noun";
								$line_type_actual = "1: noun_found >> $pos >> $myline";
							}
						} elsif ($line_type eq "verb_to") {
							$line_type = "verb";
							$line_type_actual = "verb_to >> $pos >> $myline";
						} elsif ($line_type eq "noun_to") {
							$line_type = "noun";
							$line_type_actual = "noun_to >> $pos >> $myline";
						} elsif ($line_type eq "could_i") {
							$line_type = "verb";
							$line_type_actual = "could_i >> $pos >> $myline";
						}
					}
				}

				if (($pos >= 0) && $line_type eq "unknown") {
					if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
						$line_type = "verb";
						$line_type_actual = "verb_found >> $pos >> $myline";
					} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun", 5)) {
						$line_type = "noun";
						$line_type_actual = "2: noun_found >> $pos >> $myline";
					}
				}

				if ($pos == (scalar @line)) {
					$line_type = "unattached";
					$line_type_actual = "unattached >> $pos >> $myline";
				}

				if (($pos >= 3) && $line_type eq "unknown") {
					if (defined $$meaning_args{"pre"}{"noun"}{$line[$pos-2]} && $line[$pos-1] ne "to") {
						if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
							$line_type = "verb";
							$line_type_actual = "noun-present_verb >> $pos >> $myline";
						} else {
							$line_type = "noun";
							$line_type_actual = "noun-noun >> $pos >> $myline";
						}
					}
				}

				if (($pos >= 2) && $line_type eq "unknown") {
					if (defined $$meaning_args{"pre"}{"when_norm"}{$line[$pos-2]}) {
						$line_type = "when_norm";
						$line_type_actual = "when_norm >> $pos >> $myline";
					}
				}

				if (($pos >= 1) && $line_type eq "unknown") {
					if ((defined $$meaning_args{"pre"}{"got"}{$line[$pos-1]} && SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "past_verb", 5))) {
						$line_type = "got";
						$line_type_actual = "got >> $pos >> $myline";
					} elsif (defined $$meaning_args{"pre"}{"noun"}{$line[$pos-1]}) {
						if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
							$line_type = "verb";
							$line_type_actual = "noun-present_verb >> $pos >> $myline";
						} else {
							$line_type = "noun";
							$line_type_actual = "noun-present_verb-noun >> $pos >> $myline";
						}
					} elsif (defined $$meaning_args{"pre"}{"verb"}{$line[$pos-1]}) {
						$line_type = "verb";
						$line_type_actual = "verb_actual >> $pos >> $myline";
					}
				}

				if (($pos >= 0) && $line_type eq "unknown") {
					if (defined $$meaning_args{"pre"}{"i_am_additional"}{$line[$pos-1]}) {
						if ((substr($line[$pos], length($line[$pos])-3, 3) eq "ing") || (substr($line[$pos], length($line[$pos])-3, 3) eq "nna")) {
							$line_type = "noun_ing";
							$line_type_actual = "i_am_additional_noun_ing >> $pos >> $myline";
						} elsif ((substr($line[$pos], length($line[$pos])-1, 1) eq "d") || ($line[$pos] eq "never") || ($line[$pos] eq "not")) {
							$line_type = "i_am_additional_ed";
							$line_type_actual = "i_am_additional_ed >> $pos >> $myline";
						} else {
							$line_type = "i_have_am";
							$line_type_actual = "i_am_additional >> $pos >> $myline";
						}
					} elsif (defined $$meaning_args{"pre"}{"when_is_additional"}{$line[$pos-1]}) {
						$line_type = "when_is";
						$line_type_actual = "when_is_additional >> $pos >> $myline";
					} elsif (defined $$meaning_args{"pre"}{"when_are_additional"}{$line[$pos-1]}) {
						$line_type = "when_are";
						$line_type_actual = "when_are_additional >> $pos >> $myline";
					}
				}

				if ($line_type eq "unknown" || $line_type eq "unattached") {
					if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, 0, "present_verb", 5)) {
						$line_type = "verb";
						$line_type_actual = "verb_start >> $pos >> $myline";
					} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, 0, "noun", 5)) {
						$line_type = "noun";
						$line_type_actual = "noun_start >> $pos >> $myline";
					} elsif (substr($line[$pos], length($line[$pos])-3, 3) eq "ing") {
						$line_type = "noun_ing";
						$line_type_actual = "noun_ing >> $pos >> $myline";
					}
				}

				if (($line_type eq "unknown") && ($save_noun ne "")) {
					$line_type = "noun";
					$line_type_actual = "noun_save >> $pos >> $myline";
				}
			}

			if ($$general_args{"main_language"} eq "es-us") {
				if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
					$build_string = ReplaceMy($$general_args{"main_language"}, " mi", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " una", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " un", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " la", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " el", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " las", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " los", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " sus", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " su", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " nuestras", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " nuestros", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " nuestra", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " nuestro", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " vuestras", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " vuestros", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " vuestra", $build_string);
					$build_string = ReplaceMy($$general_args{"main_language"}, " vuestro", $build_string);
				}

# Try to determine what type of sentence it is, based on word sequence patterns

				if ($pos >= 1) {
					if ($line_type eq "unknown") {
						$comp_line = "";
						for ($i = 0; $i <= $pos; $i++) {
						  $comp_line = stringBuilder($comp_line, $line[$i], " ");
						}

						$max_word = -9999;
						$min_word = 9999;
						$save_noun = "";
						foreach $elem ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}}) {
							if (($elem =~ /_esus/) && ($elem !~ /unknown/) && ($elem !~ /filler_/) && ($elem !~ /unless/) && ($elem !~ /pass/) && ($elem !~ /combo_/)) {
								foreach $elem1 ( sort { $a cmp $b } keys %{$$meaning_args{"pre"}{$elem}}) {
									$addin = "";
									$elem1_q = quotemeta($elem1);

									if ($elem1 eq $elem1_q) {
										$addin = " ";
									}

									if ($comp_line =~ /\b$elem1_q$addin/) {
										($first_word, @rest) = split " ", $elem1;
										$first_word_index = index($myline, $first_word);
										$temp = scalar(@rest)-1;

										if ($temp == -1) {
											$last_word = $first_word;
											$last_word_index = $first_word_index;
										} else {
											$last_word = $rest[scalar(@rest)-1];
											$last_word_index = index($myline, $last_word);
										}

										if ($first_word_index <= $min_word && $last_word_index >= $max_word) {
											if ($elem eq "noun_esus") {
												if (($pos < 3) || ($first_word_index < 3)) {
													$save_noun = "$elem";
													next;
												}
											}

											$min_word = $first_word_index;
											$max_word = $last_word_index;
											$line_type = "$elem";
											$line_type_actual = "$elem >> $pos >> $myline";
										}
									}
								}
							}
						}

						if ($line_type eq "iwant_esus") {
							if ((substr($line[$pos], length($line[$pos])-2, 2) eq "ar") || (substr($line[$pos], length($line[$pos])-2, 2) eq "er") || (substr($line[$pos], length($line[$pos])-2, 2) eq "ir")) {
								$line_type = "verb_esus";
								$line_type_actual = "verb_i_want >> $pos >> $myline";
							} else {
								$line_type = "noun_esus";
								$line_type_actual = "noun_i_want >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_am_esus") {
							if (substr($line[$pos], length($line[$pos])-4, 4) eq "ando") {
								$line_type = "noun_ing_esus";
								$line_type_actual = "i_am_noun_ing >> $pos >> $myline";
							} elsif (substr($line[$pos], length($line[$pos])-4, 4) eq "endo") {
								$line_type = "noun_ing_esus";
								$line_type_actual = "i_am_noun_ing >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_tengo_have_esus") {
							if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun_esus", 5)) {
								$line_type = "noun_esus";
								$line_type_actual = "i_have_noun >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_reflexive_have_he_esus") {
							if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "past_verb_esus", 5)) {
								$line_type = "i_have_reflexive_am_esus";
								$line_type_actual = "i_have_reflexive_he >> $pos >> $myline";
							}
						} elsif ($line_type eq "i_he_have_esus") {
							if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "past_verb_esus", 5)) {
								$line_type = "i_have_am_esus";
								$line_type_actual = "i_have_he >> $pos >> $myline";
							}
						} elsif ($line_type eq "what_is_esus") {
							if ((substr($line[$pos], length($line[$pos])-3, 3) eq "ado") || (substr($line[$pos], length($line[$pos])-3, 3) eq "ido")) {
								$line_type = "what_is_esus";
								$line_type_actual = "what_is >> $pos >> $myline";
							} else {
								$line_type = "noun_esus";
								$line_type_actual = "3: noun_found >> $pos >> $myline";
							}
						}
					}
				}

				if (($pos >= 0) && $line_type eq "unknown") {
					if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb_esus", 5)) {
						$line_type = "verb_esus";
						$line_type_actual = "verb_found >> $pos >> $myline";
					} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun_esus", 5)) {
						$line_type = "noun_esus";
						$line_type_actual = "4: noun_found >> $pos >> $myline";
					}
				}

				if ($pos == (scalar @line)) {
					$line_type = "unattached";
					$line_type_actual = "unattached >> $pos >> $myline";
				}

				if (($pos >= 3) && $line_type eq "unknown") {
					if (defined $$meaning_args{"pre"}{"noun_esus"}{$line[$pos-2]} && $line[$pos-1] ne "to") {
						if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
							$line_type = "verb_esus";
							$line_type_actual = "noun-present_verb >> $pos >> $myline";
						} else {
							$line_type = "noun_esus";
							$line_type_actual = "noun-noun >> $pos >> $myline";
						}
					}
				}

				if (($pos >= 1) && $line_type eq "unknown") {
					if (defined $$meaning_args{"pre"}{"noun_esus"}{$line[$pos-1]}) {
						if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
							$line_type = "verb_esus";
							$line_type_actual = "noun-present_verb >> $pos >> $myline";
						} else {
							$line_type = "noun_esus";
							$line_type_actual = "noun-present_verb-noun >> $pos >> $myline";
						}
					} elsif (defined $$meaning_args{"pre"}{"verb_esus"}{$line[$pos-1]}) {
						$line_type = "verb_esus";
						$line_type_actual = "verb_actual >> $pos >> $myline";
					}
				}

				if ($line_type eq "unknown" || $line_type eq "unattached") {
					if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, 0, "present_verb_esus", 5)) {
						$line_type = "verb_esus";
						$line_type_actual = "verb_start >> $pos >> $myline";
					} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, 0, "noun_esus", 5)) {
						$line_type = "noun_esus";
						$line_type_actual = "noun_start >> $pos >> $myline";
					}
				}

				if (($line_type eq "unknown") && ($save_noun ne "")) {
					$line_type = "noun_esus";
					$line_type_actual = "noun_save >> $pos >> $myline";
				}
			}
		}

		if (($pos >= 0) && $line_type eq "unknown") {
			if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
				if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb", 5)) {
					$line_type = "verb";
					$line_type_actual = "verb_found >> $pos >> $myline";
				} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun", 5)) {
					$line_type = "noun";
					$line_type_actual = "5: noun_found >> $pos >> $myline";
				}
			} elsif ($$general_args{"main_language"} eq "es-us") {
				if (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "present_verb_esus", 5)) {
					$line_type = "verb_esus";
					$line_type_actual = "verb_found >> $pos >> $myline";
				} elsif (SearchAppHash ($$general_args{"main_language"}, \@line, $app_hash, $pos, "noun_esus", 5)) {
					$line_type = "noun_esus";
					$line_type_actual = "6: noun_found >> $pos >> $myline";
				}
			}
		}

		if (($line_type ne "unknown") && ($line_type ne "unattached") && ($build_string ne "")) {
			$build_string =~ s/\ba a\b/a/g;
			$build_string =~ s/\bi i\b/i/g;
			$$pre_phrases_hash{$line_type}{$build_string}++;
			$repeat_hash_pre{$myline} = "pre,$line_type,$line_type_actual,$build_string,".$line[$pos];
		}

		if ($line_type eq "unattached") {
			$repeat_hash_grammar{$myline} = "unattached,$line_type,$line_type_actual,$build_string,".$line[$pos];
			if ($build_string ne "") {
				if ($do_filtercorpus_direct) {
					$$gram_elem_cat_hash{$build_string} = $item_category;
				}

				$$grammar_elems_other{$line_type}{$build_string}++;
			}
		} else {
			$temp_line = "";
			for ($i = $pos; $i < (scalar @line); $i++) {
				$temp_word = $line[$i];
				$temp_word = ChopChar($temp_word);

				$temp_line = stringBuilder($temp_line, $temp_word, " ");
			}

			if ($temp_line ne "") {
# ATTENTION2
				if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
					$temp_line =~ s/please|thank you|thanks//g;
				} elsif ($$general_args{"main_language"} eq "es-us") {
					$temp_line =~ s/por favor|muchas gracias|gracias//g;
				}

				$skip = 0;
				if (!$skip) {

					if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
						$temp_line = SimpleReplaceMy ($$general_args{"main_language"}, $temp_line);
					}
				}

				if ((($build_string ne "") || ($line_type ne "unknown"))) {
					$$grammar_elems{$line_type}{$temp_line}++;
					if ($do_filtercorpus_direct) {
						$$gram_elem_cat_hash{$temp_line} = $item_category;
					}
					$first_word_hash{$line_type}{$line[$pos]}++;
					$repeat_hash_grammar{$myline} = "grammar,$line_type,$line_type_actual,$temp_line,".$line[$pos];
				} else {
					$$grammar_elems_other{$line_type}{$temp_line}++;
					if ($do_filtercorpus_direct) {
						$$gram_elem_cat_hash{$temp_line} = $item_category;
					}
					$grammar_elems_no_pre_first_word{$temp_line} = $line[$pos];
					$repeat_hash_grammar{$myline} = "grammar_other,$line_type,$line_type_actual,$temp_line,".$line[$pos];
				}
			}
		}

		if (($build_string ne "") && ($line_type eq "unknown")) {
			$line_type_actual = "unknown_with_build >> $pos >> $myline";
			$build_string =~ s/\ba a\b/a/g;
			$build_string =~ s/\bi i\b/i/g;
			$$pre_phrases_hash{"unknown"}{$build_string}++;
			$repeat_hash_pre{$myline} = "unknown,$line_type,$line_type_actual,$build_string,".$line[$pos];

			if ($$general_args{"downcase_utt"}) {
				$myline = lc($myline);
			}

			if ($do_filtercorpus_direct) {
				$$gram_elem_cat_hash{$myline} = $item_category;
			}

			$$grammar_elems_other{"full"}{$myline}++;
			$repeat_hash_grammar{$myline} = "unknown,$line_type,$line_type_actual,$temp_line,".$pos;
		}

		DebugPrint ("", 1, "AssignLineType ", $debug, $err_no++, "2: line_type_actual = $line_type_actual\n\n");

		if ($mycorpus_filename eq "STDIN") {
			foreach $elem ( sort { $a cmp $b } keys %{ $grammar_elems }) {
				foreach $elem1 ( sort { $a cmp $b } keys %{ $$grammar_elems{$elem} }) {
					delete $$grammar_elems{$elem}{$elem1};
				}
			}

			foreach $elem ( sort { $a cmp $b } keys %{ $grammar_elems_other }) {
				foreach $elem1 ( sort { $a cmp $b } keys %{ $$grammar_elems_other{$elem} }) {
					delete $$grammar_elems_other{$elem}{$elem1};
				}
			}
		}

	}
}

sub FillFilterArrays
{

    my($general_args, $meaning_args, $osr_args, $app_hash) = @_;

	my(@app_noun_array);
	my(@app_past_verb_array);
	my(@app_present_verb_array);
	my(@app_present_additional_verb_array);
	my(@pre_app_specific_array);
	my(@pre_array);
	my(@temp_array);
	my(@unless_before_array);
	my(@unless_after_array);
	my($elem);
	my($strlen);
	my($temp_item);
	my($temp_string_before);
	my($temp_string_after);
	my($temp_string);
	my(%stop_exclude_hash);

	if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb") || ($$general_args{"main_language"} eq "all"))  {
		@app_present_verb_array = split / /, $$meaning_args{"app_present_verbs"};
		foreach (@app_present_verb_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
					$temp_item = $_;
					$temp_item =~ s/_/ /g;
					push @{$$osr_args{"training_fragment_items"}}, $temp_item;
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
					push @{$$osr_args{"training_fragment_items"}}, $temp_string;
				} else {
					$temp_array[0] = $_;
					push @{$$osr_args{"training_fragment_items"}}, $_;
				}

				foreach $elem (@temp_array) {
				  $stop_exclude_hash{$elem}++;
				}


				$$meaning_args{"pre"}{"pass_first"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$temp_string}++;
					$$app_hash{"present_verb_$strlen"}{$temp_string}++;
				} else {
					s/_/ /g;

					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$_}++;
					$$app_hash{"present_verb_$strlen"}{$_}++;
				}
			}
		}

		@app_past_verb_array = split / /, $$meaning_args{"app_past_verbs"};
		foreach (@app_past_verb_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
				} else {
					$temp_array[0] = $_;
				}

				foreach $elem (@temp_array) {
				  $stop_exclude_hash{$elem}++;
				}

				$$meaning_args{"pre"}{"pass_first"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$temp_string}++;
					$$app_hash{"past_verb_$strlen"}{$temp_string}++;
				} else {
					s/_/ /g;

					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$_}++;
					$$app_hash{"past_verb_$strlen"}{$_}++;
				}
			}
		}

		@app_noun_array = split / /, $$meaning_args{"app_nouns"};
		foreach (@app_noun_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
					$temp_item = $_;
					$temp_item =~ s/_/ /g;
					push @{$$osr_args{"training_fragment_items"}}, $temp_item;
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
					push @{$$osr_args{"training_fragment_items"}}, $temp_string;
				} else {
					$temp_array[0] = $_;
					push @{$$osr_args{"training_fragment_items"}}, $_;
				}

				foreach $elem (@temp_array) {
				  $stop_exclude_hash{$elem}++;
				}

				$$meaning_args{"pre"}{"pass_first"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$temp_string}++;
					$$app_hash{"noun_$strlen"}{$temp_string}++;
				} else {
					s/_/ /g;

					$$meaning_args{"pre"}{"pass"}{$temp_array[0]}{$_}++;
					$$app_hash{"noun_$strlen"}{$_}++;
				}
			}
		}

		@pre_app_specific_array = split / /, $$meaning_args{"pre_app_specific_string"};
		foreach (@pre_app_specific_array) {
			if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
				(@temp_array) = split "_";
				$$meaning_args{"pre"}{"combo_first"}{$temp_array[0]}++;
				s/_/ /g;

				$$meaning_args{"pre"}{"combo"}{$temp_array[0]}{$_}++;
				push @{$$osr_args{"training_stem_items"}}, $_;
			} else {
				s/\=//g;
				if (index($_,"!") != -1) {
					s/\(|\)|\[|\]//g;
					(@temp_array) = split /\!/;
					@unless_before_array = split /\|/, $temp_array[0];
					@unless_after_array = split /\|/, $temp_array[1];

#					foreach $temp_string_before (@unless_before_array) {
#						$$meaning_args{"pre"}{"unless_first"}{$temp_string_before}++;
#						foreach $temp_string_after (@unless_after_array) {
#							$$meaning_args{"pre"}{"unless"}{$temp_string_before}{$temp_string_before." ".$temp_string_after}++;
#						}
#					}

					foreach $temp_string_before (@unless_before_array) {
					    $$meaning_args{"pre"}{"unless_first"}{$temp_string_before}++;
					    if ($$general_args{"grammar_type"} eq "NUANCE9") {
						if ($temp_string_before ne "___twm___") {
						    if (index($temp_string_before,"_") == -1) {
							$temp_item = $_;
							$temp_item =~ s/_/ /g;
							foreach $temp_string_after (@unless_after_array) {
							    push @{$$osr_args{"training_stem_items"}}, $temp_string_before." ".$temp_string_after;
							}
						    } else {
							$temp_item = $_;
							$temp_item =~ s/_/ /g;
							foreach $temp_string_after (@unless_after_array) {
							    push @{$$osr_args{"training_stem_items"}}, $temp_string_before." ".$temp_string_after;
							}
						    }
						}
					    }

					    foreach $temp_string_after (@unless_after_array) {
						$$meaning_args{"pre"}{"unless"}{$temp_string_before}{$temp_string_before." ".$temp_string_after}++;
					    }
					}
				} else {
				    $$meaning_args{"pre"}{"filler"}{$_}++;
				    push @{$$osr_args{"training_stem_items"}}, $_;
				}
			}
		}

		@pre_array = split / /, $$meaning_args{"pre_string"};
		foreach (@pre_array) {
			if (substr($_,0,1) eq "#") {
				next;
			}

			if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
				(@temp_array) = split "_";
				$$meaning_args{"pre"}{"combo_first"}{$temp_array[0]}++;
				s/_/ /g;

				$$meaning_args{"pre"}{"combo"}{$temp_array[0]}{$_}++;
			} else {
				s/\=//g;
				if (index($_,"!") != -1) {
					s/\(|\)|\[|\]//g;
					(@temp_array) = split /\!/;
					@unless_before_array = split /\|/, $temp_array[0];
					@unless_after_array = split /\|/, $temp_array[1];

					foreach $temp_string_before (@unless_before_array) {
						$$meaning_args{"pre"}{"unless_first"}{$temp_string_before}++;
						if ($$general_args{"grammar_type"} eq "NUANCE9") {
						  if ($temp_string_before ne "___twm___") {
							if (index($temp_string_before,"_") == -1) {
							  if (not defined $stop_exclude_hash{$temp_string_before}) {
								if ($temp_string_before ne "throatwarblermangrove") {
								  push @{$$osr_args{"training_stop_items"}}, $temp_string_before;
								}
							  }

							  $temp_item = $_;
							  $temp_item =~ s/_/ /g;
							  foreach $temp_string_after (@unless_after_array) {
								push @{$$osr_args{"training_fragment_items"}}, $temp_string_before." ".$temp_string_after;
							  }
							} else {
							  $temp_item = $_;
							  $temp_item =~ s/_/ /g;
							  foreach $temp_string_after (@unless_after_array) {
								push @{$$osr_args{"training_fragment_items"}}, $temp_string_before." ".$temp_string_after;
							  }
							}
						  }
						} else {
						  if ($temp_string_before ne "___twm___") {
							if (index($temp_string_before,"_") == -1) {
							  if (not defined $stop_exclude_hash{$temp_string_before}) {
								if ($temp_string_before ne "throatwarblermangrove") {
								  push @{$$osr_args{"training_stop_items"}}, $temp_string_before;
								}
							  }
							}
						  }
						}

						foreach $temp_string_after (@unless_after_array) {
							$$meaning_args{"pre"}{"unless"}{$temp_string_before}{$temp_string_before." ".$temp_string_after}++;
						}
					}
				} else {
					if ($$general_args{"grammar_type"} eq "NUANCE9") {
					  if ($_ ne "___twm___") {
						if (index($_,"_") == -1) {
						  if (not defined $stop_exclude_hash{$_}) {
							if ($_ ne "throatwarblermangrove") {
							  push @{$$osr_args{"training_stop_items"}}, $_;
							}
						  }
						} else {
						  if (not defined $stop_exclude_hash{$_}) {
							$temp_item = $_;
#ATTENTION
#print "hereaaa111: temp_item=$temp_item\n";
#							$temp_item =~ s/_/ /g;
#print "hereaaa222: temp_item=$temp_item\n";
							push @{$$osr_args{"training_stop_items"}}, $temp_item;
						  }
						}
					  }
					} else {
					  if ($_ ne "___twm___") {
						if (index($_,"_") == -1) {
						  if (not defined $stop_exclude_hash{$_}) {
							if ($_ ne "throatwarblermangrove") {
							  push @{$$osr_args{"training_stop_items"}}, $_;
							}
						  }
						}
					  }
					}

					$$meaning_args{"pre"}{"filler"}{$_}++;
				}
			}
		}

		@pre_array = split / /, "a about an at call concerning discuss do for get got have haven't hear in into it's like my need needed on onto our reach regards regarding see that's the through want wanted with your";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"noun"}{$_}++;
		}

		@pre_array = split / /, "connect_to connect_with connected_to do_to get_to go_to listen_to me_to speak_to need_to_speak_to speak_with talk_to talk_with transfer_to transferred";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"noun_to"}{$_}++;
		}

		@pre_array = split / /, "can can't cannot wanna could would must";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"verb"}{$_}++;
		}

		@pre_array = split / /, "able_to like_to would_like_ask_you_to would_like_to_ask_you_to need_to needed_to need_to_know_what_to_do_to want_to wanted_to wants_to would_like_to looking_to going_to trying_to hoping_to";

		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"verb_to"}{$_}++;
		}

		@pre_array = split / /, "am_i is_he is_she was_i was_he was_she";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"am_i"}{$_}++;
		}

		@pre_array = split / /, "are_we were_we are_you were_you are_they were_they";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"are_we"}{$_}++;
		}

		@pre_array = split / /, "i_am he_is i_was he_was she_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_am"}{$_}++;
		}

		@pre_array = split / /, "do_i_have does_he_have does_she_have do_we_have do_they_have did_i_have did_he_have did_she_have did_we_have did_they_have did_i_get did_he_get did_she_get did_we_get did_they_get";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"do_i_have_get"}{$_}++;
		}

		@pre_array = split / /, "do_you_have did_you_have did_you_get";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"do_you_have_get"}{$_}++;
		}

		@pre_array = split / /, "do_i does_he does_she do_we do_they did_i did_he did_she did_we did_they";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"do_i"}{$_}++;
		}

		@pre_array = split / /, "we_are they_are we_were they_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"we_are"}{$_}++;
		}

		@pre_array = split / /, "i'm he's she's";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_am_additional"}{$_}++;
		}

		@pre_array = split / /, "you're they're we're";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"we_are_additional"}{$_}++;
		}

		@pre_array = split / /, "i_have he_has she_has we_have they_have i_haven't i_havent he_hasn't she_hasn't we_haven't we_havent they_haven't i_had he_had she_had we_had they_had i_hadn't he_hadn't she_hadn't we_hadn't they_hadn't";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_have"}{$_}++;
		}

		@pre_array = split / /, "you_have you_haven't you_had you_hadn't";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"you_have"}{$_}++;
		}

		@pre_array = split / /, "have_you haven't_you have_i haven't_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"have_you"}{$_}++;
		}

		@pre_array = split / /, "how_much_will";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_will"}{$_}++;
		}

		@pre_array = split / /, "how_much_is";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_is"}{$_}++;
		}

		@pre_array = split / /, "how_much_can";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_can"}{$_}++;
		}

		@pre_array = split / /, "how_much_have";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_have"}{$_}++;
		}

		@pre_array = split / /, "how_much_has";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_has"}{$_}++;
		}

		@pre_array = split / /, "how_much_does";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_does"}{$_}++;
		}

		@pre_array = split / /, "how_much_do";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_do"}{$_}++;
		}

		@pre_array = split / /, "is_there was_there";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"is_there"}{$_}++;
		}

		@pre_array = split / /, "are_there were_there";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"are_there"}{$_}++;
		}

		@pre_array = split / /, "could_you can_you would_you will_you do_you did_you";

		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"could_you"}{$_}++;
		}

		@pre_array = split / /, "can_i can_someone can_somebody can_we can_he can_she may_i may_we could_i could_we could_he could_she would_i would_we would_he would_she will_i will_we will_he will_she";

		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"could_i"}{$_}++;
		}

		@pre_array = split / /, "when";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_norm"}{$_}++;
		}

		@pre_array = split / /, "when_is when_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_is"}{$_}++;
		}

		@pre_array = split / /, "when_are when_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_are"}{$_}++;
		}

		@pre_array = split / /, "who_is who_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"who_is"}{$_}++;
		}

		@pre_array = split / /, "who_are who_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"who_are"}{$_}++;
		}

		@pre_array = split / /, "when_will_i when_would_i when_can_i when_could_i when_should_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_will_i"}{$_}++;
		}

		@pre_array = split / /, "when_will when_would when_can when_could when_should";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_will"}{$_}++;
		}

		@pre_array = split / /, "where_is where_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"where_is"}{$_}++;
		}

		@pre_array = split / /, "where_are where_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"where_are"}{$_}++;
		}

		@pre_array = split / /, "when's";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_is_additional"}{$_}++;
		}

		@pre_array = split / /, "when're";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_are_additional"}{$_}++;
		}

		@pre_array = split / /, "what_is what_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"what_is"}{$_}++;
		}

		@pre_array = split / /, "what_are what_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"what_are"}{$_}++;
		}

		@pre_array = split / /, "which_is which_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"which_is"}{$_}++;
		}

		@pre_array = split / /, "which_are which_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"which_are"}{$_}++;
		}

		@pre_array = split / /, "why_is why_was";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_is"}{$_}++;
		}

		@pre_array = split / /, "why_has";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_has"}{$_}++;
		}

		@pre_array = split / /, "why_am_i why_was_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_am_i"}{$_}++;
		}

		@pre_array = split / /, "why_are why_were";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_are"}{$_}++;
		}

		@pre_array = split / /, "got get";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"got"}{$_}++;
		}

		@pre_array = split / /, "how_could_i how_can_i how_do_i how_may_i how_would_i how_will_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_could_i"}{$_}++;
		}

		@pre_array = split / /, "what_could_i what_can_i what_do_i what_may_i what_would_i what_will_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"what_could_i"}{$_}++;
		}

		@pre_array = split / /, "when_could_i when_can_i when_do_i when_may_i when_would_i when_will_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_could_i"}{$_}++;
		}

		@pre_array = split / /, "where_could_i where_can_i where_do_i where_may_i where_would_i where_will_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"where_could_i"}{$_}++;
		}
	}
#
# --------------- Spanish US - start ------------------
#

	if (($$general_args{"main_language"} eq "es-us") || ($$general_args{"main_language"} eq "all"))  {
		@app_present_verb_array = split / /, $$meaning_args{"app_present_verbs_esus"};
		foreach (@app_present_verb_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
				} else {
					$temp_array[0] = $_;
				}

				$$meaning_args{"pre"}{"pass_first_esus"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$app_hash{"present_verb_esus_$strlen"}{$temp_string}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$temp_string}++;
				} else {
					s/_/ /g;

					$$app_hash{"present_verb_esus_$strlen"}{$_}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$_}++;
				}
			}
		}

		@app_present_additional_verb_array = split / /, $$meaning_args{"app_present_additional_verbs_esus"};
		foreach (@app_present_additional_verb_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
				} else {
					$temp_array[0] = $_;
				}

				$$meaning_args{"pre"}{"pass_first_esus"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$app_hash{"present_additional_verb_esus_$strlen"}{$temp_string}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$temp_string}++;
				} else {
					s/_/ /g;

					$$app_hash{"present_additional_verb_esus_$strlen"}{$_}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$_}++;
				}
			}
		}

		@app_past_verb_array = split / /, $$meaning_args{"app_past_verbs_esus"};
		foreach (@app_past_verb_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
				} else {
					$temp_array[0] = $_;
				}

				$$meaning_args{"pre"}{"pass_first_esus"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$app_hash{"past_verb_esus_$strlen"}{$temp_string}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$temp_string}++;
				} else {
					s/_/ /g;

					$$app_hash{"past_verb_esus_$strlen"}{$_}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$_}++;
				}
			}
		}

		@app_noun_array = split / /, $$meaning_args{"app_nouns_esus"};
		foreach (@app_noun_array) {
			if ($_ ne "") {
				if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
					(@temp_array) = split "_";
				} elsif (index($_,"=") != -1) {
					$temp_string = $_;
					$temp_string =~ s/\=/ /g;
					$temp_string = TrimChars($temp_string);
					(@temp_array) = split " ", $temp_string;
				} else {
					$temp_array[0] = $_;
				}

				$$meaning_args{"pre"}{"pass_first_esus"}{$temp_array[0]}++;
				$strlen = (scalar @temp_array);
				if ($_ =~ /\=/) {
					$$app_hash{"noun_esus_$strlen"}{$temp_string}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$temp_string}++;
				} else {
					s/_/ /g;

					$$app_hash{"noun_esus_$strlen"}{$_}++;
					$$meaning_args{"pre"}{"pass_esus"}{$temp_array[0]}{$_}++;
				}
			}
		}

		@pre_app_specific_array = split / /, $$meaning_args{"pre_app_specific_string_esus"};
		foreach (@pre_app_specific_array) {
			if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
				(@temp_array) = split "_";
				$$meaning_args{"pre"}{"combo_first_esus"}{$temp_array[0]}++;
				s/_/ /g;

				$$meaning_args{"pre"}{"combo_esus"}{$temp_array[0]}{$_}++;
			} else {
				s/\=//g;
				if (index($_,"!") != -1) {
					(@temp_array) = split /\!/;
					@unless_before_array = split /\|/, $temp_array[0];
					@unless_after_array = split /\|/, $temp_array[1];

					foreach $temp_string_before (@unless_before_array) {
						$$meaning_args{"pre"}{"unless_first_esus"}{$temp_string_before}++;
						foreach $temp_string_after (@unless_after_array) {
							$$meaning_args{"pre"}{"unless_esus"}{$temp_string_before}{$temp_string_before." ".$temp_string_after}++;
						}
					}
				} else {
					$$meaning_args{"pre"}{"filler_esus"}{$_}++;
				}
			}
		}

		@pre_array = split / /, $$meaning_args{"pre_string_esus"};
		foreach (@pre_array) {
			if (substr($_,0,1) eq "#") {
				next;
			}

			if ((index($_,"_") != -1) && (index($_,"=") == -1)) {
				(@temp_array) = split "_";
				$$meaning_args{"pre"}{"combo_first_esus"}{$temp_array[0]}++;
				s/_/ /g;

				$$meaning_args{"pre"}{"combo_esus"}{$temp_array[0]}{$_}++;
			} else {
				s/\=//g;
				if (index($_,"!") != -1) {
					(@temp_array) = split /\!/;
					@unless_before_array = split /\|/, $temp_array[0];
					@unless_after_array = split /\|/, $temp_array[1];

					foreach $temp_string_before (@unless_before_array) {
						$$meaning_args{"pre"}{"unless_first_esus"}{$temp_string_before}++;
						if (index($temp_string_before,"_") == -1) {
						  if ($temp_string_before ne "throatwarblermangrove") {
							push @{$$osr_args{"training_stop_items"}}, $temp_string_before;
						  }
						}
						foreach $temp_string_after (@unless_after_array) {
							$$meaning_args{"pre"}{"unless_esus"}{$temp_string_before}{$temp_string_before." ".$temp_string_after}++;
						}
					}
				} else {
					if (index($_,"_") == -1) {
					  if ($_ ne "throatwarblermangrove") {
						push @{$$osr_args{"training_stop_items"}}, $_;
					  }
					}

					$$meaning_args{"pre"}{"filler_esus"}{$_}++;
				}
			}
		}

		@pre_array = split / /, "hacia la el las los sobre acerca a por para en esto esta este como mi necesito necesita necesitamos necesitaba nuestro nuestra nuestros nuestras eso ese esa con tu tus vuestra vuestras vuestro vuestros su sus";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"noun_esus"}{$_}++;
		}

		@pre_array = split / /, "conecta_a conecta_con conectado_a hace_a alcanza_a va_a escucha_a habla_a habla_con transfere_a transferido";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"noun_to_esus"}{$_}++;
		}

#	@pre_array = split / /, "acabo_de necesito necesita necesitamos necesito_que necesita_que necesitamos_que puedo puede podemos puedo_que puede_que podemos_que quiero quiere queremos quiero_que quiere_que queremos_que podria podriamos podria_que podriamos_que debo debe debemos debo_que debe_que debemos_que deberia deberiamos deberia_que deberiamos_que no_puedo no_puede no_podemos no_puedo_que no_puede_que no_podemos_que no_quiero no_quiere no_queremos no_quiero_que no_quiere_que no_queremos_que no_podria no_podriamos no_podria_que no_podriamos_que no_debo no_debe no_debemos no_debo_que no_debe_que no_debemos_que no_deberia no_deberiamos no_deberia_que no_deberiamos_que";
		@pre_array = split / /, "necesito necesita necesitamos necesitan puedo puede podemos pueden quiero quiere queremos quieren podria podriamos podrian debo debe debemos deben deberia deberiamos deberia";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"iwant_esus"}{$_}++;
		}

		@pre_array = split / /, "acabo_de acaba_de acabamos_de acaban_de cómo_puedo";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"verb_esus"}{$_}++;
		}

		@pre_array = split / /, "me_acabo_de le_acaba_de la_acaba_de nos_acabamos_de les_acaban_de las_acaban_de";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"verb_reflexive_esus"}{$_}++;
		}

		@pre_array = split / /, "me_dijo_que me_dijeron_que necesito_que necesita_que necesitamos_que puedo_que puede_que podemos_que quiero_que quiere_que queremos_que podria_que podriamos_que podrian_que debo_que debe_que debemos_que deben_que deberia_que deberiamos_que deberian_que no_puedo_que no_puede_que no_podemos_que no_pueden_que no_quiero_que no_quiere_que no_queremos_que no_quieren_que no_podria_que no_podriamos_que no_podrian_que no_debo_que no_debe_que no_debemos_que no_deben_que no_deberia_que no_deberiamos_que no_deberian_que tengo_que tiene_que tenemos_que tienen_que me_dijeron_que_necesito_que me_dijo_que_necesito_que";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"verb_que_esus"}{$_}++;
		}

		@pre_array = split / /, "está están";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"it_is_esus"}{$_}++;
		}

		@pre_array = split / /, "estoy estamos soy somos";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_am_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_am_additional_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"am_i_esus"}{$_}++;
		}

		@pre_array = split / /, "tengo_para tiene_para tenemos_para tienen_para tenia_para teniamos_para tenian_para no_tengo_para no_tiene_para no_tenemos_para no_tienen_para no_tenia_para no_teniamos_para no_tenian_para";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_tengo_para_esus"}{$_}++;
		}

		@pre_array = split / /, "tengo_que tiene_que tenemos_que tienen_que tenia_que teniamos_que tenian_que no_tengo_que no_tiene_que no_tenemos_que no_tienen_que no_tenia_que no_teniamos_que no_tenian_que";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_tengo_que_esus"}{$_}++;
		}

		@pre_array = split / /, "tengo tiene tenemos tienen tenia teniamos tenian no_tengo no_tiene no_tenemos no_tienen no_tenia no_teniamos no_tenian";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_tengo_have_esus"}{$_}++;
		}

		@pre_array = split / /, "he ha hemos han";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_he_have_esus"}{$_}++;
		}

		@pre_array = split / /, "me_he se_ha nos_hemos se_han";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"i_reflexive_have_he_esus"}{$_}++;
		}

		@pre_array = split / /, "cuándo";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_norm_esus"}{$_}++;
		}

		@pre_array = split / /, "cuándo_está cuándo_es cuándo_estuvo cuándo_fue cuándo_estaba";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_is_esus"}{$_}++;
		}

		@pre_array = split / /, "cuándo_están cuándo_son cuándo_estuvieron cuándo_fueron cuándo_estaban";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_are_esus"}{$_}++;
		}

		@pre_array = split / /, "tienes tenis no_tienes no_tenis";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"you_have_esus"}{$_}++;
		}

		@pre_array = split / /, "cuánto_cuesta";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_is_esus"}{$_}++;
		}

		@pre_array = split / /, "cuántos_cuestan";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_much_are_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";

		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"could_you_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";

		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"could_i_esus"}{$_}++;
		}

		@pre_array = split / /, "quién_es quién_fue quien_es quien_fue";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"who_is_esus"}{$_}++;
		}

		@pre_array = split / /, "quienes_son quienes_fueron";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"who_are_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm"; #when_will_i when_would_i when_can_i when_could_i when_should_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_will_i_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm"; #when_will when_would when_can when_could when_should";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_will_esus"}{$_}++;
		}

#íáñúéóú
		@pre_array = split / /, "dónde_está dónde_estuvo";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"where_is_esus"}{$_}++;
		}

		@pre_array = split / /, "dónde_están dónde_estuvieron";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"where_are_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_is_additional_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"when_are_additional_esus"}{$_}++;
		}

		@pre_array = split / /, "qué_es qué_fue";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"what_is_esus"}{$_}++;
		}

		@pre_array = split / /, "qué_son qué_fueron";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"what_are_esus"}{$_}++;
		}

		@pre_array = split / /, "cuál_es cuál_fue cual_es cual_fue";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"which_is_esus"}{$_}++;
		}

		@pre_array = split / /, "cuáles_son cuáles_fueron";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"which_are_esus"}{$_}++;
		}

		@pre_array = split / /, "por_qué_está por_qué_estuvo";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_is_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm"; #why_am_i why_was_i";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_am_i_esus"}{$_}++;
		}

		@pre_array = split / /, "por_qué_están por_qué_estuvieron";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"why_are_esus"}{$_}++;
		}

		@pre_array = split / /, "ahhmmmm"; #got get";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"got_esus"}{$_}++;
		}

		@pre_array = split / /, "cómo_podria";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"how_could_i_esus"}{$_}++;
		}

		@pre_array = split / /, "por_cuál_razón";
		foreach (@pre_array) {
			if ($_ =~ /\=/) {
				s/\=//g;
			} else {
				s/_/ /g;
			}

			$$meaning_args{"pre"}{"is_there_esus"}{$_}++;
		}

#
# --------------- Spanish US - end ------------------
#
	}

}

sub Write_FilterCorpus_all {

    my($filtercorpusfileout, $main_language, $grammar_type, $pre_phrases_array, $grammar_elems_array, $grammar_elems_other_array, $freq, $pre_hash, $put_in_full_pre_phrases, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name) = @_;

	my($combo_sentences) = "";
	my($combo_cats) = "";
	my($elem);
	my($my_elem);
	my($temp_sentences) = "";
	my($temp_cats) = "";

# Unclassified Phrases:
	($temp_sentences, $temp_cats) = Write_FilterCorpus_Fileout_minus ($filtercorpusfileout, $grammar_type, $grammar_elems_other_array, "full", 0, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name);
	$combo_sentences = $combo_sentences.$temp_sentences;
	$combo_cats = $combo_cats.$temp_cats;

#Phrases with no prefix:
	($temp_sentences, $temp_cats) = Write_FilterCorpus_Fileout_minus ($filtercorpusfileout, $grammar_type, $grammar_elems_other_array, "unknown", $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name);
	$combo_sentences = $combo_sentences.$temp_sentences;
	$combo_cats = $combo_cats.$temp_cats;

# Unattached Phrases:
	($temp_sentences, $temp_cats) = Write_FilterCorpus_Fileout_minus ($filtercorpusfileout, $grammar_type, $grammar_elems_other_array, "unattached", $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name);
	$combo_sentences = $combo_sentences.$temp_sentences;
	$combo_cats = $combo_cats.$temp_cats;

	foreach $elem ( sort { $a cmp $b } keys %{$pre_phrases_array}) {
		if (($elem !~ /filler/) && ($elem !~ /combo/) && ($elem !~ /noun/) && ($elem !~ /verb/) && ($elem ne "unknown") && ($elem ne "unless") && ($elem ne "i_am") && ($elem ne "am_i")) {
			$my_elem = "";

			if ($grammar_type eq "NUANCE_GSL") {
				if ($elem =~ /(you_have|i_have|i_tengo_have|when_norm|when_is|when_are|who_is|who_are|where_is|where_are|what_are|which_are|why_is|why_are)/) {
					$my_elem = "MY";

					if ($main_language eq "es-us") {
						$my_elem = "MI";
					}
				}
			}

			($temp_sentences, $temp_cats) = Write_FilterCorpus_Fileout ($grammar_type, $filtercorpusfileout, $pre_phrases_array, $grammar_elems_array, "$elem", "$my_elem", $freq, $pre_hash, $put_in_full_pre_phrases, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name);
			$combo_sentences = $combo_sentences.$temp_sentences;
			$combo_cats = $combo_cats.$temp_cats;
		} elsif (($elem eq "noun") || ($elem eq "noun_ing") || ($elem eq "verb")) {
			$my_elem = "";

			if ($grammar_type eq "NUANCE_GSL") {
				if ($elem =~ /(\bnoun\b)/) {
					$my_elem = "MY";

					if ($main_language eq "es-us") {
						$my_elem = "MI";
					}
				}
			}

			($temp_sentences, $temp_cats) = Write_FilterCorpus_Fileout ($grammar_type, $filtercorpusfileout, $pre_phrases_array, $grammar_elems_array, "$elem", "$my_elem", $freq, $pre_hash, 0, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name);
			$combo_sentences = $combo_sentences.$temp_sentences;
			$combo_cats = $combo_cats.$temp_cats;
		}
	}

	return($combo_sentences, $combo_cats);
}

sub Write_FilterCorpus_Fileout {

    my($grammar_type, $filtercorpusfileout, $pre_phrases_array, $grammar_elems_array, $gram_array_type, $insert_word, $freq, $pre_hash, $put_in_full_pre_phrases, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name) = @_;

	my($combo_sentences) = "";
	my($combo_cats) = "";
	my($elem);
	my($grammar_items);
	my($pre_phrases);
	my($temp_word);
	my($temp_word1);
	my($temp_word2);
	my($temp_word3);
	my($temp_insert_word) = " ";
	my($item_category);
	my(@rest);

	if ($insert_word ne "") {
		$temp_insert_word = " ".$insert_word." ";
	}

	if ($put_in_full_pre_phrases) {
		foreach $elem ( sort { $a cmp $b } keys %{$$pre_hash{$gram_array_type}}) {
			$$pre_phrases_array{$gram_array_type}{$elem}++;
		}
	}

	foreach $pre_phrases ( sort { $$pre_phrases_array{$gram_array_type}{$b} <=> $$pre_phrases_array{$gram_array_type}{$a} } keys %{$$pre_phrases_array{$gram_array_type}}) {
		if ($$pre_phrases_array{$gram_array_type}{$pre_phrases} > $freq) {
			$temp_word = $pre_phrases;
			$temp_word =~ s/_/ /g;
			$temp_word =~ s/\?/ /g;

			foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
				if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {

					$temp_word1 = $grammar_items;

					$temp_word1 =~ s/_/ /g;
					$temp_word1 =~ s/\?//g;

					$temp_word2 = $temp_word." ".$temp_insert_word." $temp_word1";
					$temp_word2 = TrimChars($temp_word2);

					if ($insert_word ne "") {
						$temp_word2 =~ s/\b$insert_word $insert_word\b/$insert_word/g;
					}

					$temp_word1 = TrimChars($temp_word1);
					$temp_word2 = TrimChars($temp_word2);

					$temp_word1 =~ s/\b(my|a|an|the|our|her|his) MY\b/MY/g;
					$temp_word1 =~ s/\b(mi|mis|tu|tus|una|un|la|el|sus|su|nuestras|nuestros|nuestra|nuestro) MI\b/MI/g;

					$temp_word2 =~ s/\b(my|a|an|the|our|her|his) MY\b/MY/g;
					$temp_word2 =~ s/\b(mi|mis|tu|tus|una|un|la|el|sus|su|nuestras|nuestros|nuestra|nuestro) MI\b/MI/g;

					if ($do_filtercorpus_direct) {
						$temp_word3 = $$gram_elem_cat_hash{$grammar_items};
						($item_category,@rest) = split ":", $temp_word3;
						$item_category = NormCat($item_category, $test_reject_name);
						print $filtercorpusfileout "FILTER\t$temp_word2\t$item_category\n";
						print $filtercorpusfileout "FILTER\t$temp_word1\t$item_category\n";
						$combo_sentences = $combo_sentences.$temp_word1."º".$temp_word2."º";
						$combo_cats = $combo_cats.$item_category."º".$item_category."º";
					} else {
						print $filtercorpusfileout "FILTER\t$temp_word2\n";
						print $filtercorpusfileout "FILTER\t$temp_word1\n";
						$combo_sentences = $combo_sentences.$temp_word1."º".$temp_word2."º";
					}
				}
			}
		}
	}

	return($combo_sentences, $combo_cats);
}

sub Write_FilterCorpus_Fileout_minus {

    my($filtercorpusfileout, $grammar_type, $grammar_elems_array, $gram_array_type, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $test_reject_name) = @_;

	my($combo_sentences) = "";
	my($combo_cats) = "";
	my($grammar_items);
	my($temp_word);
	my($temp_word1);
	my($item_category);
	my(@rest);

	foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
		if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
			$temp_word = $grammar_items;
			$temp_word =~ s/_/ /g;
			$temp_word =~ s/\?//g;

			if ($do_filtercorpus_direct) {
				$temp_word1 = $$gram_elem_cat_hash{$grammar_items};
				($item_category,@rest) = split ":", $temp_word1;
				$item_category = NormCat($item_category, $test_reject_name);
				print $filtercorpusfileout "FILTER\t$temp_word\t$item_category\n";
				$combo_sentences = $combo_sentences.$temp_word."º";
				$combo_cats = $combo_cats.$item_category."º";
			} else {
				print $filtercorpusfileout "FILTER\t$temp_word\n";
				$combo_sentences = $combo_sentences.$temp_word."º";
			}
		}
	}

	return($combo_sentences, $combo_cats);
}

sub MakeFilterCorpus
{
	my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $combo_sentences, $filter_file_written, $write_filter_grammars, $mygrammar_suffix, $mycorpus_filename, $debug, $app_hash, $freq, $do_filtercorpus_direct, $put_in_full_pre_phrases, $gram_elem_cat_hash, $multiplier, $myfiltercorpusfileout, $grammar_elems, $grammar_elems_other, $original_cat_array, $original_transcription_array, $original_wavfile_array, $corrected_array, $contains_categories, $max_sentence_length, $compressed_already_hash) = @_;

	my($combo_cats) = "";
	my($elem);
	my($i);
	my($item_category);
	my($myfiltergrammarfileout);
	my($sentence);
	my($sentence_length);
	my($sentence_order) = 0;
	my($sentence_order_counter) = 0;
	my($temp_corrected_sentence);
	my($temp_sentence_order_counter);
	my($temp_sentences) = "";
	my($temp_cats) = "";
	my($use_confirm_as);
	my($use_slot_name);
	my(@cat_array);
	my(@sentence_array);
	my(%pre_phrases_hash);

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
	  $myfiltergrammarfileout = $$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_corpus_direct".$$general_args{"language_suffix"}.".grammar";
	  $use_slot_name = $$meaning_args{"slotname"};
	  $use_confirm_as = $$meaning_args{"confirm_as"};
	} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
	  $myfiltergrammarfileout = $$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_corpus_direct".$$general_args{"language_suffix"}.".grxml";
	  $use_slot_name = $$meaning_args{"slotname_nuance_speakfreely"};
	  $use_confirm_as = $$meaning_args{"confirm_as_nuance_speakfreely"};
	}

	if ($corrected_array ne "") {
		$sentence_order_counter = scalar(@$corrected_array);
		$sentence_order = 0;
		$item_category = "";

		foreach $sentence (@$corrected_array) {
			$temp_corrected_sentence = $sentence;
			$temp_corrected_sentence =~ s/ //g;
			$sentence_length = length($sentence) - length($temp_corrected_sentence) + 1;
			if ($sentence_length <= $max_sentence_length) {
				if ($contains_categories) {
					$item_category = @$original_cat_array[$sentence_order];
				}

				AssignLineType($general_args, $meaning_args, $wordnet_args, $sentence, "$item_category:".$$meaning_args{"slotname"}.":".$$meaning_args{"confirm_as"}.":".$$meaning_args{"slotname_nuance_speakfreely"}.":".$$meaning_args{"confirm_as_nuance_speakfreely"}, "", $debug, $app_hash, \%pre_phrases_hash, $grammar_elems, $grammar_elems_other, $do_filtercorpus_direct, $gram_elem_cat_hash);

				$sentence_order++;
			}
		}
	} else {
		open(CORPUS,"<$mycorpus_filename") or die "cant open $mycorpus_filename";

		while (<CORPUS>) {
			AssignLineType($general_args, $meaning_args, $wordnet_args, $_, "", $mycorpus_filename, $debug, $app_hash, \%pre_phrases_hash, $grammar_elems, $grammar_elems_other, $do_filtercorpus_direct, $gram_elem_cat_hash);
		}
	}

####### Write FILTERCORPUSFILEOUT file #######

	if ($filter_file_written == 0) {
		open(FILTERCORPUSFILEOUT,">$myfiltercorpusfileout") or die "cant write FILTERCORPUSFILEOUT";

		for ($i = 0; $i < $multiplier; $i++) {
			($temp_sentences, $temp_cats) = Write_FilterCorpus_all (\*FILTERCORPUSFILEOUT, $$general_args{"main_language"}, $$general_args{"grammar_type"}, \%pre_phrases_hash, $grammar_elems, $grammar_elems_other, $freq, $$meaning_args{"pre"}, $put_in_full_pre_phrases, $do_filtercorpus_direct, $gram_elem_cat_hash, $$meaning_args{"reject_name"});
			$combo_sentences = $combo_sentences.$temp_sentences;
			if ($contains_categories) {
				$combo_cats = $combo_cats.$temp_cats;
			}
		}

		$temp_sentence_order_counter = $sentence_order_counter;
		@sentence_array = split /\º/, $combo_sentences;
		foreach $elem (@sentence_array) {
		  @$original_transcription_array[$sentence_order_counter] = $elem;
		  @$original_wavfile_array[$sentence_order_counter] = "FILTERCORPUS";
		  $sentence_order_counter++;
		}

		if ($contains_categories) {
		  $sentence_order_counter = $temp_sentence_order_counter;
		  @cat_array = split /\º/, $combo_cats;

		  foreach $elem (@cat_array) {
			@$original_cat_array[$sentence_order_counter] = $elem;
			$sentence_order_counter++;
		  }
		}

		close(FILTERCORPUSFILEOUT);

		$filter_file_written = 1;
	}

	if ($write_filter_grammars) {

####### Write GRAMMAR_OUT file #######
		Write_SubGrammars_Out ($general_args, "$mygrammar_suffix", $myfiltergrammarfileout, \%pre_phrases_hash, $grammar_elems, $grammar_elems_other, $use_slot_name, $use_confirm_as);

		Write_Grammar_Out_all ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, "$mygrammar_suffix", $debug, $myfiltergrammarfileout, \%pre_phrases_hash, $grammar_elems, $grammar_elems_other, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);
	}

	return ($filter_file_written, $combo_sentences);
}

sub GetMeaning_filtercorpus {

    my($grammar_type, $myhash, $lineHshRef, $gram_elem_cat_hash, $test_reject_name) = @_;

	my($freq) = 0;
	my($items);
	my($temp_word);
	my($temp_word1);

	my($item_category);
	my($test_slotname);
	my($test_confirm_as);
	my($test_slotname_nuance_speakfreely);
	my($test_confirm_as_nuance_speakfreely);

	undef %$lineHshRef;

	foreach ( sort { $$myhash{$b} <=> $$myhash{$a} } keys %{$myhash}) {
		$items = $_;
		$temp_word1 = $items;
		$temp_word1 =~ s/_/ /g;
		if ($$myhash{$items} > $freq) {
			$temp_word = $$gram_elem_cat_hash{$items};
			($item_category,$test_slotname,$test_confirm_as,$test_slotname_nuance_speakfreely,$test_confirm_as_nuance_speakfreely) = split ":", $temp_word;
			$item_category = NormCat($item_category, $test_reject_name);
			if ($grammar_type eq "NUANCE_GSL") {
				$$lineHshRef{$temp_word1} = "<$test_slotname \"$item_category\">\t<$test_confirm_as \"$item_category\">";
			} elsif (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
				$$lineHshRef{$temp_word1} = "<tag>$test_slotname_nuance_speakfreely=\'$item_category\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'$item_category\'</tag>\n"
			}
		}
	}
}


############# END FILTERCORPUS Processing SUBROUTINES ################

######################################################################
######################################################################
############# Translation SUBROUTINES ################################
######################################################################
######################################################################

sub FillTranslateHash
{
   my($trans_file, $trans_hash) = @_;

   my($line);
   my($eng_sent);
   my(@other_sent_original_array);
   my(@other_sent_array);
   my($other_sent);
   my($elem);
   my(@cat_temp_word_array);

   open(TRANSIN,"<$trans_file") or die "cant open $trans_file";
   while(<TRANSIN>) {
	   $line = ChopChar($_);

	   if ($line eq "") {
		   next;
	   }

	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   ($eng_sent, @other_sent_original_array) = split "\t", $line;

	   foreach $elem (@other_sent_original_array) {
		   if ($elem eq "") {
			   next;
		   }

		   (@cat_temp_word_array) = split " ", $elem;

		   if (index($elem, "/") != -1) {
			   ExpandSentence ("/", \@cat_temp_word_array, \@other_sent_array);
		   } else {
			   push @other_sent_array, $elem;
		   }
	   }

	   foreach $other_sent (@other_sent_array) {
		   $$trans_hash{$eng_sent}{$other_sent}++;
	   }

	   @other_sent_array = ();
	   @other_sent_original_array = ();
	   @cat_temp_word_array = ();

   }

   close(TRANSIN);
}

sub TransCatList
{
   my($general_args, $trans_file, $trans_hash, $cat_sentence_file_in, $eng_rules, $old_rules_file, $do_tagsdirect) = @_;

   my($cat_confirm_as);
   my($cat_neg);
   my($cat_nl_rules_lineout);
   my($cat_plus_conf);
   my($cat_shift);
   my($cat_title);
   my($elem);
   my($elem1);
   my($eng_rules_found) = 1;
   my($eng_sent);
   my($err_found) = 0;
   my($firstchar);
   my($item_category);
   my($line);
   my($old_rules_found) = 1;
   my($temp_elem);
   my($translated_sentences_found) = 0;
   my(%cat_sent_hash);
   my(%old_rules_sentences);
   my(%sent_hash);
   my(@eng_rules_contents);
   my(@old_rules_contents);

   FillTranslateHash($trans_file, $trans_hash);

   open(SENTCATIN,"<$cat_sentence_file_in") or die "cant open $cat_sentence_file_in";

   if ($eng_rules ne "") {
	   unless (open(RULESIN,"<$eng_rules")) {
		   $eng_rules_found = 0;

		   DebugPrint ("BOTH", 2, "TransCatList", $debug, $err_no++, "Can't find $eng_rules!");
	   }
   } else {
	   $eng_rules_found = 0;
   }

   if ($eng_rules_found) {
	   (@eng_rules_contents) = (<RULESIN>);
   }

   if ($old_rules_file ne "") {
	   unless (open(OLDRULESIN,"<$old_rules_file")) {
		   $old_rules_found = 0;

		   DebugPrint ("BOTH", 2, "TransCatList", $debug, $err_no++, "Can't find $old_rules_file!");
	   }
   } else {
	   $old_rules_found = 0;
   }

   if ($old_rules_found) {
	   (@old_rules_contents) = (<OLDRULESIN>);
   }

   if ($$general_args{"main_language"} eq "es-us") {
	   if ($eng_rules_found || $old_rules_found) {
		   open(CATOUT,">"."slmdirect_results\/esus_rules_container_template_from_enus") or die "cant open "."slmdirect_results\/esus_rules_container_template_from_enus";
		   print CATOUT "\# Rule Container Format:\n";
		   print CATOUT "\#\tCategory_Name[,Category_Confirm_As,Category_Title_Out,Category_Negation]:Rule_Definition_LINE\n";
		   print CATOUT "\#\t\t(If Category_Name contains \'slmp_external\', then Rule will be External (ER)).\n\n";
		   print CATOUT "\#\t\t(If Category_Name contains \'slmp_general\', then Rule will be General (GR)).\n\n";
	   }

	   open(ERRORNOTRANS,">"."slmdirect_results\/createslmDIR_info_files\/warning_no_translation_esus") or die "cant open "."slmdirect_results\/createslmDIR_info_files\/warning_no_translation_esus";

	   if (!$do_tagsdirect) {
		   open(SENTOUT,">"."slmdirect_results\/createslm_init_sentences_esus") or die "cant open "."slmdirect_results\/createslm_init_sentences_esus";
	   }

	   while(<SENTCATIN>) {

		   $line = $_;

		   $line = ChopChar($line);

		   if ($line eq "") {
			   next;
		   }

		   if (substr($line,0,1) eq "#") {
			   next;
		   }

		   ($eng_sent, $item_category) = split "\t", $line;
		   $item_category = NormCat($item_category, $$general_args{"test_reject_name"});

		   if (scalar keys %{$$trans_hash{$eng_sent}} == 0) {
			   $err_found = 1;
			   print ERRORNOTRANS "$eng_sent\n";
		   }

		   foreach $elem ( sort { $a cmp $b } keys %{$$trans_hash{$eng_sent}}) {
			   $temp_elem = TrimChars($elem);

			   if (!$do_tagsdirect) {
				   if (scalar keys %{$$trans_hash{$temp_elem}} != 0) {
					   $translated_sentences_found = 1;
					   foreach $elem1 ( sort { $a cmp $b } keys %{$$trans_hash{$temp_elem}}) {
						   $sent_hash{$elem1}{$item_category}++;
					   }
				   }
			   }

			   $cat_sent_hash{$item_category}{$temp_elem."\t[$eng_sent]"}++;
		   }
	   }

	   foreach $elem ( sort { $a cmp $b } keys %sent_hash) {
		   if ($elem eq "") {
			   next;
		   }

		   print SENTOUT "$elem\n";
	   }

	   if ($old_rules_found) {
		   $cat_shift = "";
		   $line = shift @old_rules_contents;
		   while (scalar @old_rules_contents > 0) {

			   ($line, $firstchar) = ProcessCharsPlus($line);

			   if ($line eq "") {
				   $line = shift @old_rules_contents;
				   next;
			   }

			   if (substr($line,0,1) eq "#") {
				   $line =~ s/\#//;
				   $line = TrimChars($line);
				   $old_rules_sentences{$line}++;
				   $line = shift @old_rules_contents;
				   next;
			   }

			   ($cat_plus_conf, $cat_nl_rules_lineout) = split ":", $line;
			   ($item_category, $cat_confirm_as, $cat_title, $cat_neg) = split ",", $cat_plus_conf;
			   if ($$general_args{"downcase_utt"}) {
				   $cat_nl_rules_lineout = lc($cat_nl_rules_lineout);
			   }

			   $item_category = NormCat($item_category, $$general_args{"test_reject_name"});
			   $cat_confirm_as = NormCat($cat_confirm_as, $$general_args{"test_reject_name"});
			   $cat_title = NormCat($cat_title, $$general_args{"test_reject_name"});

			   if ($cat_title eq "") {
				   $cat_title = $cat_confirm_as;
			   }

			   if ($cat_title eq "") {
				   $cat_title = $item_category;
			   }

			   if ($cat_shift ne $cat_title) {
				   $cat_shift = $cat_title;
				   print CATOUT "\n\n";
				   foreach $elem ( sort { $a cmp $b } keys %{ $cat_sent_hash{$cat_title} }) {
					   if (defined $old_rules_sentences{$elem}) {
						   print CATOUT "\#", "$elem\n";
					   } else {
						   print CATOUT "\#>>>NEW: ", "$elem\n";
					   }
				   }
			   }

			   print CATOUT "$line\n";
			   $line = shift @old_rules_contents;
		   }
	   } elsif ($eng_rules_found) {
		   $cat_shift = "";
		   $line = shift @eng_rules_contents;
		   while (scalar @eng_rules_contents > 0) {

			   ($line, $firstchar) = ProcessCharsPlus($line);

			   if ($line eq "") {
				   $line = shift @eng_rules_contents;
				   next;
			   }

			   if (substr($line,0,1) eq "#") {
				   $line =~ s/\#//;
				   $line = TrimChars($line);
				   $old_rules_sentences{$line}++;
				   $line = shift @eng_rules_contents;
				   next;
			   }

			   ($cat_plus_conf, $cat_nl_rules_lineout) = split ":", $line;
			   ($item_category, $cat_confirm_as, $cat_title, $cat_neg) = split ",", $cat_plus_conf;
			   if ($$general_args{"downcase_utt"}) {
				   $cat_nl_rules_lineout = lc($cat_nl_rules_lineout);
			   }

			   $item_category = NormCat($item_category, $$general_args{"test_reject_name"});
			   $cat_confirm_as = NormCat($cat_confirm_as, $$general_args{"test_reject_name"});
			   $cat_title = NormCat($cat_title, $$general_args{"test_reject_name"});

			   if ($cat_title eq "") {
				   $cat_title = $cat_confirm_as;
			   }

			   if ($cat_title eq "") {
				   $cat_title = $item_category;
			   }

			   if ($cat_shift ne $cat_title) {
				   $cat_shift = $cat_title;
				   print CATOUT "\n\n";
				   foreach $elem ( sort { $a cmp $b } keys %{ $cat_sent_hash{$cat_title} }) {
					   if (defined $old_rules_sentences{$elem}) {
						   print CATOUT "\#", "$elem\n";
					   } else {
						   print CATOUT "\#>>>NEW: ", "$elem\n";
					   }
				   }
			   }

			   $line =~ s/_alias/_esus_alias/g;

			   print CATOUT "$line\n";
			   $line = shift @eng_rules_contents;
		   }
	   }

	   close(CATOUT);
	   close(ERRORNOTRANS);
	   close(SENTOUT);

	   if ($err_found) {
		   DebugPrint ("BOTH", 2, "TransCatList", $debug, $err_no++, "UNTRANSLATED SENTENCES: in "."slmdirect_results\/createslmDIR_info_files\/warning_no_translation_esus");
	   } else {
		   unlink "slmdirect_results\/createslmDIR_info_files\/warning_no_translation_esus";
	   }

	   if ($translated_sentences_found) {
		   DebugPrint ("BOTH", 1, "TransCatList", $debug, $err_no++, "File created: "."slmdirect_results\/createslm_init_sentences_esus");
	   }

	   if ($eng_rules_found || $old_rules_found) {
		   DebugPrint ("BOTH", 1, "TransCatList", $debug, $err_no++, "File created: "."slmdirect_results\/esus_rules_container_template_from_enus");
	   }
   }
}

sub CheckCats
{
   my($input_files, $test_reject_name) = @_;

   my($elem);
   my($elem1);
   my($elem2);
   my($elem3);
   my($eng_file);
   my($eng_sent);
   my($item_category);
   my($line);
   my($other_file);
   my($other_item_category);
   my($other_sent);
   my($temp_elem);
   my($trans_file);
   my(%eng_hash);
   my(%other_hash);
   my(%trans_hash_eng);
   my(%trans_hash_other);
   my(@cat_temp_word_array);
   my(@other_sent_array);
   my(@other_sent_original_array);

   ($trans_file, $eng_file, $other_file) = split ":", $input_files;

   open(TRANSIN,"<$trans_file") or die "cant open $trans_file";
   while(<TRANSIN>) {

	   $line = $_;

	   $line = ChopChar($line);

	   if ($line eq "") {
		   next;
	   }

	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   ($eng_sent, @other_sent_original_array) = split "\t", $line;

	   foreach $elem (@other_sent_original_array) {
		   if ($elem eq "") {
			   next;
		   }

		   (@cat_temp_word_array) = split " ", $elem;

		   if (index($elem, "/") != -1) {
			   ExpandSentence ("/", \@cat_temp_word_array, \@other_sent_array);
		   } else {
			   push @other_sent_array, $elem;
		   }
	   }

	   foreach $other_sent (@other_sent_array) {
		   $trans_hash_eng{$eng_sent}{$other_sent}++;
		   $trans_hash_other{$other_sent}{$eng_sent}++;
	   }

	   @other_sent_array = ();

   }

   open(ENGIN,"<$eng_file") or die "cant open $eng_file";
   while(<ENGIN>) {

	   $line = $_;

	   $line = ChopChar($line);

	   if ($line eq "") {
		   next;
	   }

	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   ($eng_sent, $item_category) = split "\t", $line;
	   $item_category = NormCat($item_category, $test_reject_name);

	   $eng_hash{$eng_sent}{$item_category}++;
   }

   open(OTHERIN,"<$other_file") or die "cant open $other_file";
   while(<OTHERIN>) {

	   $line = $_;

	   $line = ChopChar($line);

	   if ($line eq "") {
		   next;
	   }

	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   ($other_sent, $other_item_category) = split "\t", $line;

	   $other_hash{$other_sent}{$other_item_category}++;
   }

   close(TRANSIN);
   close(ENGIN);
   close(OTHERIN);


   foreach $elem ( sort { $a cmp $b } keys %trans_hash_eng) {
	   foreach $elem1 ( sort { $a cmp $b } keys %{$trans_hash_eng{$elem}}) {
		   foreach $elem2 ( sort { $a cmp $b } keys %{$eng_hash{$elem}}) {
			   if (not defined $other_hash{$elem1}{$elem2}) {
				   $temp_elem = $elem1;
				   $temp_elem =~ s/\bmis\b/MI/g;
				   $temp_elem =~ s/\bmi\b/MI/g;
				   $temp_elem =~ s/\btus\b/MI/g;
				   $temp_elem =~ s/\btu\b/MI/g;
				   $temp_elem =~ s/\buna\b/MI/g;
				   $temp_elem =~ s/\bun\b/MI/g;
				   $temp_elem =~ s/\bla\b/MI/g;
				   $temp_elem =~ s/\bel\b/MI/g;
				   $temp_elem =~ s/\blas\b/MI/g;
				   $temp_elem =~ s/\blos\b/MI/g;
				   $temp_elem =~ s/\bsu\b/MI/g;
				   $temp_elem =~ s/\bsus\b/MI/g;
				   $temp_elem =~ s/\bnuestra\b/MI/g;
				   $temp_elem =~ s/\bnuestro\b/MI/g;
				   $temp_elem =~ s/\bnuestras\b/MI/g;
				   $temp_elem =~ s/\bnuestros\b/MI/g;
				   $temp_elem =~ s/\bvuestra\b/MI/g;
				   $temp_elem =~ s/\bvuestro\b/MI/g;
				   $temp_elem =~ s/\bvuestras\b/MI/g;
				   $temp_elem =~ s/\bvuestros\b/MI/g;

				   if (not defined $other_hash{$temp_elem}{$elem2}) {
					   DebugPrint ("", 1, "CheckCats ", $debug-1, $err_no++, "ERROR: ENG=$elem, OTHER=$elem1/$temp_elem, CAT_ENG=$elem2\n\n");
					   foreach $elem3 ( sort { $a cmp $b } keys %{$other_hash{$elem1}}) {
						   DebugPrint ("", 1, "CheckCats", $debug-1, $err_no++, "\t\tCAT_OTHER=$elem3\n\n");
					   }
				   }
			   }
		   }
	   }
   }
}

############# END Translation SUBROUTINES ############################

######################################################################
######################################################################
############# OUTPUT SUBROUTINES #####################################
######################################################################
######################################################################

sub SaveCleanSentence
{
  my($corrected_sentence) = @_;

  $corrected_sentence =~ s/\ª//g;
  $corrected_sentence =~ s/\º/\n/g;
  $corrected_sentence = $corrected_sentence."\n";

  open(NEWPARSEFILE,">"."slmdirect_results\/createslmDIR_info_files\/info_clean_transcription_total") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_clean_transcription_total";
  print NEWPARSEFILE "$corrected_sentence\n";
  close(NEWPARSEFILE);
}

sub WriteMainGrammar
{
    my($main_language, $my_main_grammar_name, $my_ngram, $grammarbase, $my_nl_total_processed, $my_nl_contains_product_total, $my_filter_corpus) = @_;

#hereqaz222: indent candidate
	open(MAINGRAMMAR,">"."slmdirect_results\/$grammarbase"."_nuance_gsl_top.grammar") or die "cant write MAINGRAMMAR";

	if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
		if (!($my_filter_corpus)) {
			print MAINGRAMMAR "MY [my a an the our her his]\n\n";
		}
	} elsif ($main_language eq "es-us") {
		if (!($my_filter_corpus)) {
			print MAINGRAMMAR "MI [mis mi tu tus un una la el las los su sus nuestro nuestra nuestros nuestras vuestro vuestra vuestros vuestras]\n\n";
		}
	}

	print MAINGRAMMAR "$my_main_grammar_name [\n";
	print MAINGRAMMAR "\tSLM_Grammar\n\n";

	if ($my_nl_contains_product_total > 0) {
		print MAINGRAMMAR "\t\t\t(\?UhUm\n";
		print MAINGRAMMAR "\t\t\t\t(SLMItems) \n\n";

		if ($my_filter_corpus) {
			print MAINGRAMMAR "\t\t\t)~", sprintf("%3.30f", 0.8*$my_nl_contains_product_total/$my_nl_total_processed), "\n\n";
		} else {
			print MAINGRAMMAR "\t\t\t)~", $my_nl_contains_product_total/$my_nl_total_processed, "\n\n";
		}
	}

	if ($my_filter_corpus) {
		print MAINGRAMMAR "\t\t\t(\?UhUm\n";
		print MAINGRAMMAR "\t\t\t\t(CorpusDirect) \n\n";
		print MAINGRAMMAR "\t\t\t)~", sprintf("%3.30f", 0.2*$my_nl_contains_product_total/$my_nl_total_processed), "\n\n";
	}

	print MAINGRAMMAR "]\n\n";

	print MAINGRAMMAR "SLM_Grammar:slm \"", $my_ngram, "\" = SLMInterpretationGrammar\n\n";

	print MAINGRAMMAR "UNK [ \@reject\@ ]\n\n";

	print MAINGRAMMAR "SLMInterpretationGrammar [\n";

	if ($my_nl_contains_product_total > 0) {
		if ($my_filter_corpus) {
			print MAINGRAMMAR "\t(SLMItems)~", sprintf("%3.30f", 0.8*$my_nl_contains_product_total/$my_nl_total_processed), "\n";
		} else {
			print MAINGRAMMAR "\t(SLMItems)~", $my_nl_contains_product_total/$my_nl_total_processed, "\n";
		}
	}

	if ($my_filter_corpus) {
		print MAINGRAMMAR "\t(CorpusDirect)~", sprintf("%3.30f", 0.2*$my_nl_contains_product_total/$my_nl_total_processed), "\n";
	}

	print MAINGRAMMAR "]\n";

	close(MAINGRAMMAR);
}

sub WriteMainGrammar_nuance_variant_xml
{
    my($main_language, $grammar_type, $my_main_grammar_name, $grammarbase, $my_nl_contains_product_total, $my_filter_corpus, $top_skip_hash, $tuning_version, $test_reject_name, $do_normal_slm, $do_robust_parsing) = @_;

    my($elem1);
	my($encoding) = setEncoding($main_language);
    my($loc_mygrammar_type);
	my($loopcnt);
	my($gramname);
	my($delete_str) = quotemeta("slmdirect_results\/createslmDIR_tuning_files\/grammars\/$tuning_version"."_");

	$loc_mygrammar_type = lc($grammar_type);

	if ($grammar_type eq "NUANCE_SPEAKFREELY") {
		if ($do_normal_slm) {
#hereqaz333: indent candidate
			open(MAINGRAMMAR,">".getOutEncoding($main_language, $grammar_type), "slmdirect_results\/$grammarbase"."_".$loc_mygrammar_type."_top.grxml") or die "cant write MAINGRAMMAR";

			print MAINGRAMMAR "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n",
			"\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"$main_language\" mode=\"voice\" root=\"ROOT\">\n\n",
			"\t<rule id=\"ROOT\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#$my_main_grammar_name\"/>\n",
			"\t\t\t<tag>SWI_meaning=$my_main_grammar_name.ITEM_NAME</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.ITEM_NAME) {ITEM_NAME=$my_main_grammar_name.ITEM_NAME}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFIRM_AS) {CONFIRM_AS=$my_main_grammar_name.CONFIRM_AS}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.AMBIG_KEY) {AMBIG_KEY=$my_main_grammar_name.AMBIG_KEY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CATEGORY) {CATEGORY=$my_main_grammar_name.CATEGORY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.LITERAL) {LITERAL=$my_main_grammar_name.LITERAL}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFVAL) {CONFVAL=$my_main_grammar_name.CONFVAL}</tag>\n",
			"\t\t<\/item>\n",
			"\t</rule>\n\n";

			print MAINGRAMMAR "<rule id=\"$my_main_grammar_name\">\n<one-of>\n";
		}

		if ($do_robust_parsing) {
#hereqaz444: indent candidate
			open(MAINGRAMMAR_ROBUST,">".getOutEncoding($main_language, $grammar_type), "slmdirect_results\/$grammarbase"."_".$loc_mygrammar_type."_robust_parsing_top.grxml") or die "cant write MAINGRAMMAR_ROBUST";

			print MAINGRAMMAR_ROBUST "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n",
			"\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"$main_language\" mode=\"voice\" root=\"ROOT\">\n\n",
			"\t<rule id=\"ROOT\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#$my_main_grammar_name\"/>\n",
			"\t\t\t<tag>SWI_meaning=$my_main_grammar_name.ITEM_NAME</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.ITEM_NAME) {ITEM_NAME=$my_main_grammar_name.ITEM_NAME}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFIRM_AS) {CONFIRM_AS=$my_main_grammar_name.CONFIRM_AS}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.AMBIG_KEY) {AMBIG_KEY=$my_main_grammar_name.AMBIG_KEY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CATEGORY) {CATEGORY=$my_main_grammar_name.CATEGORY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.LITERAL) {LITERAL=$my_main_grammar_name.LITERAL}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFVAL) {CONFVAL=$my_main_grammar_name.CONFVAL}</tag>\n",
			"\t\t<\/item>\n",
			"\t</rule>\n\n";

			print MAINGRAMMAR_ROBUST "<rule id=\"$my_main_grammar_name\">\n<one-of>\n";
		}

		if ($my_nl_contains_product_total > 0) {
			if ($do_robust_parsing) {
				$gramname = "$grammarbase"."_".$loc_mygrammar_type."_robust_parsing";

				if ($tuning_version ne "") {
					$gramname =~ s/$delete_str//g;
				}

				print MAINGRAMMAR_ROBUST "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.xml#concepts\"/>\n",
				"\t\t<tag>ITEM_NAME = concepts.ITEM_NAME</tag>\n",
				"\t\t<tag>CONFIRM_AS = concepts.CONFIRM_AS</tag>\n",
				"\t\t<tag>AMBIG_KEY = concepts.AMBIG_KEY</tag>\n",
				"\t\t<tag>CATEGORY = concepts.CATEGORY</tag>\n",
				"\t\t<tag>CONFVAL = concepts.CONFVAL</tag>\n",
				"\t\t<tag>LITERAL = concepts.LITERAL</tag>\n",
				"\t<\/item>\n";
			}

			if ($do_normal_slm) {
				$gramname = "$grammarbase"."_".$loc_mygrammar_type."_wrapper";

				if ($tuning_version ne "") {
					$gramname =~ s/$delete_str//g;
				}

				print MAINGRAMMAR "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.gram\"/>\n",
				"\t\t<tag>ITEM_NAME = ___ROOT___.ITEM_NAME</tag>\n",
				"\t\t<tag>CONFIRM_AS = ___ROOT___.CONFIRM_AS</tag>\n",
				"\t\t<tag>AMBIG_KEY= ___ROOT___.AMBIG_KEY</tag>\n",
				"\t\t<tag>CATEGORY = ___ROOT___.CATEGORY</tag>\n",
				"\t\t<tag>CONFVAL = ___ROOT___.CONFVAL</tag>\n",
				"\t\t<tag>LITERAL = ___ROOT___.LITERAL</tag>\n";

				if (1) {
					print MAINGRAMMAR "\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalHelp\.grxml#localHelp\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (localHelp.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(localHelp.SWI_MEANING) {SWI_MEANING=localHelp.SWI_MEANING};\n",
					"\t\t\tif(localHelp.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=localHelp.DM_CONFIRM_STRING};\n",
					"\t\t\tif(localHelp.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=localHelp.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_local_help=localHelp.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n",

					"\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalCommandsNoRep\.grxml#command\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (command.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(command.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=command.DM_CONFIRM_STRING};\n",
					"\t\t\tif(command.SWI_MEANING) {SWI_MEANING=command.SWI_MEANING};\n",
					"\t\t\tif(command.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=command.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_command=command.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n",

					"\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalCommandsRep\.grxml#command\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (command.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(command.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=command.DM_CONFIRM_STRING};\n",
					"\t\t\tif(command.SWI_MEANING) {SWI_MEANING=command.SWI_MEANING};\n",
					"\t\t\tif(command.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=command.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_root=command.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n";
				}

			}
		}

		if ($my_filter_corpus) {
			$gramname = "$grammarbase"."_".$loc_mygrammar_type."_nl_items";

			if ($tuning_version ne "") {
				$gramname =~ s/$delete_str//g;
			}

			if ($do_normal_slm) {
				print MAINGRAMMAR "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.grxml#CorpusDirect\"/>\n",
				"\t\t<tag>\"uni='ITEM_NAME=' + root.ITEM_NAME + 'CONFIRM_AS=' + root.CONFIRM_AS\"</tag>\n",
				"\t<\/item>\n";
			}

			if ($do_robust_parsing) {
				print MAINGRAMMAR_ROBUST "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.xml#CorpusDirect\"/>\n",
				"\t\t<tag>\"uni='ITEM_NAME=' + root.ITEM_NAME + 'CONFIRM_AS=' + root.CONFIRM_AS\"</tag>\n",
				"\t<\/item>\n";
			}
		}

		if ($do_normal_slm) {
			print MAINGRAMMAR "<\/one-of>\n<\/rule>\n\n";
			print MAINGRAMMAR "<\/grammar>\n";
		}

		if ($do_robust_parsing) {
			print MAINGRAMMAR_ROBUST "<\/one-of>\n<\/rule>\n\n";
			print MAINGRAMMAR_ROBUST "<\/grammar>\n";
		}

		close(MAINGRAMMAR);
		close(MAINGRAMMAR_ROBUST);
	}

	if ($grammar_type eq "NUANCE9") {
		if ($do_normal_slm) {
#hereqaz555: indent candidate
			open(MAINGRAMMAR,">".getOutEncoding($main_language, $grammar_type), "slmdirect_results\/$grammarbase"."_".$loc_mygrammar_type."_top.grxml") or die "cant write MAINGRAMMAR";

			print MAINGRAMMAR "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n",
			"\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"$main_language\" mode=\"voice\" root=\"ROOT\">\n\n",
			"\t<rule id=\"ROOT\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#$my_main_grammar_name\"/>\n",
			"\t\t\t<tag>SWI_meaning=$my_main_grammar_name.ITEM_NAME</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.ITEM_NAME) {ITEM_NAME=$my_main_grammar_name.ITEM_NAME}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFIRM_AS) {CONFIRM_AS=$my_main_grammar_name.CONFIRM_AS}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.AMBIG_KEY) {AMBIG_KEY=$my_main_grammar_name.AMBIG_KEY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CATEGORY) {CATEGORY=$my_main_grammar_name.CATEGORY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.LITERAL) {LITERAL=$my_main_grammar_name.LITERAL}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFVAL) {CONFVAL=$my_main_grammar_name.CONFVAL}</tag>\n",
			"\t\t<\/item>\n",
			"\t</rule>\n\n";

			print MAINGRAMMAR "<rule id=\"$my_main_grammar_name\">\n<one-of>\n";
		}

		if ($do_robust_parsing) {
#hereqaz666: indent candidate
			open(MAINGRAMMAR_ROBUST,">".getOutEncoding($main_language, $grammar_type), "slmdirect_results\/$grammarbase"."_".$loc_mygrammar_type."_robust_parsing_top.grxml") or die "cant write MAINGRAMMAR_ROBUST";

			print MAINGRAMMAR_ROBUST "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n",
			"\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"$main_language\" mode=\"voice\" root=\"ROOT\">\n\n",
			"\t<rule id=\"ROOT\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#$my_main_grammar_name\"/>\n",
			"\t\t\t<tag>SWI_meaning=$my_main_grammar_name.ITEM_NAME</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.ITEM_NAME) {ITEM_NAME=$my_main_grammar_name.ITEM_NAME}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFIRM_AS) {CONFIRM_AS=$my_main_grammar_name.CONFIRM_AS}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.AMBIG_KEY) {AMBIG_KEY=$my_main_grammar_name.AMBIG_KEY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CATEGORY) {CATEGORY=$my_main_grammar_name.CATEGORY}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.LITERAL) {LITERAL=$my_main_grammar_name.LITERAL}</tag>\n",
			"\t\t\t<tag>if($my_main_grammar_name.CONFVAL) {CONFVAL=$my_main_grammar_name.CONFVAL}</tag>\n",
			"\t\t<\/item>\n",
			"\t</rule>\n\n";

			print MAINGRAMMAR_ROBUST "<rule id=\"$my_main_grammar_name\">\n<one-of>\n";
		}

		if ($my_nl_contains_product_total > 0) {
			if ($do_robust_parsing) {
				$gramname = "$grammarbase"."_".$loc_mygrammar_type."_robust_parsing";

				if ($tuning_version ne "") {
					$gramname =~ s/$delete_str//g;
				}

				print MAINGRAMMAR_ROBUST "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.xml#concepts\"/>\n",
				"\t\t<tag>ITEM_NAME = concepts.ITEM_NAME</tag>\n",
				"\t\t<tag>CONFIRM_AS = concepts.CONFIRM_AS</tag>\n",
				"\t\t<tag>AMBIG_KEY = concepts.AMBIG_KEY</tag>\n",
				"\t\t<tag>CATEGORY = concepts.CATEGORY</tag>\n",
				"\t\t<tag>CONFVAL = concepts.CONFVAL</tag>\n",
				"\t\t<tag>LITERAL = concepts.LITERAL</tag>\n",
				"\t<\/item>\n";
			}

			if ($do_normal_slm) {
				$gramname = "$grammarbase"."_".$loc_mygrammar_type."_training";

				if ($tuning_version ne "") {
					$gramname =~ s/$delete_str//g;
				}

				print MAINGRAMMAR "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.gram\"/>\n",
				"\t\t<tag>ITEM_NAME = ___ROOT___.ITEM_NAME</tag>\n",
				"\t\t<tag>CONFIRM_AS = ___ROOT___.CONFIRM_AS</tag>\n",
				"\t\t<tag>AMBIG_KEY= ___ROOT___.AMBIG_KEY</tag>\n",
				"\t\t<tag>CATEGORY = ___ROOT___.CATEGORY</tag>\n",
				"\t\t<tag>CONFVAL = ___ROOT___.CONFVAL</tag>\n",
				"\t\t<tag>LITERAL = ___ROOT___.LITERAL</tag>\n";

				if ((scalar keys %{$top_skip_hash}) > 0) {
					print MAINGRAMMAR "\t\t<tag>\n",
					"<\![CDATA[",
					"\t\t\tvar test_literal = ___ROOT___.SWI_literal;\n",
					"\t\t\tvar LiteralSplit = test_literal.split(' ');\n";

					print MAINGRAMMAR "\t\t\tvar skip_list = \"";

					$loopcnt = 0;
					foreach $elem1 ( sort { $a cmp $b } keys %{$top_skip_hash}) {
						if (!$loopcnt) {
							print MAINGRAMMAR "$elem1";
							$loopcnt ++;
						} else {
							print MAINGRAMMAR "+", "$elem1";
							$loopcnt ++;
						}
					}

					print MAINGRAMMAR "\";\n";

					print MAINGRAMMAR "\t\t\tvar skip_cat = \"$test_reject_name\";\n",
					"\t\t\tvar disallow_arr = skip_list.split('+');\n",
					"\t\t\tvar i;\n",
					"\t\t\tvar j;\n",
					"\t\t\tvar valid_word_found;\n",

					"\t\t\tif (LiteralSplit.length == 1) {\n",
					"\t\t\t\tfor (i=disallow_arr.length-1; i > -1; i--) {\n",
					"\t\t\t\t\tif (LiteralSplit[0] == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tITEM_NAME = skip_cat;\n",
					"\t\t\t\t\t\tCATEGORY = skip_cat;\n",
					"\t\t\t\t\t\tCONFIRM_AS = skip_cat;\n",
					"\t\t\t\t\t\tCONFVAL = 1000;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t} else {\n",
					"\t\t\t\tvalid_word_found = 0;\n",
					"\t\t\t\tif (LiteralSplit.length < 5) {\n",
					"\t\t\t\t\tfor (i=LiteralSplit.length-1; i > -1; i--) {\n",
					"\t\t\t\t\t\tj = skip_list.search(LiteralSplit[i]);\n",
					"\t\t\t\t\t\tif (j == -1) {\n",
					"\t\t\t\t\t\t\tvalid_word_found = 1;\n",
					"\t\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t\t}\n",
					"\t\t\t\t\t}\n\n",
					"\t\t\t\t\tif (valid_word_found == 0) {\n",
					"\t\t\t\t\t\tITEM_NAME = skip_cat;\n",
					"\t\t\t\t\t\tCATEGORY = skip_cat;\n",
					"\t\t\t\t\t\tCONFIRM_AS = skip_cat;\n",
					"\t\t\t\t\t\tCONFVAL = 1000;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t]]>\n",
					"\t\t</tag>\n";

					print MAINGRAMMAR "\t</item>\n\n";

				}

				if (1) {
					print MAINGRAMMAR "\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalHelp\.grxml#localHelp\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (localHelp.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(localHelp.SWI_MEANING) {SWI_MEANING=localHelp.SWI_MEANING};\n",
					"\t\t\tif(localHelp.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=localHelp.DM_CONFIRM_STRING};\n",
					"\t\t\tif(localHelp.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=localHelp.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_local_help=localHelp.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n",

					"\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalCommandsNoRep\.grxml#command\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (command.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(command.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=command.DM_CONFIRM_STRING};\n",
					"\t\t\tif(command.SWI_MEANING) {SWI_MEANING=command.SWI_MEANING};\n",
					"\t\t\tif(command.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=command.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_command=command.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n",

					"\t<item weight = \"0.01\">\n",
					"\t\t<ruleref uri=\"./globalCommandsRep\.grxml#command\"/>\n",
					"\t\t<tag>\n",
					"\t\t\tif (SWI_vars.disallow) {\n",
					"\t\t\tvar disallow_arr = SWI_vars.disallow.split('+');\n",
					"\t\t\tdisallowList = SWI_vars.disallow;\n",
					"\t\t\t\tfor (var i=0; i \&lt; disallow_arr.length; i++) {\n",
					"\t\t\t\t\tif (command.SWI_MEANING == disallow_arr[i]) {\n",
					"\t\t\t\t\t\tSWI_disallow=1;\n",
					"\t\t\t\t\t\tbreak;\n",
					"\t\t\t\t\t}\n",
					"\t\t\t\t}\n",
					"\t\t\t}\n",
					"\t\t\tif(command.DM_CONFIRM_STRING) {DM_CONFIRM_STRING=command.DM_CONFIRM_STRING};\n",
					"\t\t\tif(command.SWI_MEANING) {SWI_MEANING=command.SWI_MEANING};\n",
					"\t\t\tif(command.DM_CONFIRMATION_MODE) {DM_CONFIRMATION_MODE=command.DM_CONFIRMATION_MODE};\n",
					"\t\t\tdm_root=command.SWI_MEANING;\n",
					"\t\t\tMEANING=SWI_MEANING;\n",
					"\t\t</tag>\n",
					"\t</item>\n\n";
				}
			}
		}

		if ($my_filter_corpus) {
			$gramname = "$grammarbase"."_".$loc_mygrammar_type."_nl_items";

			if ($tuning_version ne "") {
				$gramname =~ s/$delete_str//g;
			}

			if ($do_normal_slm) {
				print MAINGRAMMAR "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.grxml#CorpusDirect\"/>\n",
				"\t\t<tag>\"uni='ITEM_NAME=' + root.ITEM_NAME + 'CONFIRM_AS=' + root.CONFIRM_AS\"</tag>\n",
				"\t<\/item>\n";
			}

			if ($do_robust_parsing) {
				print MAINGRAMMAR_ROBUST "\t<item>\n",
				"\t\t<ruleref uri=\"./$gramname"."\.xml#CorpusDirect\"/>\n",
				"\t\t<tag>\"uni='ITEM_NAME=' + root.ITEM_NAME + 'CONFIRM_AS=' + root.CONFIRM_AS\"</tag>\n",
				"\t<\/item>\n";
			}
		}

		if ($do_normal_slm) {
			print MAINGRAMMAR "<\/one-of>\n<\/rule>\n\n";
			print MAINGRAMMAR "<\/grammar>\n";
		}

		if ($do_robust_parsing) {
			print MAINGRAMMAR_ROBUST "<\/one-of>\n<\/rule>\n\n";
			print MAINGRAMMAR_ROBUST "<\/grammar>\n";
		}

		close(MAINGRAMMAR);
		close(MAINGRAMMAR_ROBUST);
	}
}

sub Write_Grammar_Out {

    my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $grammar_out, $debug, $grammar_preamble, $pre_phrases_array, $grammar_elems_array, $gram_array_type, $insert_word, $insert_thanks, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash) = @_;

	my($at_least_one_found) = 0;
	my($grammar_items);
	my($meaning);
	my($pre_phrases);
	my($temp);
	my($temp_word);
	my($mytest_confirm_as);
	my(%lineHshRef);

	$debug = 1;

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
	  $mytest_confirm_as = $$meaning_args{"confirm_as"};
	} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
	  $mytest_confirm_as = $$meaning_args{"confirm_as_nuance_speakfreely"};
	}

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		if ((scalar keys %{ $$grammar_elems_array{$gram_array_type}}) > 0) {
			if ($do_filtercorpus_direct) {
				$temp = GetMeaning_filtercorpus("NUANCE_GSL", $$grammar_elems_array{$gram_array_type}, \%lineHshRef, $gram_elem_cat_hash, $$meaning_args{"reject_name"});
			} else {
				GetMeaning_new ($$grammar_elems_array{$gram_array_type}, \%lineHshRef, $general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $compressed_already_hash);
			}

			foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {

				if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
					$temp_word = $grammar_items;
					$temp_word =~ s/_/ /g;
					$meaning = $lineHshRef{$temp_word};
					if ($meaning eq "") {
						$meaning = $lineHshRef{$grammar_items};
					}

					$mytest_confirm_as = NormCat($mytest_confirm_as, $$meaning_args{"reject_name"});

					if (index(lc($meaning) , lc($mytest_confirm_as)) != -1) {
						$at_least_one_found = 1;
						last;
					}
				}
			}

			if ($at_least_one_found) {
				print $grammar_out $grammar_preamble;

				foreach $pre_phrases ( sort { $$pre_phrases_array{$gram_array_type}{$b} <=> $$pre_phrases_array{$gram_array_type}{$a} } keys %{$$pre_phrases_array{$gram_array_type}}) {
					if ($$pre_phrases_array{$gram_array_type}{$pre_phrases} > $freq) {
						$temp_word = $pre_phrases;
						$temp_word =~ s/_/ /g;

						print $grammar_out "\t\t\t($temp_word)\n";
					}
				}


				print $grammar_out "\t\t]\n\n";

				if ($insert_word ne "") {
					print $grammar_out "\t\t\?$insert_word\n\n";
				}

				print $grammar_out "\n\t\t[\n";

				foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
					if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
						$temp_word = $grammar_items;
						$temp_word =~ s/_/ /g;
						$meaning = $lineHshRef{$temp_word};
						if ($meaning eq "") {
							$meaning = $lineHshRef{$grammar_items};
						}

						$mytest_confirm_as = NormCat($mytest_confirm_as, $$meaning_args{"reject_name"});
						if (index(lc($meaning) , lc($mytest_confirm_as)) != -1) {
							print $grammar_out "\t\t\t($temp_word) {$meaning <SpokenText \$string>} \n";
						} else {
							if ($debug) {
								print $grammar_out "\t\t\t($temp_word) {$meaning} <<<<<<<<<<< UNKNOWN \n";
							}
						}
					}
				}

				print $grammar_out "\t\t]\n\n";

				if ($insert_thanks) {
					if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
						print $grammar_out "\t\t\?[please (thank you) thanks]\n\n";
					} elsif ($$general_args{"main_language"} eq "es-us") {
						print $grammar_out "\t\t\?[(por favor) (muchas gracias) gracias]\n\n";
					}
				}

				print $grammar_out "\t)\n\n";
			}

		}
	}

	if (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
		if ((scalar keys %{ $$grammar_elems_array{$gram_array_type}}) > 0) {
			print $grammar_out $grammar_preamble;

			if ($do_filtercorpus_direct) {
				$temp = GetMeaning_filtercorpus("NUANCE_SPEAKFREELY", $$grammar_elems_array{$gram_array_type}, \%lineHshRef, $gram_elem_cat_hash, $$meaning_args{"reject_name"});
			} else {
				GetMeaning_new ($$grammar_elems_array{$gram_array_type}, \%lineHshRef, $general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $compressed_already_hash);
			}

			foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
				if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
					$temp_word = $grammar_items;
					$temp_word =~ s/_/ /g;
					$meaning = $lineHshRef{$temp_word};
					if ($meaning eq "") {
						$meaning = $lineHshRef{$grammar_items};
					}

					$mytest_confirm_as = NormCat($mytest_confirm_as, $$meaning_args{"reject_name"});
					if (index(lc($meaning) , lc($mytest_confirm_as)) != -1) {
#					if (index($meaning , uc($mytest_confirm_as)) != -1) {
						$at_least_one_found = 1;
						last;
					}
				}
			}

			if ($at_least_one_found) {
				if (scalar (keys %{$$pre_phrases_array{$gram_array_type}}) > 0) {
					print $grammar_out "\t\t\t\t<item>\n";
					print $grammar_out "\t\t\t\t\t<one-of>\n";
				}

				foreach $pre_phrases ( sort { $$pre_phrases_array{$gram_array_type}{$b} <=> $$pre_phrases_array{$gram_array_type}{$a} } keys %{$$pre_phrases_array{$gram_array_type}}) {
					if ($$pre_phrases_array{$gram_array_type}{$pre_phrases} > $freq) {
						$temp_word = $pre_phrases;
						$temp_word =~ s/_/ /g;

						print $grammar_out "\t\t\t\t\t\t<item>\n";
						print $grammar_out "\t\t\t\t\t\t\t$temp_word\n";
						print $grammar_out "\t\t\t\t\t\t</item>\n";
					}
				}

				if (scalar (keys %{$$pre_phrases_array{$gram_array_type}}) > 0) {
					print $grammar_out "\t\t\t\t\t</one-of>\n\n";
				}

				print $grammar_out "\t\t\t\t</item>\n";
				print $grammar_out "\t\t\t</one-of>\n\n";

				if ($insert_word ne "") {
					print $grammar_out "\t\t\t<item repeat=\"0-1\">\n";
					print $grammar_out "\t\t\t\t$insert_word\n";
					print $grammar_out "\t\t\t</item>\n\n";
				}

				print $grammar_out "\t\t</item>\n";
				print $grammar_out "\t\t<item>\n";

				print $grammar_out "\t\t\t<one-of>\n";

				foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
					if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
						$temp_word = $grammar_items;
						$temp_word =~ s/_/ /g;

						$meaning = $lineHshRef{$temp_word};
						if ($meaning eq "") {
							$meaning = $lineHshRef{$grammar_items};
						}

#						if (index($meaning , uc($mytest_confirm_as)) != -1) {
						if (index($meaning , $mytest_confirm_as) != -1) {
							print $grammar_out "\t\t\t\t<item>\n";
							print $grammar_out "\t\t\t\t\t$temp_word\n";
							print $grammar_out "\t\t\t\t\t$meaning\n";
							print $grammar_out "\t\t\t\t</item>\n";
						} else {
							if ($debug) {
								print $grammar_out "\t\t\t\t<item>\n";
								print $grammar_out "\t\t\t\t\t$temp_word\n";
								print $grammar_out "\t\t\t\t\t$meaning <<<<<<<<<<< UNKNOWN\n";
								print $grammar_out "\t\t\t\t</item>\n";
							}
						}
					}
				}

				print $grammar_out "\t\t\t</one-of>\n\n";

				if ($insert_thanks) {
					print $grammar_out "\t\t\t<item repeat=\"0-1\">\n";

					if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
						print $grammar_out "\t\t\t\t<one-of>\n\t\t\t\t\t<item>please</item>\n\t\t\t\t\t<item>thank you</item>\n\t\t\t\t\t<item>thanks</item>\n\t\t\t\t</one-of>\n";
					} elsif ($$general_args{"main_language"} eq "es-us") {
						print $grammar_out "\t\t\t\t<one-of>\n\t\t\t\t\t<item>por favor</item>\n\t\t\t\t\t<item>muchas gracias</item>\n\t\t\t\t\t<item>gracias</item>\n\t\t\t\t</one-of>\n";
					}

					print $grammar_out "\t\t\t</item>\n\n";
				}

				print $grammar_out "\t\t</item>\n\n";
				print $grammar_out "\t</rule>\n\n";
			}
		}
	}
}

sub Write_Grammar_Out_minus {

    my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $grammar_out, $debug, $grammar_preamble, $grammar_elems_array, $gram_array_type, $freq, $weight, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash) = @_;

	my(%lineHshRef);
	my($grammar_items);
	my($meaning);
	my($temp);
	my($temp_word);
	my($mytest_confirm_as);

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
	  $mytest_confirm_as = $$meaning_args{"confirm_as"};
	} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
	  $mytest_confirm_as = $$meaning_args{"confirm_as_nuance_speakfreely"};
	}

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		if ((scalar keys %{ $$grammar_elems_array{$gram_array_type}}) > 0) {
			if ($do_filtercorpus_direct) {
				$temp = GetMeaning_filtercorpus("NUANCE_GSL", $$grammar_elems_array{$gram_array_type}, \%lineHshRef, $gram_elem_cat_hash, $$meaning_args{"reject_name"});
			} else {
				GetMeaning_new ($$grammar_elems_array{$gram_array_type}, \%lineHshRef, $general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $compressed_already_hash);
			}

			print $grammar_out $grammar_preamble;

			foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
				if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
					$temp_word = $grammar_items;
					$temp_word =~ s/_/ /g;
					#	$temp_word = lc($temp_word);
					$meaning = $lineHshRef{$temp_word};
					if ($meaning eq "") {
						$meaning = $lineHshRef{$grammar_items};
					}

					$mytest_confirm_as = NormCat($mytest_confirm_as, $$meaning_args{"reject_name"});
					if (index(lc($meaning) , lc($mytest_confirm_as)) != -1) {
#					if (index($meaning , $mytest_confirm_as) != -1) {
						print $grammar_out "\t\t($temp_word) {$meaning <SpokenText \$string>} \n";
					} else {
						if ($debug) {
							print $grammar_out "\t\t($temp_word) {$meaning} <<<<<<<<<<< UNKNOWN \n";
						}
					}
				}
			}

			print $grammar_out "\t]~$weight\n\n";
		}
	}

	if (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
		if ((scalar keys %{ $$grammar_elems_array{$gram_array_type}}) > 0) {
			if ($do_filtercorpus_direct) {
				$temp = GetMeaning_filtercorpus("NUANCE_SPEAKFREELY", $$grammar_elems_array{$gram_array_type}, \%lineHshRef, $gram_elem_cat_hash, $$meaning_args{"reject_name"});
			} else {
			  GetMeaning_new ($$grammar_elems_array{$gram_array_type}, \%lineHshRef, $general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $compressed_already_hash);
			}

			print $grammar_out $grammar_preamble;

			print $grammar_out "\t\t\t<one-of>\n";

			foreach $grammar_items ( sort { $$grammar_elems_array{$gram_array_type}{$b} <=> $$grammar_elems_array{$gram_array_type}{$a}  } keys %{ $$grammar_elems_array{$gram_array_type} }) {
				if ($$grammar_elems_array{$gram_array_type}{$grammar_items} > $freq) {
					$temp_word = $grammar_items;
					$temp_word =~ s/_/ /g;
					#	$temp_word = lc($temp_word);
					$meaning = $lineHshRef{$temp_word};
					if ($meaning eq "") {
						$meaning = $lineHshRef{$grammar_items};
					}

#					if (index($meaning , uc($mytest_confirm_as)) != -1) {
					if (index($meaning , $mytest_confirm_as) != -1) {
						print $grammar_out "\t\t\t\t<item>\n";
						print $grammar_out "\t\t\t\t\t$temp_word\n";
						print $grammar_out "\t\t\t\t\t$meaning\n";
						print $grammar_out "\t\t\t\t</item>\n";
					} else {
						if ($debug) {
							print $grammar_out "\t\t\t\t<item>\n";
							print $grammar_out "\t\t\t\t\t$temp_word\n";
							print $grammar_out "\t\t\t\t\t$meaning <<<<<<<<<<< UNKNOWN\n";
							print $grammar_out "\t\t\t\t</item>\n";
						}
					}

				}
			}

			print $grammar_out "\t\t\t</one-of>\n\n";
			print $grammar_out "\t\t</item>\n\n";
			print $grammar_out "\t</rule>\n\n";
#			print $grammar_out "\t]~$weight\n\n";
		}
	}
}

sub Write_SubGrammars_Out {

    my($general_args, $mygrammar_suffix, $myfiltergrammarfileout, $pre_phrases, $grammar_elems_array, $grammar_elems_other_array, $test_slotname_nuance_speakfreely, $test_confirm_as_nuance_speakfreely) = @_;

	my($elem);
	my($encoding) = setEncoding($$general_args{"main_language"});

	open(GRAMMAR_OUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "$myfiltergrammarfileout") or die "cant write $myfiltergrammarfileout";

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			print GRAMMAR_OUT "IWANT_TO_SLM:filler\n";
			print GRAMMAR_OUT "	[\n";
			print GRAMMAR_OUT "	(?i want to)\n";
			print GRAMMAR_OUT "	(?i need to)\n";
			print GRAMMAR_OUT "	(?[i'd i] like to)\n";
			print GRAMMAR_OUT "	(can i)\n";
			print GRAMMAR_OUT "	(may i)\n";
			print GRAMMAR_OUT "	(?i wanna)\n";
			print GRAMMAR_OUT "	(i would like to)\n";
			print GRAMMAR_OUT "	to\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "IWant_SLM:filler [\n";
			print GRAMMAR_OUT "	(?i would like)\n";
			print GRAMMAR_OUT "	(?i want)\n";
			print GRAMMAR_OUT "	(?i need)\n";
			print GRAMMAR_OUT "	(can i have)\n";
			print GRAMMAR_OUT "	(may i have)\n";
			print GRAMMAR_OUT "	(give me)\n";
			print GRAMMAR_OUT "	]\n\n";

			print GRAMMAR_OUT "OPERATOR_SLM:filler [ \n";
			print GRAMMAR_OUT "		(?[a the my] ?(customer ?[care service services support]) [agent attendant associate assistant consultant counsellor operator representative rep specialist])\n";
			print GRAMMAR_OUT "		(?[a the my] (customer [care service services support]) ?[agent attendant associate assistant consultant counsellor operator representative rep specialist])\n";
			print GRAMMAR_OUT "		([someone somebody] (in technical [service support]))\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "PERSON_SLM:filler [\n";
			print GRAMMAR_OUT "		(?a ?[real live (real live)] person)\n";
			print GRAMMAR_OUT "		(?a human ?being)\n";
			print GRAMMAR_OUT "		([someone somebody] ?(in technical [service support]))\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "MY [my a an the our her his]\n\n";
			print GRAMMAR_OUT "AN [a an]\n\n";
		}

		if ($$general_args{"main_language"} eq "es-us") {
			print GRAMMAR_OUT "IWANT_TO_SLM:filler\n";
			print GRAMMAR_OUT "	[\n";
			print GRAMMAR_OUT "	(quiero)\n";
			print GRAMMAR_OUT "	(necesito)\n";
			print GRAMMAR_OUT "	(me gustaria)\n";
			print GRAMMAR_OUT "	(puedo)\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "IWant_SLM:filler [\n";
			print GRAMMAR_OUT "	(quiero)\n";
			print GRAMMAR_OUT "	(necesito)\n";
			print GRAMMAR_OUT "	(me gustaria)\n";
			print GRAMMAR_OUT "	(puede darme)\n";
			print GRAMMAR_OUT "	(dame)\n";
			print GRAMMAR_OUT "	]\n\n";

			print GRAMMAR_OUT "OPERATOR_SLM:filler [ \n";
			print GRAMMAR_OUT "		(?[un una la el mi] [agente administrador asistente operador representativo especialista])\n";
			print GRAMMAR_OUT "		([alguien] (en [servicio apoyo] técnico))\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "PERSON_SLM:filler [\n";
			print GRAMMAR_OUT "		(?una persona)\n";
			print GRAMMAR_OUT "		(?un ser humano)\n";
			print GRAMMAR_OUT "		([alguien] ?(en [servicio apoyo] técnico))\n";
			print GRAMMAR_OUT "]\n\n";

			print GRAMMAR_OUT "MI [mis mi tu tus un una la el las los su sus nuestro nuestra nuestros nuestras vuestro vuestra vuestros vuestras]\n\n";
			print GRAMMAR_OUT "UN [un una]\n\n";
		}


		if ($mygrammar_suffix ne "") {
			print GRAMMAR_OUT "CorpusDirect"."_".$mygrammar_suffix." [\n\n";
		} else {
			print GRAMMAR_OUT "CorpusDirect [\n\n";
		}
	}

	if (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
#hereqaz777: indent candidate
		print GRAMMAR_OUT "<\?xml version=\"1.0\" encoding=\"$encoding\" \?>\n";
		print GRAMMAR_OUT "<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\"\n";
		print GRAMMAR_OUT "\txmlns:xsi=\"http:\/\/www\.w3\.org\/2001\/XMLSchema-instance\"\n";
		print GRAMMAR_OUT "\txsi:schemaLocation=\"http:\/\/www\.w3\.org\/2001\/06\/grammar\n";
		print GRAMMAR_OUT "\t\t\thttp:\/\/www\.w3\.org\/TR\/speech-grammar\/grammar\.xsd\"\n\n";
		print GRAMMAR_OUT " xml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"ROOT\">\n\n";

		print GRAMMAR_OUT "\t<rule id=\"ROOT\" scope=\"public\">\n";
		print GRAMMAR_OUT "\t\t<item>\n";

		if ($mygrammar_suffix ne "") {
			print GRAMMAR_OUT "\t\t\t<ruleref uri=\"#CorpusDirect_".$mygrammar_suffix."\"/>\n";
			print GRAMMAR_OUT "\t\t\t<tag>$test_slotname_nuance_speakfreely=CorpusDirect_".$mygrammar_suffix.".$test_slotname_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t<tag>$test_confirm_as_nuance_speakfreely=CorpusDirect_".$mygrammar_suffix.".$test_confirm_as_nuance_speakfreely</tag>\n";
		} else {
			print GRAMMAR_OUT "\t\t\t<ruleref uri=\"#CorpusDirect\"/>\n";
			print GRAMMAR_OUT "\t\t\t<tag>ITEM_NAME=CorpusDirect.$test_slotname_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t<tag>CONFIRM_AS=CorpusDirect.$test_confirm_as_nuance_speakfreely</tag>\n";
		}

		print GRAMMAR_OUT "\t\t</item>\n";
		print GRAMMAR_OUT "\t</rule>\n\n";

		if ($mygrammar_suffix ne "") {
			print GRAMMAR_OUT "\t<rule id=\"CorpusDirect_".$mygrammar_suffix."\" scope=\"public\">\n";
		} else {
			print GRAMMAR_OUT "\t<rule id=\"CorpusDirect\" scope=\"public\">\n";
		}

		print GRAMMAR_OUT "\t\t<one-of>\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			if ($mygrammar_suffix eq "") {
				if ((scalar keys %{ $$grammar_elems_other_array{"full"}}) > 0) {
					print GRAMMAR_OUT "\t\t\t<item>\n";
					print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Unclassified_Phrases\" \/>\n";
					print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Unclassified_Phrases."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Unclassified_Phrases."."$test_confirm_as_nuance_speakfreely</tag>\n";
					print GRAMMAR_OUT "\t\t\t</item>\n";
				}

				if ((scalar keys %{ $$grammar_elems_other_array{"unknown"}}) > 0) {
					print GRAMMAR_OUT "\t\t\t<item>\n";
					print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Phrases_with_no_prefix\" \/>\n";
					print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Phrases_with_no_prefix."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Phrases_with_no_prefix."."$test_confirm_as_nuance_speakfreely</tag>\n";
					print GRAMMAR_OUT "\t\t\t</item>\n";
				}
			}

			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Noun_Phrases\" \/>\n";
			print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Noun_Phrases."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Noun_Phrases."."$test_confirm_as_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";

			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Noun_ing_Phrases\" \/>\n";
			print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Noun_ing_Phrases."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Noun_ing_Phrases."."$test_confirm_as_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";

			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Verb_Phrases\" \/>\n";
			print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Verb_Phrases."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Verb_Phrases."."$test_confirm_as_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
		} elsif ($$general_args{"main_language"} eq "es-us") {
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Noun_Phrases_esus\" \/>\n";
			print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Noun_Phrases_esus."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Noun_Phrases_esus."."$test_confirm_as_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";

			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#Verb_Phrases_esus\" \/>\n";
			print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=Verb_Phrases_esus."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=Verb_Phrases_esus."."$test_confirm_as_nuance_speakfreely</tag>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
		}

		if ($mygrammar_suffix eq "") {
			foreach $elem ( sort { $a cmp $b } keys %{$pre_phrases}) {
				if ((scalar keys %{ $$grammar_elems_array{$elem}}) > 0) {
					if (($elem !~ /filler/) && ($elem !~ /combo/) && ($elem !~ /unless/) && ($elem !~ /pass/) && ($elem ne "noun") && ($elem ne "noun_ing") && ($elem ne "verb") && ($elem ne "unknown")) {
						print GRAMMAR_OUT "\t\t\t<item>\n";
						if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
							print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#$elem"."_Phrases\" \/>\n";

							print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=$elem"."_Phrases."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=$elem"."_Phrases."."$test_confirm_as_nuance_speakfreely</tag>\n";
						} elsif ($$general_args{"main_language"} eq "es-us") {
							print GRAMMAR_OUT "\t\t\t\t<ruleref uri=\"#$elem"."_Phrases_esus\" \/>\n";

							print GRAMMAR_OUT "\t\t\t\t<tag>CATEGORY_CODE=$elem"."_Phrases_esus."."$test_slotname_nuance_speakfreely</tag><tag>CONFIRM_AS=$elem"."_Phrases_esus."."$test_confirm_as_nuance_speakfreely</tag>\n";
						}

						print GRAMMAR_OUT "\t\t\t</item>\n";
					}
				}
			}
		}

		print GRAMMAR_OUT "\t\t</one-of>\n";
		print GRAMMAR_OUT "\t</rule>\n\n";

		print GRAMMAR_OUT "\t<rule id=\"UhUm\" scope=\"public\">\n";
		print GRAMMAR_OUT "\t\t<one-of>\n";
		print GRAMMAR_OUT "\t\t\t<item>uh</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>um</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>ah</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>mm</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>er</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>oh</item>\n";
		print GRAMMAR_OUT "\t\t\t<item>ok</item>\n";
		print GRAMMAR_OUT "\t\t</one-of>\n";
		print GRAMMAR_OUT "\t</rule>\n\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			print GRAMMAR_OUT "\t<rule id=\"IWANT_TO_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ti \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\twant to \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ti \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tneed to \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>i&apos;d</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>i</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tlike to \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\tcan i \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\tmay i \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ti \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\twanna \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\ti would like to \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>to</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"IWant_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ti \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\twant \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ti \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tneed \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\tcan i have \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\tmay i have \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\tgive me \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"OPERATOR_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>a</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>the</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>my</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\tcustomer \n";
			print GRAMMAR_OUT "\t\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t\t<item>care</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t\t<item>service</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t\t<item>services</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t\t<item>support</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>agent</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>attendant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>associate</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>assistant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>consultant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>counsellor</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>operator</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>representative</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>rep</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>specialist</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>a</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>the</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>my</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tcustomer \n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>care</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>service</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>services</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>support</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>agent</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>attendant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>associate</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>assistant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>consultant</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>counsellor</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>operator</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>representative</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>rep</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>specialist</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>someone</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>somebody</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\tin technical \n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>service</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>support</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"PERSON_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ta \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>real</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>live</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t\treal live \n";
			print GRAMMAR_OUT "\t\t\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tperson \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ta \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\thuman \n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\tbeing \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>someone</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>somebody</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\tin technical \n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>service</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>support</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"MY\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>my</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>a</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>an</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>the</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>our</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>her</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>his</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";
		}

		if ($$general_args{"main_language"} eq "es-us") {
			print GRAMMAR_OUT "<rule id=\"IWANT_TO_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t<one-of>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tquiero \n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tnecesito \n";
 			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tme gustaria \n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tpuedo \n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t</one-of>\n";
			print GRAMMAR_OUT "</rule>\n\n";

			print GRAMMAR_OUT "<rule id=\"IWant_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t<one-of>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tquiero\n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tnecesito\n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tpuede darme\n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\tdame \n";
			print GRAMMAR_OUT "\t\t</item>\n";
			print GRAMMAR_OUT "\t</one-of>\n";
			print GRAMMAR_OUT "</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"OPERATOR_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>un</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>una</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>la</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>el</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>mi</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>agente</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>administrador</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>asistente</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>operador</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>representativo</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>especialista</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\talguien en \n";
			print GRAMMAR_OUT "\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>servicio</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t<item>apoyo</item>\n";
			print GRAMMAR_OUT "\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\ttécnico \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"PERSON_SLM\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\tuna \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tpersona \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\tun \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t\tser humano \n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>\n";
			print GRAMMAR_OUT "\t\t\t\talguien \n";
			print GRAMMAR_OUT "\t\t\t\t<item repeat=\"0-1\">\n";
			print GRAMMAR_OUT "\t\t\t\t\ten \n";
			print GRAMMAR_OUT "\t\t\t\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>servicio</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t\t<item>apoyo</item>\n";
			print GRAMMAR_OUT "\t\t\t\t\t</one-of>\n";
			print GRAMMAR_OUT "\t\t\t\t\ttécnico \n";
			print GRAMMAR_OUT "\t\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t\t</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";

			print GRAMMAR_OUT "\t<rule id=\"MI\" scope=\"public\">\n";
			print GRAMMAR_OUT "\t\t<one-of>\n";
			print GRAMMAR_OUT "\t\t\t<item>mis</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>mi</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>tus</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>tu</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>un</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>una</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>la</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>el</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>las</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>los</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>su</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>sus</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>nuestro</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>nuestra</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>nuestros</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>nuestras</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>vuestro</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>vuestra</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>vuestros</item>\n";
			print GRAMMAR_OUT "\t\t\t<item>vuestras</item>\n";
			print GRAMMAR_OUT "\t\t</one-of>\n";
			print GRAMMAR_OUT "\t</rule>\n\n";
		}
	}

	close (GRAMMAR_OUT);
}

sub Write_Grammar_Out_all {

    my($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $mygrammar_suffix, $debug, $myfiltergrammarfileout, $pre_phrases, $grammar_elems, $grammar_elems_other, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash) = @_;

	my($grammar_preamble);
	my($elem);
	my($my_elem);
	my($phrase_type);

	open(GRAMMAROUT,">>$myfiltergrammarfileout") or die "cant write $myfiltergrammarfileout";

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		if ($mygrammar_suffix eq "") {
#Unclassified Phrases:
			$grammar_preamble = "\t; Unclassified Phrases:\n";
			$grammar_preamble = $grammar_preamble."\n\t[\n";
			Write_Grammar_Out_minus ($general_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $grammar_elems_other, "full", 0, "0.01", $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Phrases with no prefix:
			$grammar_preamble = "\t; Phrases with no prefix:\n";
			$grammar_preamble = $grammar_preamble."\n\t[\n";
			Write_Grammar_Out_minus ($general_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $grammar_elems_other, "unknown", $freq, "0.01", $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);
		}

#Noun Phrases:
		$grammar_preamble = "; Noun Phrases:\n";
		$grammar_preamble = $grammar_preamble."\t(?UhUm\n";
		$grammar_preamble = $grammar_preamble."\t\t?[\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = $grammar_preamble."\t\t\t(?(?i have) ?a question [about on regarding (in [regards regard] to)])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (let me)] [talk speak] ?([to with] [PERSON_SLM OPERATOR_SLM]) [with about on regarding (in [regards regard] to)] ?(?[my a the] [problems problem] with))\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (let me)] [talk speak] [to with])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM [check know] [about on])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM know)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM go to)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[i'm (i am)] checking [about on])\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWant_SLM ?[(information [about on regarding]) (help ?[with on regarding])]\n\n";

			$my_elem = "MY";
			$phrase_type = "noun";

		} elsif ($$general_args{"main_language"} eq "es-us") {
			$grammar_preamble = $grammar_preamble."\t\t\t(?(tengo) ?una pregunta [sobre (acerca de) (al lado de)])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] ?([a con] [PERSON_SLM OPERATOR_SLM]) [sobre (acerca de) (al lado de)] ?(?[mi mis un los] [problemas problema] con))\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] [a con])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM [comprobar saber] [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM saber)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM ir a)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?estoy comprobando [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWant_SLM ?[(informacíon [sobre en (acerca de)]) (ayuda ?[sobre en (acerca de)])]\n\n";

			$my_elem = "MI";
			$phrase_type = "noun_esus";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, $phrase_type, $my_elem, 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Noun -ing Phrases:
		$grammar_preamble = "; Noun -ing Phrases:\n";
		$grammar_preamble = $grammar_preamble."\t(?UhUm\n";
		$grammar_preamble = $grammar_preamble."\t\t?[\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = $grammar_preamble."\t\t\t(?(?i have) ?a question [about on regarding (in [regards regard] to)])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (let me)] [talk speak] ?([to with] [PERSON_SLM OPERATOR_SLM]) [with about on regarding (in [regards regard] to)] ?(?[my a the] [problems problem] with))\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM [check know] [about on])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[i'm (i am)] checking [about on])\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWant_SLM [(information [about on regarding]) (help ?[with on regarding])]\n\n";

			$phrase_type = "noun_ing";
		} elsif ($$general_args{"main_language"} eq "es-us") {
			$grammar_preamble = $grammar_preamble."\t\t\t(?(tengo) ?una pregunta [sobre (acerca de) (al lado de)])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] ?([a con] [PERSON_SLM OPERATOR_SLM]) [sobre (acerca de) (al lado de)] ?(?[mi mis un los] [problemas problema] con))\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] [a con])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM [comprobar saber] [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM saber)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM ir a)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?estoy comprobando [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWant_SLM ?[(informacíon [sobre en (acerca de)]) (ayuda ?[sobre en (acerca de)])]\n\n";

			$phrase_type = "noun_ing_esus";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, $phrase_type, "", 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Verb Phrases:
		$grammar_preamble = "\t; Verb Phrases:\n";
		$grammar_preamble = $grammar_preamble."\t(?UhUm\n";
		$grammar_preamble = $grammar_preamble."\t\t?[\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (let me)] [talk speak] ?([to with] [PERSON_SLM OPERATOR_SLM]) to)\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWANT_TO_SLM\n\n";

			$phrase_type = "verb";
		} elsif ($$general_args{"main_language"} eq "es-us") {
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] ?([a con] [PERSON_SLM OPERATOR_SLM]) a)\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWANT_TO_SLM\n\n";

			$grammar_preamble = $grammar_preamble."\t\t\t(?(tengo) ?una pregunta [sobre (acerca de) (al lado de)])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] ?([a con] [PERSON_SLM OPERATOR_SLM]) [sobre (acerca de) (al lado de)] ?(?[mi mis un los] [problemas problema] con))\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?[IWANT_TO_SLM (me dejes) dejame] [hablar] [a con])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM [comprobar saber] [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM saber)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?IWANT_TO_SLM ir a)\n";
			$grammar_preamble = $grammar_preamble."\t\t\t(?estoy comprobando [sobre en])\n";
			$grammar_preamble = $grammar_preamble."\t\t\tIWant_SLM ?[(informacíon [sobre en (acerca de)]) (ayuda ?[sobre en (acerca de)])]\n\n";


			$phrase_type = "verb_esus";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, $phrase_type, "", 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

		if ($mygrammar_suffix eq "") {
			foreach $elem ( sort { $a cmp $b } keys %{$pre_phrases}) {
				if (($elem !~ /filler/) && ($elem !~ /combo/) && ($elem !~ /unless/) && ($elem !~ /pass/) && ($elem !~ /noun/) && ($elem !~ /verb/) && ($elem ne "unknown")) {
					$grammar_preamble = "\t; $elem Phrases:\n";
					$grammar_preamble = $grammar_preamble."\t(?UhUm\n";
					$grammar_preamble = $grammar_preamble."\t\t?[\n";

					$my_elem = "";
					if ($elem =~ /(you_have|i_have|i_tengo_have|\bwhen\b|when_is|when_are|who_is|who_are|where_is|where_are|what_are|which_are|why_is|why_are)/) {
						$my_elem = "MY";

						if ($elem =~ /_esus/) {
							$my_elem = "MI";
						}
					}

					if (($elem eq "i_am") || ($elem eq "i_am_esus") || ($elem eq "is_there") || ($elem eq "is_there_esus")) {
						$my_elem = "AN";

						if ($elem =~ /_esus/) {
							$my_elem = "UN";
						}
					}

					Write_Grammar_Out ($general_args, $cleaning_args, $wordnet_args, $meaning_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, "$elem", "$my_elem", 0, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

				}
			}
		}

		print GRAMMAROUT "]\n";
	}

#hereqaz888: indent candidate
	if (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
		if ($mygrammar_suffix eq "") {
#Unclassified Phrases:
			$grammar_preamble = "<!--  Unclassified Phrases: -->\n";
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Unclassified_Phrases\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item>\n";
			Write_Grammar_Out_minus ($general_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $grammar_elems_other, "full", 0, "0.01", $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Phrases with no prefix:
			$grammar_preamble = "<!--  Phrases with no prefix: -->\n";
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Phrases_with_no_prefix\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item>\n";
			Write_Grammar_Out_minus ($general_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $grammar_elems_other, "unknown", $freq, "0.01", $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);
		}

#Noun Phrases:
		$grammar_preamble = "<!-- Noun Phrases: -->\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Noun_Phrases\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<ruleref uri=\"#UhUm\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t</item>\n";

			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";

			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\ti \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\thave \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\ta \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tquestion \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tin \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regards</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regard</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tto \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tlet me \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>talk</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>speak</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>to</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tin \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regards</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regard</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tto \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>my</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>the</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problems</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problem</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\twith \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tlet me \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>talk</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>speak</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>to</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>check</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>know</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tknow \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tgo to \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>i&apos;m</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\ti am \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tchecking \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWant_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tinformation \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\thelp \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n\n";

			$my_elem = "<ruleref uri=\"#MY\"/>";

			$phrase_type = "noun";
		} elsif ($$general_args{"main_language"} eq "es-us") {
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Noun_Phrases_esus\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<ruleref uri=\"#UhUm\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\ttengo \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\tuna \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tpregunta \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tal lado de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tme dejes \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>dejame</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\thablar \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>con</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tal lado de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>mi</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>mis</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>un</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>los</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problemas</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problema</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\tcon \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tme dejes \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>dejame</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\thablar \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>con</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>comprobar</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>saber</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tsaber \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tir a \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\testoy \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tcomprobando \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWant_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tinformacíon \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tayuda \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n\n";

			$my_elem = "<ruleref uri=\"#MI\"/>";

			$phrase_type = "noun_esus";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, $phrase_type, "$my_elem", 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Noun -ing Phrases:
		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = "<!-- Noun -ing Phrases: -->\n";

			$grammar_preamble = $grammar_preamble."\t<rule id=\"Noun_ing_Phrases\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\ti \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\thave \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\ta \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tquestion \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tin \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regards</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regard</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tto \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tlet me \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>talk</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>speak</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>to</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tin \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regards</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regard</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tto \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>my</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>the</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problems</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problem</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\twith \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>check</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>know</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>i&apos;m</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\ti am \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tchecking \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWant_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tinformation \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>about</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\thelp \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>on</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>regarding</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
#			$grammar_preamble = $grammar_preamble."\t\t\t</one-of>\n";
#			$grammar_preamble = $grammar_preamble."\t\t</item>\n";
#			$grammar_preamble = $grammar_preamble."\t</rule>\n\n";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, "noun_ing", "", 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

#Verb Phrases:
		$grammar_preamble = "<!-- Verb Phrases: -->\n";

		if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Verb_Phrases\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<ruleref uri=\"#UhUm\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tlet me \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>talk</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>speak</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>to</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>with</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tto \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
#			$grammar_preamble = $grammar_preamble."\t\t\t</one-of>\n";
#			$grammar_preamble = $grammar_preamble."\t\t</item>\n";
#			$grammar_preamble = $grammar_preamble."\t</rule>\n\n";
			$phrase_type = "verb";
		} elsif ($$general_args{"main_language"} eq "es-us") {
			$grammar_preamble = $grammar_preamble."\t<rule id=\"Verb_Phrases_esus\" scope=\"public\">\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<ruleref uri=\"#UhUm\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tme dejes \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>dejame</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\thablar \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>con</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\ta \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\ttengo \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\tuna \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tpregunta \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tal lado de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tme dejes \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>dejame</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\thablar \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>con</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#PERSON_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#OPERATOR_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\tal lado de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>mi</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>mis</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>un</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item>los</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problemas</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>problema</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\tcon \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tme dejes \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>dejame</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\thablar \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>a</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>con</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>comprobar</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>saber</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tsaber \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<ruleref uri=\"#IWANT_TO_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tir a \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\testoy \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\tcomprobando \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<ruleref uri=\"#IWant_SLM\"/>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tinformacíon \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\tayuda \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t<item repeat=\"0-1\">\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t<one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>sobre</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>en</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t<item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t\tacerca de \n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t\t</one-of>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t\t</item>\n";
			$grammar_preamble = $grammar_preamble."\t\t\t\t</item>\n";

			$phrase_type = "verb_esus";
		}

		Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, $phrase_type, "", 1, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);

		if ($mygrammar_suffix eq "") {
			foreach $elem ( sort { $a cmp $b } keys %{$pre_phrases}) {
				if (($elem !~ /filler/) && ($elem !~ /combo/) && ($elem !~ /unless/) && ($elem !~ /pass/) && ($elem !~ /noun/) && ($elem !~ /verb/) && ($elem ne "unknown")) {
					$grammar_preamble = "<!-- $elem Phrases: -->\n";
					if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
						$grammar_preamble = $grammar_preamble."\t<rule id=\"$elem"."_Phrases\" scope=\"public\">\n";
					} elsif ($$general_args{"main_language"} eq "es-us") {
						$grammar_preamble = $grammar_preamble."\t<rule id=\"$elem"."_Phrases_esus\" scope=\"public\">\n";
					}

					$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
					$grammar_preamble = $grammar_preamble."\t\t\t<ruleref uri=\"#UhUm\"/>\n";
					$grammar_preamble = $grammar_preamble."\t\t</item>\n";
					$grammar_preamble = $grammar_preamble."\t\t<item repeat=\"0-1\">\n";
					$grammar_preamble = $grammar_preamble."\t\t\t<one-of>\n";

					$my_elem = "";
					if ($elem =~ /(you_have|i_have|i_tengo_have|\bwhen\b|when_is|when_are|who_is|who_are|where_is|where_are|what_are|which_are|why_is|why_are)/) {
						$my_elem = "<ruleref uri=\"#MY\"/>";


						if ($elem =~ /_esus/) {
							$my_elem = "<ruleref uri=\"#MI\"/>";
						}
					}

					if (($elem eq "i_am") || ($elem eq "i_am_esus") || ($elem eq "is_there") || ($elem eq "is_there_esus")) {
						$my_elem = "<ruleref uri=\"#AN\"/>";

						if ($elem =~ /_esus/) {
							$my_elem = "<ruleref uri=\"#UN\"/>";
						}
					}

					Write_Grammar_Out ($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, \*GRAMMAROUT, $debug, $grammar_preamble, $pre_phrases, $grammar_elems, "$elem", "$my_elem", 0, $freq, $do_filtercorpus_direct, $gram_elem_cat_hash, $compressed_already_hash);
				}
			}
		}

		print GRAMMAROUT "</grammar>\n";
	}

	close (GRAMMAROUT);
}

sub WriteVocabs
{
   my($general_args, $cleaning_args, $meaning_args, $vocabfile) = @_;

   my($filler_text) = "filler";
   my($vocabskipfile) = $vocabfile."_minus_skip_words";
   my($skip_active) = 0;

   my($elem1);

	if ($$general_args{"make_vocab"}) {

		if ($$general_args{"main_language"} eq "es-us") {
			$filler_text = $filler_text."_esus";
			$vocabskipfile = $vocabskipfile."_esus";
		}

		if (scalar keys %{$$meaning_args{"pre"}{$filler_text}} > 0) {
			open(VOCABSKIP,">$vocabskipfile") or die "cant write $vocabskipfile";
			$skip_active = 1;
		}

		open(VOCAB,">$vocabfile") or die "cant write $vocabfile";

		foreach $elem1 ( sort { $a cmp $b } keys %{$$general_args{"full_vocab"}}) {
		  if ($elem1 ne "throatwarblermangrove") {
			print VOCAB "$elem1\n";
		  }

		  if ($skip_active) {
			if (not defined $$meaning_args{"pre"}{$filler_text}{$elem1}) {
			  print VOCABSKIP "$elem1\n";
			} else {
			  $$cleaning_args{"top_skip"}{$elem1}++;
			}
		  }
		}

		close(VOCAB);
		close(VOCABSKIP);
	}
}

############# END OUTPUT SUBROUTINES #################################

######################################################################
######################################################################
############# Rule Application SUBROUTINES ###########################
######################################################################
######################################################################

sub ApplyParsingRules
{

    my($general_args, $meaning_args, $findReference_args, $calling_ref, $infile, $sentence_order, $main_search_string, $sentence_corpus_array, $compressed_sentence_array, $compressed_already_hash) = @_;

	my($changed_utt);
	my($compressed_utt);
	my($i);
	my($j);
	my($residual_search_string);
	my($scount);
	my($sent_begin);
	my($sent_end);
	my(%used_sentence_num_hash);

#############################################################################
# Apply Parsing Rules to each sentence in the input corpus
############################################################################
#

	$scount = FindKnownReferences ($general_args, $meaning_args, $findReference_args, $sentence_order, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $compressed_already_hash);

	if ($scount) {
		$main_search_string = "";

		if (($infile ne "STDIN") && ($calling_ref ne "getmeaning")){
			DebugPrint ("BOTH", 1, "ApplyParsingRules ", $debug-1, $err_no++, "$scount sentences match Known Categories");
		}

		if ($$meaning_args{"Main_Rule_count"} > 0) {
			$residual_search_string = "";
			$j = 0;
			for ($i = 0; $i < $sentence_order; $i++) {
				$changed_utt = $$sentence_corpus_array[$i];
				$compressed_utt = @$compressed_sentence_array[$i];
				if ($compressed_utt eq "Ç") {
				  $compressed_utt = $changed_utt;
				}

				if ($changed_utt ne "") {
					if (not defined $used_sentence_num_hash{$j}) {
						($residual_search_string, $sent_begin, $sent_end) = storeLocationInfoOrderedCombo($compressed_utt, $residual_search_string, $j);
					}

					$j++;
				}
			}

			FindAllReferences ($calling_ref, "main", $residual_search_string, $sentence_order, $$findReference_args{"MR_rule_assignment"}, $$findReference_args{"MR_rule_nofire"}, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $$meaning_args{"apply_rules"});
			$main_search_string = "";

			$residual_search_string = "";
		}
	} else {
		if ($$meaning_args{"Main_Rule_count"} > 0) {
			FindAllReferences ($calling_ref, "main", $main_search_string, $sentence_order, $$findReference_args{"MR_rule_assignment"}, $$findReference_args{"MR_rule_nofire"}, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $$meaning_args{"apply_rules"});
			$main_search_string = "";
		}
	}

	if ($$meaning_args{"Main_Ambig_Rule_count"} > 0) {
		$residual_search_string = "";
		$j = 0;
		for ($i = 0; $i < $sentence_order; $i++) {
			$changed_utt = $$sentence_corpus_array[$i];
			$compressed_utt = @$compressed_sentence_array[$i];
			if ($compressed_utt eq "Ç") {
			  $compressed_utt = $changed_utt;
			}

			if ($changed_utt ne "") {
				if (not defined $used_sentence_num_hash{$j}) {
					($residual_search_string, $sent_begin, $sent_end) = storeLocationInfoOrderedCombo($compressed_utt, $residual_search_string, $j);
				}

				$j++;
			}
		}

		FindAllReferences ($calling_ref, "main_ambig", $residual_search_string, $sentence_order, $$findReference_args{"BR_rule_assignment"}, $$findReference_args{"BR_rule_nofire"}, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $$meaning_args{"apply_ambig_rules"});

		$residual_search_string = "";
	}

	if ($$meaning_args{"General_Rule_count"} > 0) {
#		$residual_search_string = GetResidualString($main_search_string, \%used_sentence_num_hash, \@sentence_corpus_limits_array);
		$j = 0;
		for ($i = 0; $i < $sentence_order; $i++) {
			$changed_utt = $$sentence_corpus_array[$i];
			$compressed_utt = @$compressed_sentence_array[$i];
			if ($compressed_utt eq "Ç") {
			  $compressed_utt = $changed_utt;
			}

			if ($changed_utt ne "") {
				if (not defined $used_sentence_num_hash{$j}) {
					($residual_search_string, $sent_begin, $sent_end) = storeLocationInfoOrderedCombo($compressed_utt, $residual_search_string, $j);
				}

				$j++;
			}
		}

		FindAllReferences ($calling_ref, "general", $residual_search_string, $sentence_order, $$findReference_args{"GR_rule_assignment"}, $$findReference_args{"GR_rule_nofire"}, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $$meaning_args{"generic_rules"});

		$residual_search_string = "";
	}

	if ($$meaning_args{"External_Rule_count"} > 0) {
		$j = 0;
		for ($i = 0; $i < $sentence_order; $i++) {
			$changed_utt = $$sentence_corpus_array[$i];
			$compressed_utt = @$compressed_sentence_array[$i];
			if ($compressed_utt eq "Ç") {
			  $compressed_utt = $changed_utt;
			}

			if ($changed_utt ne "") {
				if (not defined $used_sentence_num_hash{$j}) {
					($residual_search_string, $sent_begin, $sent_end) = storeLocationInfoOrderedCombo($compressed_utt, $residual_search_string, $j);
				}

				$j++;
			}
		}

		FindAllReferences ($calling_ref, "external", $residual_search_string, $sentence_order, $$findReference_args{"ER_rule_assignment"}, $$findReference_args{"ER_rule_nofire"}, \%used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $$meaning_args{"external_rules"});

		$residual_search_string = "";
	}
}

sub ExpandVanilla
{

    my($general_args, $meaning_args, $wordnet_args, $expand_vanilla, $changed_utt, $item_id) = @_;

	my($do_build);
	my($filler_count);
	my($gsl_filler_build_string);
	my($gsl_filler_counter);
	my($len1);
	my($len2);
	my($pos1);
	my($pos2);
	my($words_id);
	my($words_utt);
	my(@rep_array);
	my(@rep_array_utt);

	if ($expand_vanilla) {
		@rep_array = split " ", $item_id;
		@rep_array_utt = split " ", $changed_utt;

		$words_utt = (scalar @rep_array_utt);

		if (((scalar @rep_array) > 1) && ($words_utt > 2)) {
			$len1 = length($rep_array[0]);
			$len2 = length($rep_array[-1]);

			$pos1 = index($changed_utt, $rep_array[0]);
			$pos2 = index($changed_utt, $rep_array[-1], $pos1+1);

			if (($pos1 != -1) && ($pos2 != -1)) {
				$item_id = substr($changed_utt, $pos1, ($pos2+$len2) - $pos1);
				@rep_array = split " ", $item_id;
				$words_id = (scalar @rep_array);

				if ($words_id > 3) {
					my($do_build) = 0;
					if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
						if (defined $$meaning_args{"pre_string"}) {
							$do_build = 1;
						}
					} elsif ($$general_args{"main_language"} eq "es-us") {
						if (defined $$meaning_args{"pre_string_esus"}) {
							$do_build = 1;
						}
					}

					@rep_array = split " ", $item_id;
					$words_id = (scalar @rep_array);
					$item_id = "((".$rep_array[0].") ?(*-filler-) (".$rep_array[-1]."))";

					($item_id, $filler_count, $gsl_filler_build_string, $gsl_filler_counter) = DoBuildForGSL($meaning_args, $wordnet_args, $do_build, $changed_utt);
				} else {
					if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
						$item_id = SimpleReplaceMy ($$general_args{"main_language"}, $item_id);
					}
				}
			}
		}
	}

	return ($item_id);
}

sub DetermineSourceAssignment
{

    my($general_args, $meaning_args, $wordnet_args, $findReference_args, $i, $j, $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $expand_vanilla, $sentence_corpus_array, $original_wavfile_array, $make_failparse, $do_classify, $do_testparsefile, $do_testsentence, $nl_total_records, $nl_blank_utts, $nl_not_handled, $use_reclassifications, $compressed_sentence_array, $original_transcription_array, $classify_truth_hash, $rule_sentence_hash, $focus_item_id, $check_expand_hash, $classify_result_hash, $do_suppress_grammar, $compressed_already_hash, $wordlist_already_hash) = @_;

	my($ambig_active);
	my($assignment_source);
	my($changed_utt);
	my($compressed_alias_utt);
	my($compressed_utt);
	my($confirmed_as);
	my($first_loc);
	my($generic_active);
	my($item_category);
	my($item_id);
	my($keep_string);
	my($last_loc);
	my($original_utt);
	my($rep_utt);
	my($temp_changed_utt);
	my($test_item);
	my($try_compressed_alias);
	my($try_reclass_compressed_alias);
	my($try_wordbag);
	my($try_wordbag_reclass);
	my($vanilla_rep_utt);
	my($wavfilename) = "";
	my($wordbag_compressed_alias_utt);
	my($wordbag_compressed_utt);
	my(@rest);

#############################################################################
# Determine Source Assignment of every Sentence
############################################################################
#
	$changed_utt = @$sentence_corpus_array[$i];
	$temp_changed_utt = $changed_utt;
	$changed_utt =~ s/\ª//g;
	$compressed_utt = @$compressed_sentence_array[$i];
	$original_utt = ChopChar(@$original_transcription_array[$i]);
	$wavfilename = $$original_wavfile_array[$i];
	if ($wavfilename eq "") {
	  $wavfilename = "NA";
	}

	if ($compressed_utt eq "Ç") {
	  $compressed_utt = $changed_utt;
	}

	$assignment_source = "NONE";
	if ((lc($changed_utt) =~ /\*blank\*/) || ($changed_utt eq "")) {
	    if ($changed_utt eq "") {
		  $changed_utt = "*blank*";
	    }

		$item_category = $$meaning_args{"reject_name"};
		if ($make_failparse) {
			my($temp);
			my($orig_utt);

			($temp, $orig_utt) = split ":", $changed_utt;
			$orig_utt = ChopChar($orig_utt);
			if ($do_testparsefile) {
				print $failparsefile_write_out "*Blank*\t".$$meaning_args{"reject_name"}."\n";
				print $failparsefile_write_out_catonly "*Blank*\t".$$meaning_args{"reject_name"}."\n";
			} else {
				if ($do_classify) {
#					$$classify_truth_hash{$temp}{$test_reject_name}++;
					$$classify_truth_hash{"__Blank__"}{$$meaning_args{"reject_name"}}++;
					WriteClassifications($general_args, "BLANK_INPUT_LINE:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "*Blank*", "BLANK_INPUT_LINE", $temp, $original_utt, "", "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
				} elsif (!$do_testsentence) {
					print $failparsefile_write_out "$original_utt\n";
				}
			}
		}

		if ($changed_utt ne "") {
			$j++;
		}

		return ($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled);
	}

	if ($changed_utt =~ /\*Response Exclusion\*/) {
		$item_category = $$meaning_args{"reject_name"};
		if ($make_failparse) {
			if ($do_testparsefile) {
				print $failparsefile_write_out "$changed_utt\n";
				print $failparsefile_write_out_catonly "$changed_utt\n";
			} else {
				if ($do_classify) {
					$$classify_truth_hash{$changed_utt}{$$meaning_args{"reject_name"}}++;
					WriteClassifications($general_args, "RESPONSE_EXCLUSION:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "RESPONSE_EXCLUSION", "RESPONSE_EXCLUSION", $changed_utt, $original_utt, $changed_utt, "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
				}
			}
		}

		$j++;

		return ($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled);
	}

	if ($changed_utt =~ /Ramble Exclusion/) {
		$item_category = $$meaning_args{"reject_name"};
		if ($make_failparse) {
			if ($do_testparsefile) {
				print $failparsefile_write_out "$changed_utt\n";
				print $failparsefile_write_out_catonly "$changed_utt\n";
			} else {
				if ($do_classify) {
				  $$classify_truth_hash{$changed_utt}{$$meaning_args{"reject_name"}}++;
				  WriteClassifications($general_args, "RAMBLE_EXCLUSION:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "RAMBLE_EXCLUSION", "RAMBLE_EXCLUSION", $changed_utt, $original_utt, $changed_utt, "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
				}
			}
		}

		$j++;

		return ($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled);
	}

	$item_category = "";
	$item_id = "";
	$confirmed_as = "";
	@$focus_item_id = ();
	$ambig_active = 0;
	$generic_active = 0;

	$try_reclass_compressed_alias = 0;
	$try_compressed_alias = 0;
	$try_wordbag_reclass = 0;
	$try_wordbag = 0;

	$wordbag_compressed_utt = "";
	$compressed_alias_utt = "";

	if (($use_reclassifications) && (not defined $$findReference_args{"FindReference_MR_reclassifications"}{$compressed_utt})) {
		$try_wordbag_reclass = 1;
		$try_wordbag = 1;

		$compressed_alias_utt = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_utt, $compressed_already_hash);

		if ($compressed_alias_utt ne $compressed_utt) {
			$try_reclass_compressed_alias = 1;
			$try_compressed_alias = 1;
		}

		$wordbag_compressed_utt = GenWordList($$general_args{"main_language"}, $compressed_utt, $wordlist_already_hash);
		$wordbag_compressed_alias_utt = GenWordList($$general_args{"main_language"}, $compressed_alias_utt, $wordlist_already_hash);
	} elsif ((!$use_reclassifications) && (not defined $$findReference_args{"FindReference_MR"}{$compressed_utt})) {
		$try_wordbag = 1;

		$compressed_alias_utt = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_utt, $compressed_already_hash);

		if ($compressed_alias_utt ne $compressed_utt) {
			$try_compressed_alias = 1;
		}

		$wordbag_compressed_utt = GenWordList($$general_args{"main_language"}, $compressed_utt, $wordlist_already_hash);
		$wordbag_compressed_alias_utt = GenWordList($$general_args{"main_language"}, $compressed_alias_utt, $wordlist_already_hash);
	}

	if (($use_reclassifications) && (defined $$findReference_args{"FindReference_MR_reclassifications"}{$compressed_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_reclassifications"}, $$findReference_args{"FindReference_focus_MR_reclassifications"}, $compressed_utt, $focus_item_id);

			$assignment_source = "RECLASS RULE Stored";
	} elsif (($try_reclass_compressed_alias) && (defined $$findReference_args{"FindReference_MR_reclassifications"}{$compressed_alias_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_reclassifications"}, $$findReference_args{"FindReference_focus_MR_reclassifications"}, $compressed_alias_utt, $focus_item_id);

		$assignment_source = "RECLASS ALIAS RULE Stored";
	} elsif (defined $$findReference_args{"FindReference_KWN"}{$compressed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_KWN"}, $$findReference_args{"FindReference_focus_KWN"}, $compressed_utt, $focus_item_id);

		$assignment_source = "KNOWN ASSIGNMENT RULE Stored";
	} elsif (defined $$findReference_args{"FindReference_KWN"}{$changed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_KWN"}, $$findReference_args{"FindReference_focus_KWN"}, $changed_utt, $focus_item_id);

		$assignment_source = "KNOWN ASSIGNMENT RULE Stored";
	} elsif (defined $$findReference_args{"FindReference_MR"}{$compressed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR"}, $$findReference_args{"FindReference_focus_MR"}, $compressed_utt, $focus_item_id);

		$assignment_source = "MAIN RULE Stored";
	} elsif ($try_compressed_alias && (defined $$findReference_args{"FindReference_KWN"}{$compressed_alias_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_KWN"}, $$findReference_args{"FindReference_focus_KWN"}, $compressed_alias_utt, $focus_item_id);

		$assignment_source = "KNOWN ASSIGNMENT ALIAS RULE Stored";
	} elsif ($try_wordbag_reclass && (defined $$findReference_args{"FindReference_MR_wordbag_reclassifications"}{$wordbag_compressed_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_wordbag_reclassifications"}, $$findReference_args{"FindReference_focus_MR_wordbag_reclassifications"}, $wordbag_compressed_utt, $focus_item_id);

		$assignment_source = "RECLASS WORDBAG RULE Stored";
	} elsif ($try_wordbag_reclass && (defined $$findReference_args{"FindReference_MR_wordbag_reclassifications"}{$wordbag_compressed_alias_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_wordbag_reclassifications"}, $$findReference_args{"FindReference_focus_MR_wordbag_reclassifications"}, $wordbag_compressed_alias_utt, $focus_item_id);

		$assignment_source = "RECLASS WORDBAG ALIAS RULE Stored";
	} elsif ($try_wordbag && (defined $$findReference_args{"FindReference_KWN_wordbag"}{$wordbag_compressed_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_KWN_wordbag"}, $$findReference_args{"FindReference_focus_KWN_wordbag"}, $wordbag_compressed_utt, $focus_item_id);

		$assignment_source = "KNOWN ASSIGNMENT WORDBAG RULE Stored";
	} elsif ($try_wordbag && (defined $$findReference_args{"FindReference_KWN_wordbag"}{$wordbag_compressed_alias_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_KWN_wordbag"}, $$findReference_args{"FindReference_focus_KWN_wordbag"}, $wordbag_compressed_alias_utt, $focus_item_id);

		$assignment_source = "KNOWN ASSIGNMENT WORDBAG ALIAS RULE Stored";
	} elsif ($try_wordbag && (defined $$findReference_args{"FindReference_MR_wordbag"}{$wordbag_compressed_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_wordbag"}, $$findReference_args{"FindReference_focus_MR_wordbag"}, $wordbag_compressed_utt, $focus_item_id);

		$assignment_source = " MAIN WORDBAG RULE Stored";
	} elsif ($try_wordbag && (defined $$findReference_args{"FindReference_MR_wordbag"}{$wordbag_compressed_alias_utt})) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_MR_wordbag"}, $$findReference_args{"FindReference_focus_MR_wordbag"}, $wordbag_compressed_alias_utt, $focus_item_id);

		$assignment_source = "MAIN WORDBAG ALIAS RULE Stored";
	} elsif (defined $$findReference_args{"FindReference_BR"}{$compressed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_BR"}, $$findReference_args{"FindReference_focus_BR"}, $compressed_utt, $focus_item_id);

		$assignment_source = "MAIN AMBIG RULE Stored";

		if (($item_category ne "") && ($item_id ne "")) {
			$ambig_active = 1;
		}
	} elsif (defined $$findReference_args{"FindReference_ER"}{$compressed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_ER"}, $$findReference_args{"FindReference_focus_ER"}, $compressed_utt, $focus_item_id);

		$assignment_source = "EXTERNAL RULE Stored";
	} elsif (defined $$findReference_args{"FindReference_GR"}{$compressed_utt}) {
		($test_item, $item_category, $item_id, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc) = getItemInfo($$findReference_args{"FindReference_GR"}, $$findReference_args{"FindReference_focus_GR"}, $compressed_utt, $focus_item_id);

		$assignment_source = "GENERAL RULE Stored";

		if (($item_category ne "") && ($item_id ne "")) {
			$generic_active = 1;
		}
	} else {
		if ($$meaning_args{"Main_Rule_count"} > 0) {
			if (defined $$findReference_args{"MR_rule_assignment"}{$j}) {
				($item_category, $item_id, @rest) = split ":", $$findReference_args{"MR_rule_assignment"}{$j};
				if (index($item_category, ":") != -1) {
					($item_category, $confirmed_as) = split ":", $item_category;
				} else {
				  ($item_category, $confirmed_as) = SetConfirm_As($item_category);
				}

				$assignment_source = "MAIN RULE";
				putItemInfo($$findReference_args{"FindReference_MR"}, $$findReference_args{"FindReference_focus_MR"}, $compressed_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);

				if (($compressed_alias_utt ne "") && ($compressed_alias_utt ne $compressed_utt)) {
					putItemInfo($$findReference_args{"FindReference_MR"}, $$findReference_args{"FindReference_focus_MR"}, $compressed_alias_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);
				}

				if ($wordbag_compressed_utt ne "") {
					putItemInfo($$findReference_args{"FindReference_MR_wordbag"}, $$findReference_args{"FindReference_focus_MR_wordbag"}, $wordbag_compressed_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);

					if (($wordbag_compressed_alias_utt ne "") && ($wordbag_compressed_alias_utt ne $wordbag_compressed_utt)) {
						putItemInfo($$findReference_args{"FindReference_MR_wordbag"}, $$findReference_args{"FindReference_focus_MR_wordbag"}, $wordbag_compressed_alias_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);
					}
				}
			}
		}

		if ($item_category eq "") {
			if ($$meaning_args{"Main_Ambig_Rule_count"} > 0) {
				$item_id = "";
				@$focus_item_id = ();

				if (defined $$findReference_args{"BR_rule_assignment"}{$j}) {
					($item_category, $item_id, @rest) = split ":", $$findReference_args{"BR_rule_assignment"}{$j};
					if (index($item_category, ":") != -1) {
						($item_category, $confirmed_as) = split ":", $item_category;
					} else {
					  ($item_category, $confirmed_as) = SetConfirm_As($item_category);
					}

					$assignment_source = "MAIN AMBIG RULE";
					putItemInfo($$findReference_args{"FindReference_BR"}, $$findReference_args{"FindReference_focus_BR"}, $compressed_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);
					if (($item_category ne "") && ($item_id ne "")) {
						$ambig_active = 1;
					}
				}
			}
		}

		if ($item_category eq "") {
			if ($$meaning_args{"General_Rule_count"} > 0) {
				$item_id = "";
				@$focus_item_id = ();

				if (defined $$findReference_args{"GR_rule_assignment"}{$j}) {
					($item_category, $item_id, @rest) = split ":", $$findReference_args{"GR_rule_assignment"}{$j};

					if (index($item_category, ":") != -1) {
						($item_category, $confirmed_as) = split ":", $item_category;
					} else {
					  ($item_category, $confirmed_as) = SetConfirm_As($item_category);
					}

					$assignment_source = "GENERAL RULE";
					putItemInfo($$findReference_args{"FindReference_GR"}, $$findReference_args{"FindReference_focus_GR"}, $compressed_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);

					if (($item_category ne "") && ($item_id ne "")) {
						$generic_active = 1;
					}
				}
			}
		}

		if ($item_category eq "") {
			if ($$meaning_args{"External_Rule_count"} > 0) {
				$item_id = "";
				@$focus_item_id = ();

				if (defined $$findReference_args{"ER_rule_assignment"}{$j}) {
					($item_category, $item_id, @rest) = split ":", $$findReference_args{"ER_rule_assignment"}{$j};

					if (index($item_category, ":") != -1) {
						($item_category, $confirmed_as) = split ":", $item_category;
					} else {
					  ($item_category, $confirmed_as) = SetConfirm_As($item_category);
					}

					$assignment_source = "EXTERNAL RULE";
					putItemInfo($$findReference_args{"FindReference_ER"}, $$findReference_args{"FindReference_focus_ER"}, $compressed_utt, $focus_item_id, $item_id, $test_item, $item_category, $confirmed_as, $first_loc, $rep_utt, $vanilla_rep_utt, $last_loc);
				}
			}
		}

	}

############################################################################
# If the sentence fails to parse, write it out and go on.
############################################################################
#

	if ((lc($item_category) =~ /\*blank\*/) || (lc($changed_utt) =~ /\*blank\*/)) {
		if ($make_failparse) {
			if ($do_classify) {
				$item_category = $$meaning_args{"reject_name"};
				$$classify_truth_hash{$changed_utt}{$$meaning_args{"reject_name"}}++;
				WriteClassifications($general_args, "item_category blank:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "ITEM_CATEGORY BLANK", $$meaning_args{"reject_name"}, $changed_utt, $original_utt, "", "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
			} elsif ($failparsefile_write_out eq "TESTPARSEFILEOUT") {
				printf ($failparsefile_write_out "%s\t".$$meaning_args{"reject_name"}."\n", $changed_utt);
				printf ($failparsefile_write_out_catonly "%s\t".$$meaning_args{"reject_name"}."\n", $changed_utt);
			} else {
				printf ($failparsefile_write_out "%s\n", $original_utt);
#				printf ($failparsefile_write_out_catonly "%s\n", $changed_utt);
			}
		}
	}

	if (($item_category eq "") || (($assignment_source =~ /Stored/) && (lc($item_category) eq lc($$meaning_args{"reject_name"}))) || ($do_classify && (lc($item_category) eq lc($$meaning_args{"reject_name"})))) {
		if ($changed_utt eq "") {
			$nl_blank_utts++;

			if ($make_failparse) {
				if ($do_classify) {
					$item_category = $$meaning_args{"reject_name"};
					$$classify_truth_hash{$changed_utt}{$$meaning_args{"reject_name"}}++;
					WriteClassifications($general_args, "changed_utt empty:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "CHANGED_UTT EMPTY", $$meaning_args{"reject_name"}, $changed_utt, $original_utt, "", "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
				} elsif ($do_testparsefile) {
					printf ($failparsefile_write_out "%s\t*BLANK*\n", $changed_utt);
					printf ($failparsefile_write_out_catonly "%s\t*BLANK*\n", $changed_utt);
				}
			}
		} else {
			if (($assignment_source =~ /Stored/) && (lc($item_category) eq lc($$meaning_args{"reject_name"})) || ($do_classify && (lc($item_category) eq lc($$meaning_args{"reject_name"})))) {
				$nl_not_handled++;
			}

			$$rule_sentence_hash{$changed_utt}{"*** No Rule ***"}{"*** No Rule ***"}++;
			if ($make_failparse) {
				if ($do_classify) {
				  $$classify_truth_hash{$changed_utt}{$$meaning_args{"reject_name"}}++;
				  $keep_string = "";
				  if (lc($changed_utt) !~ /\*blank\*/) {
					$keep_string = CheckSkipPhrase("loc10", $meaning_args, $wordnet_args, $changed_utt);
				  }

				  if (lc($item_category) eq lc($$meaning_args{"reject_name"})) {
					WriteClassifications($general_args, "changed_utt Reject:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "CHANGED_UTT REJECT", $$meaning_args{"reject_name"}, $changed_utt, $original_utt, $changed_utt, $keep_string, $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
				  } else {
					if ($original_utt =~ /Ramble Exclusion/) {
					  WriteClassifications($general_args, "RAMBLE_EXCLUSION:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "RAMBLE_EXCLUSION", "RAMBLE_EXCLUSION", $changed_utt, $original_utt, $changed_utt, "", $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
					} else {
					  WriteClassifications($general_args, "changed_utt No Rule:", $failparsefile_write_out, $failparsefile_write_out_catonly, $classifyfileout_vanilla, $classifyfileout_unknown, $wavfilename, "CHANGED_UTT NO RULE", "UNKNOWN", $changed_utt, $original_utt, $changed_utt, $keep_string, $classify_result_hash, $do_suppress_grammar, $wordlist_already_hash);
					}
				  }
				} elsif ($do_testparsefile) {
					printf ($failparsefile_write_out "%s\t".$$meaning_args{"reject_name"}."\n", $changed_utt);
					printf ($failparsefile_write_out_catonly "%s\t".$$meaning_args{"reject_name"}."\n", $changed_utt);
				} else {
					printf ($failparsefile_write_out "%s\n", $changed_utt);
				}
			}
		}
	}

	$changed_utt = $temp_changed_utt;
	$item_id = $$check_expand_hash{$changed_utt};
	if (not defined $item_id) {
		$item_id = ExpandVanilla($general_args, $meaning_args, $wordnet_args, $expand_vanilla, $changed_utt, $item_id);

		$$check_expand_hash{$changed_utt} = $item_id;
	}

#	$changed_utt =~ s/\ª/\?/g;
#	$item_id =~ s/\ª/\?/g;
	$j++;

	return ($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled);
}

sub FindKnownReferences
{

    my($general_args, $meaning_args, $findReference_args, $total_sentences, $used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $compressed_already_hash) = @_;

	my($compressed_sentence);
	my($compressed_alias_sentence);
	my($corrected_sentence);
	my($s_counter) = 0;
	my($i);
	my($j);

	$j = 0;
	for ($i = 0; $i < $total_sentences; $i++) {
		$compressed_sentence = @$compressed_sentence_array[$i];
		$corrected_sentence = @$sentence_corpus_array[$i];

		if ($compressed_sentence eq "Ç") {
		  $compressed_sentence = $corrected_sentence;
		}

		if ($corrected_sentence ne "") {
		  if ($compressed_sentence ne "") {
			$compressed_alias_sentence = MakeCompressedAliasSentence($general_args, $meaning_args, $compressed_sentence, $compressed_already_hash);
		  }

			if (defined $$findReference_args{"FindReference_KWN"}{$compressed_sentence}) {
				$$used_sentence_num_hash{$j}++;
				$s_counter++;
			} elsif (defined $$findReference_args{"FindReference_KWN"}{$compressed_alias_sentence}) {
				$$used_sentence_num_hash{$j}++;
				$s_counter++;
			} elsif (defined $$findReference_args{"FindReference_KWN"}{$corrected_sentence}) {
				$$used_sentence_num_hash{$j}++;
				$s_counter++;
			}

			$j++;
		}
	}

	return ($s_counter);

}

sub FindAllReferences
{

    my($calling_ref, $mode, $search_string, $total_sentences, $rule_assignment_hash, $rule_nofire_hash, $used_sentence_num_hash, $sentence_corpus_array, $compressed_sentence_array, $my_apply_rules) = @_;

	my($check_item_category);
	my($combo_sentence_order);
	my($first_level) = 1;
	my($i);
	my($item_category) = "";
	my($j);
	my($level);
	my($loc);
	my($match_len);
	my($min_loc);
	my($my_rule_count);
	my($new_general_word);
	my($new_item_category);
	my($new_source);
	my($prev_item_category) = "";
	my($prev_match_len);
	my($prev_min_loc);
	my($prev_test_positive);
	my($prev_test_words);
	my($rule_counter);
	my($rule_fired);
	my($rules_applied_count) = 0;
	my($search_changed_utt);
	my($search_compressed_utt);
	my($sent_begin);
	my($sent_end);
	my($sentence_order);
	my($skip_rule_test);
	my($so_end_loc);
	my($so_start_loc);
	my($test_positive);
	my($test_words);
	my(@sent_array);

	foreach $level ( sort { $b <=> $a } keys %{$my_apply_rules}) {
		$my_rule_count = scalar keys %{ $$my_apply_rules{$level} };

		if (!$first_level) {
			$search_string = "";
			for ($j = 0; $j < $total_sentences; $j++) {
				if (not defined $$used_sentence_num_hash{$j}) {
					$search_changed_utt = $$sentence_corpus_array[$j];
					$search_compressed_utt = @$compressed_sentence_array[$j];

					if ($search_compressed_utt eq "Ç") {
					  $search_compressed_utt = $search_changed_utt;
					}

					($search_string, $sent_begin, $sent_end) = storeLocationInfoOrderedCombo($search_compressed_utt, $search_string, $j);
				}
			}
		}

		if ($calling_ref ne "getmeaning"){
		  DebugPrint ("BOTH", 0, "Sub::FindAllReferences", $debug, $err_no++, "$mode: Applying $my_rule_count Level $level Rules");
		}

		$first_level = 0;
		for ($i = 0; $i <= ($my_rule_count - 1); $i++) {
			$check_item_category = 0;
			if ($$my_apply_rules{$level}{$i}[0] ne "") {
				if ($item_category eq "") {
					$check_item_category = 1;
				}
			}

			if (!$check_item_category) {
				$test_positive = $$my_apply_rules{$level}{$i}[1];
				$rule_fired = 0;

#				$test_negative = $$my_apply_rules{$level}{$i}[2];
				$new_item_category = $$my_apply_rules{$level}{$i}[3];

				$new_source = $test_positive;
				$new_general_word = $$my_apply_rules{$level}{$i}[4];

				$skip_rule_test = 0;
				if ($test_positive eq "") {
					$skip_rule_test = 1;
				}

				if (!$skip_rule_test) {
					$min_loc = -1;
					$item_category = $new_item_category;
					$rule_fired = 0;
					$rules_applied_count = 0;

					while ($search_string =~ /($test_positive)/g) {
						$rules_applied_count++;
						$rule_fired = 1;
						$test_words = $1;
						$match_len = length($test_words);
						$loc = pos $search_string;
						$min_loc = $loc - $match_len;
#						$min_loc = (pos $search_string) - 1;
						$so_start_loc = index($search_string, "[", $min_loc);
						$so_end_loc = index($search_string, "]", $so_start_loc);
						$sentence_order = substr($search_string, $so_start_loc+1, $so_end_loc-$so_start_loc-1);

						@sent_array = split /\+/, $sentence_order;
						foreach $combo_sentence_order (@sent_array) {
							if (not defined $$rule_assignment_hash{$combo_sentence_order}) {
#								$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words:$match_len:$min_loc:$test_positive";
#								$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words";
								$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words:$match_len:$min_loc";
								$$used_sentence_num_hash{$combo_sentence_order}++;
							} else {
								($prev_item_category, $prev_test_words, $prev_match_len, $prev_min_loc, $prev_test_positive) = split ":", $$rule_assignment_hash{$combo_sentence_order};

								if ((($prev_match_len < 2) && ($match_len >= 2)) || (($match_len >= $prev_match_len) && ($min_loc < $prev_min_loc)) || (($match_len > $prev_match_len) && ($min_loc <= $prev_min_loc))) {
#									$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words:$match_len:$min_loc:$test_positive";
#									$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words";
									$$rule_assignment_hash{$combo_sentence_order} = "$item_category:$test_words:$match_len:$min_loc";
								}
							}
						}

						pos $search_string = $so_end_loc;
					}

					pos $search_string = 0;

					if (!$rule_fired) {
						$$rule_nofire_hash{$test_positive}++;
					}

					if ($calling_ref ne "getmeaning"){
					  $rule_counter++;
					  if (($rule_counter+1)/500 == int(($rule_counter+1)/500)) {
						print "&".($rule_counter+1);
					  } elsif (($rule_counter+1)/100 == int(($rule_counter+1)/100)) {
						print "*".($rule_counter+1);
					  } elsif (($rule_counter+1)/10 == int(($rule_counter+1)/10)) {
						print ".";
					  }
					}
				}
			}
		}

		if ($calling_ref ne "getmeaning") {
		  print "\n";
		}
	}
}

sub GetRuleErrors
{

    my($checkrules, $varvalue, $varname_hash, $rule_error_nullor_hash, $rule_error_double_dollar_hash, $rule_error_badalias_hash, $rule_error_missingalias_hash, $rule_error_countparens_hash, $rule_error_emptyparens_hash) = @_;

	my($temp_varvalue, $hold_varvalue);
	my($tstr1, $tstr2, $tstr3, $tstr4, $tstr5);

	if ($checkrules) {
		if ($varvalue =~ /\$/) {
			while ($varvalue =~ /(\||\(| )\$((\w|\_)*)(\||\)| )/) {

				$tstr1 = $1;
				$tstr2 = $2;
				$tstr3 = $4;

				$tstr4 = $tstr1."\\\$".$tstr2.$tstr3;
				$tstr5 = $tstr1.":"."\$".$tstr2.":".$tstr3;

				$tstr4 =~ s/(\(|\)|\|)/\\$1/g;

				$varvalue =~ s/$tstr4/$tstr5/g;
			}
		}

		if ($varvalue =~ /\|\|/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\|\|/ >>> \|\| <<< /g;
			$$rule_error_nullor_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\$\$/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\$\$/ >>> \$\$ <<< /g;
			$$rule_error_double_dollar_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\:\:/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\:\:/ >>> \:\: <<< /g;
			$$rule_error_double_dollar_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\(\)/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\(\)/ >>> \(\) <<< /g;
			$$rule_error_emptyparens_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\|\)/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\|\)/ >>> \|\) <<< /g;
			$$rule_error_emptyparens_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\(\|/) {
			$temp_varvalue = $varvalue;
			$temp_varvalue =~ s/\(\|/ >>> \(\| <<< /g;
			$$rule_error_emptyparens_hash{$temp_varvalue}++;
		}

		if ($varvalue =~ /\$/) {
			if (($varvalue =~ /( |\||\()(\$((\w|\_)*)\:)/) || ($varvalue =~ /(\:\$((\w|\_)*))( |\||\()/)) {
				$hold_varvalue = $varvalue;
				while (($hold_varvalue =~ /( |\||\()(\$((\w|\_)*)\:)/)) {
					$tstr1 = $2;
					$tstr2 = $tstr1;
					$tstr1 =~ s/\$/\\\$/o;
					$temp_varvalue = $varvalue;
					$temp_varvalue =~ s/$tstr1/ >>> $tstr2 <<< /;
					$$rule_error_badalias_hash{$temp_varvalue}++;

					$hold_varvalue =~ s/$tstr1//;
				}

				$hold_varvalue = $varvalue;
				while (($hold_varvalue =~ /(\:\$((\w|\_)*))( |\||\()/)) {
					$tstr1 = $1;
					$tstr2 = $tstr1;
					$tstr1 =~ s/\$/\\\$/o;
					$temp_varvalue = $varvalue;
					$temp_varvalue =~ s/$tstr1/ >>> $tstr2 <<< /;
					$$rule_error_badalias_hash{$temp_varvalue}++;

					$hold_varvalue =~ s/$tstr1//;
				}
			}
		}

		$hold_varvalue = $varvalue;
		while ($hold_varvalue =~ /\:\$((\w|\_)*)\:/) {
			if (not defined $$varname_hash{$1}) {
				$tstr1 = $1;
				$temp_varvalue = $varvalue;
				$temp_varvalue =~ s/$tstr1/ >>> $tstr1 <<< /g;
				$$rule_error_missingalias_hash{$temp_varvalue}++;
		}

			$hold_varvalue =~ s/\:\$((\w|\_)*)\://o;
		}

		if (CountParens($varvalue)) {
			$$rule_error_countparens_hash{$varvalue}++;
		}
	}

	return ($varvalue);
}

############# END Rule Application SUBROUTINES #######################

######################################################################
######################################################################
############# Truth SUBROUTINES ######################################
######################################################################
######################################################################

sub makeTruthFiles
{
    my($general_args, $osr_args, $cat_args, $readtruth, $use_previous_test_sequence, $test_sequence, $total_truth_hash, $classify_truth_hash) = @_;

	my($blank_test_counter) = 0;
	my($blank_test_percent) = 3;
	my($corrected_sentence);
	my($current_percent);
	my($elem);
	my($filename);
	my($filename_counter) = 0;
	my($filename_gate) = 1;
	my($filename_minus);
	my($filename_total);
	my($filesize);
	my($i);
	my($int_part);
	my($item_category);
	my($line);
	my($max_blank_test_counter) = 0;
	my($mode) = "train";
	my($original_trans);
	my($pre_search_string) = "";
	my($pseudo_corrected_sentence);
	my($readlen);
	my($real_part);
	my($temp_blank_test_percent);
	my($temp_original_trans);
	my($temp_sentence2);
	my($temp_test_percent);
	my($temp_test_reject_name) = lc($$general_args{"test_reject_name"});
	my($test_counter) = 0;
	my($training_percent) = 90;
	my($truth_filename);
	my(@filename_sort_array);
	my(@read_truth_array);
	my(%truth_list_hash);

	if ($readtruth) {
	  $pre_search_string = "";

	  open(READTRUTH, "<"."slmdirect_results/createslmDIR_truth_files/temp_truth_file") or die "Couldn't open $!\n";
	  $filesize = -s READTRUTH;
	  $readlen = sysread READTRUTH, $pre_search_string, $filesize;
	  close (READTRUTH);

	  $pre_search_string = ChopChar($pre_search_string);

	  $pre_search_string =~ s/$char13\n/\º/g;
	  $pre_search_string =~ s/$char13/\º/g;
	  $pre_search_string =~ s/\n/\º/g;
	  $pre_search_string =~ tr/º/º/s;

	  @read_truth_array = split /\º/, $pre_search_string;

	  undef $pre_search_string;

	  if (!$$cat_args{"include_garbagereject"}) {
		open(TRUTHALLGARBAGE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/truth_all_garbage_reject_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_info_files\/truth_all_garbage_reject_".$$general_args{"grammar_type"};
	  }

	  foreach $elem (@read_truth_array) {
		  ($filename, $original_trans, $pseudo_corrected_sentence, $corrected_sentence) = split ":", $elem;
			$filename =~ s/\!/\:/g;
		  $temp_sentence2 = $corrected_sentence;
		  if (($corrected_sentence eq "") || ($corrected_sentence eq " ") || (lc($corrected_sentence) =~ /\*blank\*/)) {
			$temp_sentence2 = "__Blank__";
#			$corrected_sentence = "";
		  }

		  foreach $item_category ( sort { $a cmp $b } keys %{$$classify_truth_hash{$temp_sentence2}}) {
			if (($$cat_args{"include_garbagereject"}) || ($temp_sentence2 eq "__Blank__") || (lc($item_category) !~ /$temp_test_reject_name/)) {
			  $$total_truth_hash{"$filename"}{$original_trans}{$pseudo_corrected_sentence}{$temp_sentence2}++;
			} else {
			  if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY" || $$general_args{"grammar_type"} eq "NUANCE9") {
				print TRUTHALLGARBAGE $$osr_args{"test_slotname"}, ":$item_category:", $$osr_args{"test_confirm_as"}, ":$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$temp_sentence2\n";
			  } elsif ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
				print TRUTHALLGARBAGE "$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$temp_sentence2\n";
			  }
			}
		  }
	  }

	  close(TRUTHALLGARBAGE);

	  undef @read_truth_array;
	}

	open(TRUTHFILEOUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_".$$general_args{"grammar_type"};
	open(TRUTHFILEOUTVERIF,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_verify_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_verify_".$$general_args{"grammar_type"};
	open(TRUTHGARBAGE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/truth_training_garbage_reject_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_info_files\/truth_training_garbage_reject_".$$general_args{"grammar_type"};
	open(TRUTHCLASSIFY,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_training_input_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_training_input_".$$general_args{"grammar_type"};

	if (!$use_previous_test_sequence || ($use_previous_test_sequence && (not (-e "slmdirect_results\/createslmDIR_info_files\/info_truth_sequence")))) {
		open(SAVETRUTHSEQUENCE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/info_truth_sequence") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_truth_sequence";

		($test_sequence, $temp_test_percent, $temp_blank_test_percent) = split ":", $test_sequence;
		if ($temp_test_percent ne "") {
			$training_percent = 100 - $temp_test_percent;
		}

		if ($temp_blank_test_percent ne "") {
			$blank_test_percent = $temp_blank_test_percent;
		}

		if ($test_sequence eq "random") {
			@filename_sort_array = keys %{$total_truth_hash};
			fisher_yates_shuffle(\@filename_sort_array);
		} elsif ($test_sequence eq "fileorder") {
			@filename_sort_array = sort { $a cmp $b } keys %{$total_truth_hash};
		} elsif ($test_sequence eq "reversefileorder") {
			@filename_sort_array = sort { $b cmp $a } keys %{$total_truth_hash};
		} elsif ($test_sequence eq "none") {
			@filename_sort_array = keys %{$total_truth_hash};
			$training_percent = 100;
		} elsif ($test_sequence eq "alltest") {
			@filename_sort_array = sort { $a cmp $b } keys %{$total_truth_hash};
		}

		$filename_total = scalar (@filename_sort_array);

		if (($test_sequence eq "alltest") || ($training_percent == 0)) {

			$mode = "test";
			$filename_gate = 0;
			$training_percent = 0;

			$test_counter = $filename_total;
			$max_blank_test_counter = $test_counter * $blank_test_percent/100;

			if ($max_blank_test_counter < 1) {
			  $max_blank_test_counter = 0;
			}

			close (TRUTHFILEOUT);
			close (TRUTHFILEOUTVERIF);
			close (TRUTHGARBAGE);
			close (TRUTHCLASSIFY);

			unlink "slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_".$$general_args{"grammar_type"}, "slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file_verify_".$$general_args{"grammar_type"}, "slmdirect_results\/createslmDIR_info_files\/truth_training_garbage_reject_".$$general_args{"grammar_type"}, "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_training_input_".$$general_args{"grammar_type"};

			open(TRUTHFILEOUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_".$$general_args{"grammar_type"};
			open(TRUTHFILEOUTVERIF,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_verify_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_verify_".$$general_args{"grammar_type"};
			open(TRUTHGARBAGE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/truth_test_garbage_reject_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_info_files\/truth_test_garbage_reject_".$$general_args{"grammar_type"};
			open(TRUTHCLASSIFY,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input_".$$general_args{"grammar_type"};
		}

	} else {
		open(SAVETRUTHSEQUENCE,"<"."slmdirect_results\/createslmDIR_info_files\/info_truth_sequence") or die "cant open "."slmdirect_results\/createslmDIR_info_files\/info_truth_sequence";

		while (<SAVETRUTHSEQUENCE>) {
			$line = ChopChar($_);
			push (@filename_sort_array, $line);
		}

		$filename_total = scalar (@filename_sort_array);

	}

	foreach $filename (@filename_sort_array) {
		$filename_minus = $filename;
		$filename_minus =~ s/\"//g;
		if (!$use_previous_test_sequence) {
			print SAVETRUTHSEQUENCE "$filename\n";
		}

		if ($filename_gate) {
			$current_percent = (($filename_counter/$filename_total) * 100);
			$int_part = int($current_percent);
			$real_part = $current_percent - $int_part;

			if ($real_part > 0) {
				if ($real_part >= 0.5) {
					$current_percent = $int_part + 1;
				} else {
					$current_percent = $int_part;
				}
			}

			if ($current_percent > $training_percent) {
				if (scalar (keys %{$$cat_args{"truth_knowncats"}}) > 0) {
					foreach $item_category ( sort { $a cmp $b } keys %{$$cat_args{"truth_knowncats"}}) {
						foreach $original_trans ( sort { $a cmp $b } keys %{$$cat_args{"truth_knowncats"}{$item_category}}) {
							foreach $pseudo_corrected_sentence ( sort { $a cmp $b } keys %{$$cat_args{"truth_knowncats"}{$item_category}{$original_trans}}) {
								foreach $corrected_sentence ( sort { $a cmp $b } keys %{$$cat_args{"truth_knowncats"}{$item_category}{$original_trans}{$pseudo_corrected_sentence}}) {
									if (($corrected_sentence ne "") && ($corrected_sentence ne " ") && ($item_category !~ /NOINTENT/)) {
										$truth_filename = "NO_FILENAME_ADDITIONAL_TRUTH";
										for ($i = 0; $i < $$cat_args{"truth_knowncats"}{$item_category}{$original_trans}{$pseudo_corrected_sentence}{$corrected_sentence}; $i++) {
											if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY" || $$general_args{"grammar_type"} eq "NUANCE9") {
											  print TRUTHFILEOUT $$osr_args{"test_slotname"}, "$:$item_category:", $$osr_args{"test_confirm_as"}, ":$item_category\t$truth_filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
											  print TRUTHFILEOUTVERIF $$osr_args{"test_slotname"}, ":", $$general_args{"test_reject_name"}, ":", $$osr_args{"test_confirm_as"}, ":", $$general_args{"test_reject_name"}, "\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";

											  if ($item_category =~ /$$general_args{"test_reject_name"}/) {
												print TRUTHGARBAGE $$osr_args{"test_slotname"}, ":$item_category:", $$osr_args{"test_confirm_as"}, ":$item_category\t$truth_filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
											  }
											} elsif ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
											  print TRUTHFILEOUT "$item_category\t$truth_filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
											  print TRUTHFILEOUTVERIF $$general_args{"test_reject_name"}, "\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";

											  if ($item_category =~ /$$general_args{"test_reject_name"}/) {
												print TRUTHGARBAGE "$item_category\t$truth_filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
											  }
											}
										}
									}
								}
							}
						}
					}
				}

				close (TRUTHFILEOUT);
				close (TRUTHFILEOUTVERIF);
				close (TRUTHGARBAGE);
				close (TRUTHCLASSIFY);

				open(TRUTHFILEOUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_".$$general_args{"grammar_type"};
				open(TRUTHFILEOUTVERIF,">"."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_verify_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file_verify_".$$general_args{"grammar_type"};
				open(TRUTHGARBAGE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/truth_test_garbage_reject_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_info_files\/truth_test_garbage_reject_".$$general_args{"grammar_type"};
				open(TRUTHCLASSIFY,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input_".$$general_args{"grammar_type"};;

				if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
					open(TRUTHTRANS,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_transcriptions_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_transcriptions_".$$general_args{"grammar_type"};
				}

				$mode = "test";

				$test_counter = $filename_total - $filename_counter;
				$max_blank_test_counter = $test_counter * $blank_test_percent/100;

				if ($max_blank_test_counter < 1) {
					$max_blank_test_counter = 0;
				}

				$filename_gate = 0;
			}
		}

		foreach $original_trans ( sort { $a cmp $b } keys %{$$total_truth_hash{$filename}}) {
			$temp_original_trans = $original_trans;
			foreach $pseudo_corrected_sentence ( sort { $a cmp $b } keys %{$$total_truth_hash{$filename}{$original_trans}}) {
				if ($mode eq "train") {
					if (($pseudo_corrected_sentence eq "") || ($pseudo_corrected_sentence eq " ") || (lc($pseudo_corrected_sentence) =~ /\*blank\*/) || (lc($pseudo_corrected_sentence) =~ /__blank__/)) {
						next;
					}
				} elsif ($mode eq "test") {
#					$blank_test_counter++;
					if ((($pseudo_corrected_sentence eq "") || ($pseudo_corrected_sentence eq " ") || (lc($pseudo_corrected_sentence) =~ /\*blank\*/) || (lc($pseudo_corrected_sentence) =~ /__blank__/)) && ($blank_test_counter > $max_blank_test_counter)) {
						next;
					}

					if (($pseudo_corrected_sentence eq "") || ($pseudo_corrected_sentence eq " ") || (lc($pseudo_corrected_sentence) =~ /\*blank\*/) || (lc($pseudo_corrected_sentence) =~ /__blank__/)) {
					$blank_test_counter++;
					}
				}

				foreach $corrected_sentence ( sort { $a cmp $b } keys %{$$total_truth_hash{$filename}{$original_trans}{$pseudo_corrected_sentence}}) {
					$temp_sentence2 = $corrected_sentence;
					if (($corrected_sentence eq "") || ($corrected_sentence eq " ") || (lc($corrected_sentence) =~ /\*blank\*/)) {
						$temp_sentence2 = "__Blank__";
						$corrected_sentence = "";
					}

#					print "original_trans=",scalar(keys %{$$total_truth_hash{$filename}}), ", corrected_sentence=", scalar(keys %{$$total_truth_hash{$filename}{$original_trans}{$pseudo_corrected_sentence}}), ", item_category=", scalar(keys %{$$classify_truth_hash{$temp_sentence2}}), "\n";

					foreach $item_category ( sort { $a cmp $b } keys %{$$classify_truth_hash{$temp_sentence2}}) {
						$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
						if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY" || $$general_args{"grammar_type"} eq "NUANCE9") {
						  print TRUTHFILEOUT $$osr_args{"test_slotname"}, ":$item_category:", $$osr_args{"test_confirm_as"}, ":$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
						  print TRUTHFILEOUTVERIF $$osr_args{"test_slotname"}, ":", $$general_args{"test_reject_name"}, ":", $$osr_args{"test_confirm_as"}, ":", $$general_args{"test_reject_name"}, "\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";

						  $filename =~ s/\"//g;

						  if ($mode eq "train") {
							print TRUTHCLASSIFY "$filename\t$corrected_sentence\t$item_category\n";
						  } else {
							print TRUTHCLASSIFY "$filename\t$corrected_sentence\t$item_category\n";
						  }

						  $truth_list_hash{$filename} = $$osr_args{"test_slotname"}.";$item_category ".$$osr_args{"test_confirm_as"}.";$item_category";

						  if ($item_category =~ /$$general_args{"test_reject_name"}/) {
							print TRUTHGARBAGE $$osr_args{"test_slotname"}, ":$item_category:", $$osr_args{"test_confirm_as"}, ":$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
						  }
						} elsif ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
						  print TRUTHFILEOUT "$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
						  print TRUTHFILEOUTVERIF $$general_args{"test_reject_name"}, "\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";

						  $filename =~ s/\"//g;

						  if ($mode eq "train") {
							print TRUTHCLASSIFY "$filename\t$corrected_sentence\t$item_category\n";
						  } else {
							print TRUTHCLASSIFY "$filename\t$corrected_sentence\t$item_category\t$original_trans\n";

							print TRUTHTRANS "FILE: $filename\nTRANSCRIPTION: $corrected_sentence\n\n";
						  }

						  if ($item_category =~ /$$general_args{"test_reject_name"}/) {
							print TRUTHGARBAGE "$item_category\t$filename\t$original_trans\t$pseudo_corrected_sentence\t$corrected_sentence\n";
						  }
						}

						last;
					}
				}
			}
		}

		$filename_counter++;
	}

	close (TRUTHFILEOUT);
	close (TRUTHFILEOUTVERIF);
	close (TRUTHGARBAGE);
	close (TRUTHCLASSIFY);
	close (TRUTHTRANS);

	close (SAVETRUTHSEQUENCE);

	if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY" || $$general_args{"grammar_type"} eq "NUANCE9") {
	  open(TRUTHTESTLIST,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_list_".$$general_args{"grammar_type"}) or die "cant write "."slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_list_".$$general_args{"grammar_type"};
	  foreach $filename ( sort { $a cmp $b } keys %truth_list_hash) {
		print TRUTHTESTLIST "{$filename\t", $truth_list_hash{$filename}, "}\n";
	  }

	  close (TRUTHTESTLIST);
	}
}

sub FillTruth
{
    my($general_args, $cleaning_args, $osr_args, $truthfile, $guide_hash, $truth_type) = @_;

	my($elem);
	my($elem1);

	my($sentence2);
	my($item_category1);
	my($item_category2);
	my($item_category3);

	my($sent_count);

	my(@truth_contents1_array);
	my(@truth_contents2_array);

	my($location);
	my($original_trans);
	my($clean_trans1);
	my($clean_trans2);

	open(TRUTHIN1,"<$truthfile") or die "cant open $truthfile";
	(@truth_contents1_array) = (<TRUTHIN1>);
	close(TRUTHIN1);

	open(TRUTHOUT1,">truth_"."$truth_type") or die "cant write truth_"."$truth_type";

	foreach $elem (@truth_contents1_array) {
		$elem = ChopChar($elem);
		($item_category1, $location, $original_trans, $clean_trans1, $clean_trans2) = split "\t", $elem;
		print TRUTHOUT1 "$original_trans\n";
	}

	close(TRUTHOUT1);

	CALL_SLMDirect(0, 0, $vanilla_callingProg, $$general_args{"main_language"}, "", "", $$general_args{"grammar_type"}, "", "createslm_init_nlrules", "temp1234_"."$truth_type", $$general_args{"downcase_utt"}, $$cleaning_args{"removerepeats"}, "truth_"."$truth_type", "", ".", 0, "", 0, "", "");

	open(TRUTHIN2,"<temp1234_"."$truth_type"."_category_only") or die "cant open temp1234_"."$truth_type"."_category_only";
	(@truth_contents2_array) = (<TRUTHIN2>);
	close(TRUTHIN2);

	open(TRUTHOUT2,">$truthfile"."_new") or die "cant write $truthfile"."_new";
	open(TEMPOUT,">temp_truth_error") or die "cant write temp_truth_error";

	$sent_count = 0;
	foreach $elem (@truth_contents1_array) {
		$elem = ChopChar($elem);
		($item_category1, $location, $original_trans, $clean_trans1, $clean_trans2) = split "\t", $elem;

		$elem1 = $truth_contents2_array[$sent_count];
		($sentence2, $item_category2) = split "\t", $elem1;
		$item_category2 = ChopChar($item_category2);

		$item_category3 = $$guide_hash{$sentence2};

		if (not defined $item_category3) {
			print TEMPOUT "NOT DEFINED: truthcat=$item_category1, retraincat=$item_category2, original_trans=$original_trans, sentence2=$sentence2, truth_type=$truth_type\n\n";
			$item_category3 = "*Blank*";
		} else {
			$clean_trans2 = MakeCleanTrans($general_args, $cleaning_args, 0, 0, 0, 0, $item_category2, $original_trans);

#			$item_category3 = "$test_slotname_nuance_speakfreely:".uc($item_category3).":$test_confirm_as_nuance_speakfreely:".uc($item_category3);
			$item_category3 = $$osr_args{"test_slotname"}.":".$item_category3.":".$$osr_args{"test_confirm_as"}.":".$item_category3;

			if ($item_category1 ne $item_category3) {
				print TEMPOUT "CHANGE: truthcat:$item_category1 to retraincat:$item_category3 for $original_trans, truth_type=$truth_type\n\n";
			}

			print TRUTHOUT2 "$item_category3\t$location\t$original_trans\t$sentence2\t$clean_trans2\n";
		}

		$sent_count++;
	}

	close(TRUTHOUT2);
	close (TEMPOUT);

	unlink "temp1234_"."$truth_type";
	unlink "temp1234_category_only_"."$truth_type";
}

############# END Truth SUBROUTINES ##################################

######################################################################
######################################################################
############# Sentence and Word Processing SUBROUTINES ###############
######################################################################
######################################################################

sub ProcessNounVerbSentences
{
   my($main_language, $do_temp_array, $debug, $merge_noun_verb_alias_hash, $merge_prefix_hash) = @_;

   my($counter) = 1;
   my($elem);
   my($level_count) = 1000;
   my($prev_level_count) = 0;
   my($rep_alias);
   my($rep_body);
   my($retval);

   my(%storage_merge_hash);
   my(%comp_hash);
   my(@rep_array);
   my(@expanded_array);

   foreach $elem (@$do_temp_array) {

	   $elem = ChopChar($elem);

	   $elem =~ s/\?\(((\w|\^|\ |\?|\||\_|\')+)\)/\(\(\<NULL\>\)\|\($1\)\)/g;
	   $elem =~ s/\?((\w|\^|\_|\')+)/\(\<NULL\>\|$1\)/g;
	   $elem =~ s/((\w|\_|\')+)/\($1\)/g;
	   $elem =~ s/\^\(((\w|\_|\')+)\)/\^$1/g;
	   $elem =~ s/\(NULL\)/NULL/g;
	   if ($elem =~ /\?/) {
		   $elem = ProcessOPTIONALs_SLMDirect ($debug, $elem, 0);
	   }

	   while (index($elem, "^") != -1) {
		   if ($elem =~ /\^((\w|\_)+)/) {
			   $rep_alias = $1;
			   $rep_body = $$merge_noun_verb_alias_hash{$rep_alias};
			   $elem =~ s/\^$rep_alias/\($rep_body\)/g;
		   } else {
			   last;
		   }
	   }

	   $retval = $elem;
	   if ($retval =~ /[\||\?]/) {
		   undef %storage_merge_hash;
		   undef %comp_hash;
		   @rep_array = ();
		   @expanded_array = ();

		   ($retval) = ProcessPrefix(0, $retval, 0, 0, $level_count, $counter, \%storage_merge_hash, $merge_prefix_hash, \%comp_hash, \@rep_array, \@expanded_array);

		   $prev_level_count = $level_count;
		   $level_count += 1000;
	   } else {
		   $retval =~ s/\(//g;
		   $retval =~ s/\)//g;
		   $$merge_prefix_hash{$retval}++;
	   }
   }
}

sub ExpandSentence {

    my($symbol, $temp_word_array, $sent_list_array) = @_;

	my($additional_split_found) = 0;
	my($elem1) = 0;
	my($i);
	my($sent_list_counter) = 0;
	my($sentence) = "";
	my($split_count) = 0;
	my($split_found) = 0;
	my($temp_symbol);
	my(@loop_word_array);
	my(@temp_sent_list_array);
	my(@temp_subword_array);

	foreach $elem1 (@$temp_word_array) {
		if ($split_found) {
			for ($i = 0; $i < $sent_list_counter; $i++) {
				$temp_sent_list_array[$i] = stringBuilder($temp_sent_list_array[$i], $elem1, " ");
			}

			if (index($elem1, "$symbol") != -1) {
				$additional_split_found = 1;
			}
		} elsif (index($elem1, "$symbol") != -1) {
			$split_found = 1;
			$temp_symbol = quotemeta($symbol);
			@temp_subword_array = split /$temp_symbol/, $elem1;

			$split_count = scalar(@temp_subword_array);

			while ($i < $split_count) {
				$temp_sent_list_array[$i] = $sentence." ".$temp_subword_array[$i];
				$i++;
			}

			$sent_list_counter = $i;

		} else {
		  $sentence = stringBuilder($sentence, $elem1, " ");
		}
	}

	if (!$split_found) {
		push @$sent_list_array, $sentence;
	} else {
		if ($additional_split_found) {
			foreach $elem1 (@temp_sent_list_array) {
				(@loop_word_array) = split " ", $elem1;

				ExpandSentence ($symbol, \@loop_word_array, $sent_list_array);
			}
		} else {
			foreach $elem1 (@temp_sent_list_array) {
				push @$sent_list_array, $elem1;
			}
		}
	}
}

sub GenWordList
{
   my($main_language, $sentence, $wordlist_already_hash) = @_;

   my($word_list) = "";

   if (defined $$wordlist_already_hash{$sentence}) {
	 $word_list = $$wordlist_already_hash{$sentence};
   } else {
#   $sentence =~ s/\[|\]|\(|\)|\+|\?|\-|\_|\*|\$/ /g;
	 $sentence =~ s/\[|\]|\(|\)|\+|\?|\-|\*|\$/ /g;

	 $sentence = TrimChars($sentence);

	 $word_list = join " ", sort { $a cmp $b } split " ", $sentence;

	 $$wordlist_already_hash{$sentence} = $word_list;
   }

   return($word_list);
}

sub GenWordListRemoveStopWords
{
   my($meaning_args, $wordnet_args, $sentence, $wordlist_already_hash) = @_;

   my($compressed_sentence) = "";
   my($pos) = 0;
   my($skip_string) = "";
   my($success) = 1;
   my($word_list) = "";
   my(@sent_to_rule_array);

   if (defined $$wordlist_already_hash{$sentence}) {
	 $word_list = $$wordlist_already_hash{$sentence};
   } else {
#   $sentence =~ s/\[|\]|\(|\)|\+|\?|\-|\_|\*|\$/ /g;
	 $sentence =~ s/\[|\]|\(|\)|\+|\?|\-|\*|\$/ /g;

	 $sentence = TrimChars($sentence);

	 (@sent_to_rule_array) = split " ", $sentence;
	 while ($pos < scalar (@sent_to_rule_array)) {
	   ($success, $pos, $skip_string, $compressed_sentence) = TestSkipPhrase ("FILTER", $meaning_args, $wordnet_args, \@sent_to_rule_array, $pos, $skip_string, $compressed_sentence);
	 }

	 if ($compressed_sentence ne "") {
	   $word_list = join " ", sort { $a cmp $b } split " ", $compressed_sentence;
	 } else {
	   $word_list = join " ", sort { $a cmp $b } split " ", $sentence;
	 }

	 $$wordlist_already_hash{$sentence} = $word_list;
   }

   return($word_list);
}

sub CheckWordList
{
  my($word_list_hash, $itemname2utt_hash) = @_;

  my($elem1);
  my($elem2);
  my($word_list_count);

  $word_list_count = 0;
  foreach $elem1 ( sort { $a cmp $b } keys %{$word_list_hash}) {
	if ((scalar keys %{$$word_list_hash{$elem1}}) > 1) {
	  if ($word_list_count == 0) {
		$word_list_count++;

		open(SENTERROR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_generated_grammar_conflicts") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_generated_grammar_conflicts";

		DebugPrint ("BOTH", 2, "CheckWordList", $debug, $err_no++, "GENERATED GRAMMAR INCONSISTENCIES: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_generated_grammar_conflicts");
	  }

	  print SENTERROR "$elem1: \n";

	  print SENTERROR "\tCategories:\n";
	  foreach $elem2 ( sort { $a cmp $b } keys %{$$word_list_hash{$elem1}}) {
		print SENTERROR "\t\t$elem2\n";
	  }

	  print SENTERROR "\n\tOriginal Sentences:\n";
	  $elem1 =~ s/ filler//g;

	  foreach $elem2 ( sort { $a cmp $b } keys %{$$itemname2utt_hash{$elem1}}) {
		$elem2 =~ s/\:/\: /g;
		print SENTERROR "\t\t$elem2\n";
	  }

	  print SENTERROR "\n";
	}
  }

  close (SENTERROR);

  if ($word_list_count == 0) {
	unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_possible_generated_grammar_conflicts";
  }
}

sub StoreInitialWords
{
  my($general_args, $corrected_sentence) = @_;

  my($elem);
  my($word_list_file);
  my(@temp_word_array);

  $word_list_file = "slmdirect_results/createslmDIR_analyze_files/analyze_initial_words_list".$$general_args{"language_suffix"};
  collapseSentence($corrected_sentence, \@temp_word_array, 0, 1);

  open(WORDSOUT,">$word_list_file") or die "cant open $word_list_file";
  foreach $elem (sort { $a cmp $b } @temp_word_array) {
	if (lc($elem) !~ /\*blank\*/) {
	  print WORDSOUT "$elem\n";
	}
  }

  close(WORDSOUT);

  PutInVocab_Full("StoreInitialWords", $$general_args{"make_vocab"}, $$general_args{"full_vocab"}, \@temp_word_array);

#  scanVocabForAcronyms(\@temp_word_array);
  scanVocabForMisSpells($general_args, $word_list_file);
}


sub PutInVocab
{
   my($source, $make_vocab, $full_vocab_hash, $changed_utt) = @_;

	my(@vocab_array);
	my(@sub_vocab_array);
	my($i);
	my($j);

	if ($make_vocab) {
		@vocab_array = split " ", RemoveChar("_", $changed_utt);

		for ($i = 0; $i < (scalar @vocab_array); $i++) {
			if (index($vocab_array[$i],"/") != -1) {
				@sub_vocab_array = split "/", $vocab_array[$i];
				for ($j = 0; $j < (scalar @sub_vocab_array); $j++) {
					if (($sub_vocab_array[$j] =~ /[a-zA-Z]/) && ($sub_vocab_array[$j] !~ /\$|\*|\#|\(|\)/)) {
						if (not defined $$full_vocab_hash{$sub_vocab_array[$j]}) {
						  if ($sub_vocab_array[$j] ne "throatwarblermangrove") {
							$$full_vocab_hash{$sub_vocab_array[$j]}++;
						  }
						}
					}
				}
			} else {
				if (($vocab_array[$i] =~ /[a-zA-Z]/) && ($vocab_array[$i] !~ /\$|\*|\#|\(|\)/)) {
					if (not defined $$full_vocab_hash{$vocab_array[$i]}) {
					  if ($vocab_array[$i] ne "throatwarblermangrove") {
						$$full_vocab_hash{$vocab_array[$i]}++;
					  }
					}
				}
			}
		}
	}
}

sub PutInVocab_Full
{
   my($source, $make_vocab, $full_vocab_hash, $vocab_array) = @_;

	my($elem);

	if ($make_vocab) {
		foreach $elem (@$vocab_array) {
			if (($elem =~ /[a-zA-Z]/) && ($elem !~ /\$|\*|\#|\(|\)/)) {
				if (not defined $$full_vocab_hash{$elem}) {
				  if ($elem ne "throatwarblermangrove") {
					$$full_vocab_hash{$elem}++;
				  }
				}
			}
		}
	}
}

sub scanVocabForMisSpells
{
  my($general_args, $word_list_file) = @_;

  my($cmd);
  my($word);
  my(@misspells_array);

  $cmd = "cat slmdirect_results/createslmDIR_analyze_files/analyze_initial_words_list | aspell list --ignore=1 --validate-words --ignore-case --dont-suggest -l ".$$general_args{"main_language"}." | sort | uniq > slmdirect_results/createslmDIR_temp_files/temp_complete_misspells\n";

  system ($cmd);

  open(TEMP_MISSPELLS,"<slmdirect_results/createslmDIR_temp_files/temp_complete_misspells")|| die "cant open: slmdirect_results/createslmDIR_temp_files/temp_complete_misspells";
  (@misspells_array) = (<TEMP_MISSPELLS>);
  close(TEMP_MISSPELLS);

  if (scalar(@misspells_array) > 0) {
	open(MISSPELLS,">slmdirect_results/createslmDIR_analyze_files/analyze_misspells")|| die "cant open: slmdirect_results/createslmDIR_analyze_files/analyze_misspells";

	foreach $word (@misspells_array) {
	  $word = ChopChar($word);
	  $word = TrimChars($word);
	  if(not defined $$general_args{"spell_checker"}{$word}) {
		print MISSPELLS "$word\n";
	  }
	}
  } else {
	unlink "slmdirect_results/createslmDIR_analyze_files/analyze_misspells";
  }

  close(MISSPELLS);
}

sub scanVocabForAcronyms
{
  my($vocab_array) = @_;

  my($new_word);
  my($parsefile) = "34KandInitCombined_modified";
  my($word);
  my(%no_vowels_hash);
  my(%one_vowel_hash);
  my(%the_rest_hash);
  my(%two_vowels_hash);

  foreach $word (@$vocab_array) {
	if ($word !~ /\$|\*|\#|\(|\)/) {
	  if ($word ne "throatwarblermangrove") {
		if ($word !~ /[aeiouAEIOU]/) {
		  $no_vowels_hash{$word}++;
		} elsif (($word =~ /(aa)|(ii)|(uu)|(AA)|(II)|(UU)/)) {
		  $one_vowel_hash{$word}++;
		} else {
		  $new_word = $word;
		  $new_word =~ s/[aeiouAEIOU]//;
		  if ($new_word !~ /[aeiouAEIOU]/) {
			$one_vowel_hash{$word}++;
		  } else {
			$new_word =~ s/[aeiouAEIOU]//;
			if ($new_word !~ /[aeiouAEIOU]/) {
			  $two_vowels_hash{$word}++;
			} else {
			  $the_rest_hash{$word}++;
			}
		  }
		}
	  }
	}
  }

  if ((scalar(keys %no_vowels_hash) > 0) || (scalar(keys %one_vowel_hash > 0)) || (scalar(keys %two_vowels_hash) > 0) || (scalar(keys %the_rest_hash) > 0)) {
	open(PACRONYMS,">potential_acronyms.txt")|| die "cant open: potential_acronyms.txt";

	if (scalar(keys %no_vowels_hash) > 0) {
	  print PACRONYMS "Potential acronyms: no vowels\n";
	  print PACRONYMS "-----------------------------\n";
	  foreach $word ( sort { $a cmp $b } keys %no_vowels_hash) {
		if ((lc($word) ne "a") && (lc($word) ne "i") && ($word !~ /\'/)) {
		  print PACRONYMS "$word\n";
		}
	  }

	  print PACRONYMS "\n";
	}

	if (scalar(keys %one_vowel_hash) > 0) {
	  print PACRONYMS "Potential acronyms: one vowel\n";
	  print PACRONYMS "-----------------------------\n";
	  foreach $word ( sort { $a cmp $b } keys %one_vowel_hash) {
		if ((lc($word) ne "a") && (lc($word) ne "i") && ($word !~ /\'/)) {
		  print PACRONYMS "$word\n";
		}
	  }

	  print PACRONYMS "\n";
	}

	if (scalar(keys %two_vowels_hash) > 0) {
	  print PACRONYMS "Potential acronyms: two vowels\n";
	  print PACRONYMS "-----------------------------\n";
	  foreach $word ( sort { $a cmp $b } keys %two_vowels_hash) {
		if ((lc($word) ne "a") && (lc($word) ne "i") && ($word !~ /\'/)) {
		  print PACRONYMS "$word\n";
		}
	  }

	  print PACRONYMS "\n";
	}

	if (scalar(keys %the_rest_hash) > 0) {
	  print PACRONYMS "Potential acronyms: the rest\n";
	  print PACRONYMS "-----------------------------\n";
	  foreach $word ( sort { $a cmp $b } keys %the_rest_hash) {
		if ((lc($word) ne "a") && (lc($word) ne "i") && ($word !~ /\'/)) {
		  print PACRONYMS "$word\n";
		}
	  }

	  print PACRONYMS "\n";
	}

  }

  close(PACRONYMS);
}

sub FilterAmbigWords {

    my($general_args, $cleaning_args, $my_elem) = @_;

	my($my_temp_elem);

	my($build_string);
	my($temp1);
	my($elem);
	my($elem1);
	my($elem2);
	my(@expand_rep_array);
	my(@temp_expand_array);
	my(@alt_expand_rep_array);

	my($expand_found);
	my($alt_expand_found);
	my($temp_expand);

	my(@out_array);

	if ($my_elem ne "" && $my_elem ne "0") {

		$my_temp_elem = $my_elem;
		if ($$general_args{"company_filter"} ne "") {
			$my_temp_elem =~ s/$$general_args{"company_filter"}//;
		}

		if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
			$my_temp_elem =~ s/\|\|/\)/g;
			$my_temp_elem =~ s/\|/\?\(/g;
		} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
			$my_temp_elem =~ s/\|\|/<\/item>/g;
			$my_temp_elem =~ s/\|/<item repeat=\"0\-1\">/g;
		}

		$expand_found = 0;
		foreach $elem (@{$$cleaning_args{"expand_grammar"}}) {
			$elem = ChopChar($elem);
			@expand_rep_array = split /\+/, $elem;

			$alt_expand_found = 0;
			@alt_expand_rep_array = ();
			if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
				$temp_expand = "\[";
				foreach $elem1 (@expand_rep_array) {
					$temp1 = $elem1;
					$temp1 =~ s/\(\?\!\\\'s\|s\)//g;

					if (index($temp1,">") != -1) {
						$alt_expand_found = 1;
						BuildRepStrings($temp1, \@out_array);

						foreach $elem2 (@out_array) {
							push @alt_expand_rep_array, $elem2;
							if (index($elem2, " ") != -1) {
								$elem2 = "(".$elem2.")";
							}

							$temp_expand = $temp_expand." ".$elem2;
						}
					} else {
						@temp_expand_array = split /\|/, $temp1;
						foreach $elem2 (@temp_expand_array) {
							push @alt_expand_rep_array, $elem2;

							if (index($elem2, " ") != -1) {
								$elem2 = "(".$elem2.")";
							}

							$temp_expand = $temp_expand." ".$elem2;
						}
					}
				}

				$temp_expand = $temp_expand."\]";
			} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
				$temp_expand = "<one-of>";
				foreach $elem1 (@expand_rep_array) {
					$temp1 = $elem1;
					$temp1 =~ s/\(\?\!\\\'s\|s\)//g;

					if (index($temp1,">") != -1) {
						$alt_expand_found = 1;
						BuildRepStrings($temp1, \@out_array);

						foreach $elem2 (@out_array) {
							push @alt_expand_rep_array, $elem2;
							$temp1 = "<item>".$elem2."</item>";
							$temp_expand = $temp_expand." ".$elem2;
						}
					} else {
						@temp_expand_array = split /\|/, $temp1;
						foreach $elem2 (@temp_expand_array) {
							push @alt_expand_rep_array, $elem2;
							$elem2 = "<item>".$elem2."</item>";
							$temp_expand = $temp_expand." ".$elem2;
						}
					}
				}

				$temp_expand = $temp_expand."</one-of>";
			}

			if ($alt_expand_found) {
				$build_string = join "|", @alt_expand_rep_array;

				if ($my_temp_elem =~ /($build_string)/) {
					foreach $elem1 (@alt_expand_rep_array) {
						if ($my_temp_elem =~ /\b$elem1\b/) {
							$my_temp_elem =~ s/\b$elem1\b/$temp_expand/g;

							$expand_found = 1;
							last;
						}
					}
				}
			} else {
				$build_string = join "|", @expand_rep_array;

				if ($my_temp_elem =~ /($build_string)/) {
					foreach $elem1 (@expand_rep_array) {
						if ($my_temp_elem =~ /\b$elem1\b/) {
							$my_temp_elem =~ s/\b$elem1\b/$temp_expand/g;

							$expand_found = 1;
							last;
						}
					}
				}
			}
		}

		if ($my_temp_elem =~ /(.*?(\w+_disk|\w+_inch|\w+_millimeter))/) {
			$temp1 = $2;
			$my_temp_elem =~ s/$temp1/\?\($temp1\)/g;
			$my_temp_elem =~ s/_/ /g;
		}

		$my_temp_elem = TrimChars($my_temp_elem);
	}

	return $my_temp_elem;
}

sub FilterRepeatsETC {

    my($in_string, $company_filter) = @_;

	$in_string =~ s/\bMI\b/mi/;
	$in_string =~ s/\bmi\b/mi/;
	$in_string =~ s/\(\?\!\((\w|\s|\|)+\)\)//g;
	$in_string =~ s/(\w{4,100}) ($1\s+)/$1 /g;
	$in_string =~ s/(\band\b|\bfor\b|\bweb\b) ($1\s+)/$1 /g;
	$in_string =~ s/$company_filter//;
	$in_string =~ s/^and\b|^with\b|^for\b//g;
	$in_string = TrimChars($in_string);

	return $in_string;

}

############# END Sentence and Word Processing SUBROUTINES ####################

######################################################################
######################################################################
############# GSL-Specific Processing SUBROUTINES ####################
######################################################################
######################################################################

sub DoBuildForGSL
{

    my($meaning_args, $wordnet_args, $do_build, $changed_utt) = @_;

	my($build_string);
	my($filler_count);
	my($gsl_filler_build_string);
	my($gsl_filler_counter);
	my($item_id) = "";

	if ($do_build) {
		($build_string, $filler_count, $gsl_filler_build_string, $gsl_filler_counter) = FillBuildStrings ($meaning_args, $wordnet_args, $changed_utt);

		if ($build_string ne "") {
			$item_id = $build_string;

			$item_id =~ s/_(\d+)FILLER(\d+)_/ \?(\*-filler-) /g;
			$item_id =~ s/_FILLER(\d+)_/ \?(\*-filler-) /g;
			$item_id =~ s/_(\d+)FILLER_/ \?(\*-filler-) /g;
			$item_id =~ s/_FILLER_/ \?(\*-filler-) /g;
		}
	}

	return ($item_id, $filler_count, $gsl_filler_build_string, $gsl_filler_counter);
}

sub ProcessRulesToGSL1
{
    my($debug, $strval, $startpos, $tcnt, $level_count, $counter, $storage_merge_hash, $comp_hash, $rep_array) = @_;

	my($retval) = $strval;
	my($subretval);
	my($loc);
	my($startchar);

	my($sub_level_count) = $level_count + 100;
	my($prev_sub_level_count) = 0;
	my($enclosure);
	my($endpos);

	my($elem);
	my($build_string);
	my(@part_array);

	DebugPrint ("", 1, "ProcessRulesToGSL1: Entry", $debug-1, $err_no++, "retval=$retval\n\n");


	$counter++;
	($loc, $startchar) = FindFirstChar($startpos+1, "(", "", "", $retval);
	if ($loc != -1) {
		while ($loc != -1) {
			$endpos = ThisGetClosure($loc, $startchar, $retval, length($retval));
			$enclosure = substr($retval, $loc, $endpos-$loc);
			($subretval) = ProcessRulesToGSL1($debug, $enclosure, 0, $tcnt+1, $sub_level_count, $counter, $storage_merge_hash, $comp_hash, $rep_array);

			$retval = substr($retval,0,$loc).$subretval.substr($retval, $endpos);

			if ($retval =~ /[\||\?]/) {
				($loc, $startchar) = FindFirstChar(1, "(", "", "", $retval);
			} else {
				$loc = -1;
			}

			$prev_sub_level_count = $sub_level_count;
			$sub_level_count += 100;
		}
	}

	$retval =~ s/\(//g;
	$retval =~ s/\)//g;

	@part_array = split /\|/, $retval;
	$build_string = "";
	foreach $elem (@part_array) {
		if ($build_string eq "") {
			$build_string = "{".$elem."}";
		} else {
			$build_string = $build_string." {".$elem."}";
		}

	}

	$retval = "{[".$build_string."]}";

	DebugPrint ("", 1, "ProcessRulesToGSL1: Exit", $debug-1, $err_no++, "retval=$retval\n\n");

	return ($retval);
}

sub CreateRulesToGSL1
{
    my($strval) = @_;

	my($build_string) = "";
	my($counter) = 1;
	my($elem);
	my($elem1);
	my($endpos);
	my($level_count) = 1000;
	my($loop_strval);
	my($prev_level_count) = 0;
	my($put_parens) = 0;
	my($retval);
	my($startpos) = 0;
	my($temp_strval);
	my(%comp_hash);
	my(%storage_merge_hash);
	my(@rep_array);
	my(@rules_array) = "";

	$strval =~ s/\\b//g;
	$temp_strval = $strval;
	$strval = lc($strval);

	if ($strval =~ /_(\d*)filler(\d*)_/) {
		$strval = substr($strval, 1, length($strval)-2);
		$strval =~ s/_(\d*)filler(\d*)_/\,/g;
	} else {
		$put_parens = 1;
		if (substr($strval, 0, 1) eq "(") {
			$endpos = ThisGetClosure(0, "(", $strval, length($strval));
			if ($endpos == (length($strval))) {
				$strval = substr($strval, 1, length($strval)-2);
			}
		} else {
#			$strval = "(".$strval.")";
		}
	}

	$strval = $temp_strval;

	(@rules_array) = split ",", $strval;

	foreach $elem (@rules_array) {

		$elem = ChopChar($elem);

		$loop_strval = $elem;
		if (substr($loop_strval, 0, 1) eq "(") {
			$endpos = ThisGetClosure(0, "(", $loop_strval, length($loop_strval));
			if ($endpos == (length($loop_strval))) {
#				$loop_strval = "(".$loop_strval.")";
				$loop_strval = substr($loop_strval, 1, length($loop_strval)-2);
			}
		}

		$startpos = 0;
		if (substr($loop_strval, 0, 1) eq "(") {
			$startpos = -1;
		}

		$retval = $loop_strval;

		if ($retval =~ /[\||\?]/) {
			undef %storage_merge_hash;
			undef %comp_hash;
			@rep_array = ();
			($retval) = ProcessRulesToGSL1(0, $retval, $startpos, 0, $level_count, $counter, \%storage_merge_hash, \%comp_hash, \@rep_array);

			$prev_level_count = $level_count;
			$level_count += 1000;
		}

		if (scalar (keys %{$storage_merge_hash{$retval}}) > 0) {
			foreach $elem1 ( sort { $a cmp $b } keys %{$storage_merge_hash{$retval}}) {
				$elem1 =~ s/\=/ /g;
				$build_string = stringBuilder($build_string, $elem1, " ?(*-filler-) ");
			}
		} else {
		  $build_string = stringBuilder($build_string, $retval, " ?(*-filler-) ");
		}
	}

	$build_string = "(".$build_string.")";
	$build_string =~ s/\{/\(/g;
	$build_string =~ s/\}/\)/g;

	return ($build_string);
}

############# END GSL-Specific Processing SUBROUTINES ################

######################################################################
######################################################################
############# Grammar Creation SUBROUTINES ###########################
######################################################################
######################################################################

sub Write_Output_Format {

    my($general_args, $cleaning_args, $direction, $assignment_source, $changed_utt, $filename, $filename_catonly, $do_testsentence, $company_filter, $focus_item_id, $ambig_active, $item_category, $format_van, $format_ambig, $format_van_xml, $format_ambig_xml, $loop_count) = @_;

	my($confirmed_as);
	my($elem);
	my($format_string);
	my($my_slot1);
	my($my_slot2);
	my($my_slot3);
	my($my_slot4);
	my($outstring) = "";
	my($temp_string);

	if ($do_testsentence) {
		foreach $elem (@$focus_item_id) {
			if ($elem ne "") {
				if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
					$elem =~ s/\ª/\?/g;
					$temp_string = "\n\tMeaning Assignment Source:\t$assignment_source\n\tGrammar Addition - NUANCE_GSL:\t".FilterAmbigWords($general_args, $cleaning_args, $elem)."\n";
				}

				if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
					$temp_string = "\n\tMeaning Assignment Source:\t\t$assignment_source\n\tGrammar Addition - NUANCE_SPEAKFREELY:\t<item>".FilterAmbigWords($general_args, $cleaning_args, $elem)."<\/item>\n";
				}

				if ($$general_args{"grammar_type"} eq "NUANCE9") {
					$temp_string = "\n\tMeaning Assignment Source:\t\t$assignment_source\n\tGrammar Addition - NUANCE9:\t<item>".FilterAmbigWords($general_args, $cleaning_args, $elem)."<\/item>\n";

				}

				if (lc $assignment_source eq "synonym") {
				  if ($loop_count == 1) {
					$temp_string = "\t\tSynonym Sentence List:\n\n";
					$temp_string = $temp_string."\t\t\t".FilterAmbigWords($general_args, $cleaning_args, $elem);
					DebugPrint ("BOTH", 1, "Write_Output_Format", $debug, $err_no++, "$temp_string");
				  } else {
					$temp_string = "\t\t\t".FilterAmbigWords($general_args, $cleaning_args, $elem);
					DebugPrint ("BOTH", 1, "Write_Output_Format", $debug, $err_no++, "$temp_string");
				  }
				} else {
				  DebugPrint ("BOTH", 1, "Write_Output_Format", $debug, $err_no++, "$temp_string");
				}
			}
		}
	}

	$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
	($item_category, $confirmed_as) = SetConfirm_As($item_category);

	$my_slot1 = $item_category;
	$my_slot2 = $confirmed_as;
	$my_slot3 = "";
	$my_slot4 = "";

	if ($confirmed_as eq "") {
		$my_slot2 = $item_category;
	}

	if ($do_testsentence) {
		if ($ambig_active) {
			$format_string = "\tMeaning:\t".$format_ambig."\n";
			$format_ambig_xml = "\tMeaning:\t".$format_ambig_xml."\n";
		} else {
			if ($item_category eq "...external...") {
				if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
					$format_string = "\tMeaning:\t\t<ExternalSlot \"EXTERNAL\">"."\n";
					$format_van_xml = "\tMeaning:\t\t<ExternalSlot \"EXTERNAL\">"."\n";
				} elsif ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
					$format_string = "\tMeaning:\t\t<tag>ExternalSlot='EXTERNAL'</tag>"."\n";
					$format_van_xml = "\tMeaning:\t\t<tag>ExternalSlot='EXTERNAL'</tag>"."\n";
				} elsif ($$general_args{"grammar_type"} eq "NUANCE9") {
					$format_string = "\tMeaning:\t\t<tag>ExternalSlot='EXTERNAL'</tag>"."\n";
					$format_van_xml = "\tMeaning:\t\t<tag>ExternalSlot='EXTERNAL'</tag>"."\n";
				}
			} else {
				$format_string = "\tMeaning:\t".$format_van."\n";
				$format_van_xml = "\tMeaning:\t".$format_van_xml."\n";
			}
		}
	} else {
		if ($item_category eq "...external...") {
			if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
				$format_string = "{<ExternalSlot \"EXTERNAL\">}";
			} elsif ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
				$format_string = "<tag>ExternalSlot='EXTERNAL'</tag>";
			} elsif ($$general_args{"grammar_type"} eq "NUANCE9") {
				$format_string = "<tag>ExternalSlot='EXTERNAL'</tag>";
			}
		} else {
			if ($ambig_active) {
				$format_string = $format_ambig;
			} else {
				$format_string = $format_van;
			}

			if ($direction eq "") {
				if ($my_slot3 eq "") {
					print $filename_catonly "$changed_utt\t$my_slot1\n";
				}
			}
		}
	}

	if (lc $assignment_source ne "synonym") {
		if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
			if ($my_slot3 eq "") {
				if ($direction eq "") {
					printf($filename $format_string, $my_slot1, $my_slot2);
				} else {
					$outstring = sprintf($format_string, $my_slot1, $my_slot2);
				}
			} elsif ($my_slot1 eq "") {
				if ($direction eq "") {
					printf($filename $format_string, $my_slot3, $my_slot4);
				} else {
					$outstring = sprintf($format_string, $my_slot3, $my_slot4);
				}
			} else {
				if ($item_category eq "...external...") {
					if ($direction eq "") {
						print $filename $format_string;
					} else {
						$outstring = $format_string;
					}
				} else {
					if ($direction eq "") {
						printf($filename $format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					} else {
						$outstring = sprintf($format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					}
				}
			}
		}

		if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
			if ($ambig_active) {
				$format_string = $format_ambig_xml;
			} else {
				$format_string = $format_van_xml;
			}

			if ($my_slot3 eq "") {
				$temp_string = sprintf($format_string, $my_slot1, $my_slot2);
				$temp_string =~ s/<tag>category=\'\'<\/tag>//g;

				if ($direction eq "") {
					print $filename $temp_string;
				} else {
					$outstring = $temp_string;
				}
			} elsif ($my_slot1 eq "") {
				if ($direction eq "") {
					printf($filename $format_string, $my_slot3, $my_slot4);
				} else {
					$outstring = sprintf($format_string, $my_slot3, $my_slot4);
				}
			} else {
				if ($item_category eq "...external...") {
					if ($direction eq "") {
						printf($filename $format_string);
					} else {
						$outstring = $format_string;
					}
				} else {
					if ($direction eq "") {
						printf($filename $format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					} else {
						$outstring = sprintf($format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					}
				}
			}
		}

		if ($$general_args{"grammar_type"} eq "NUANCE9") {
			if ($ambig_active) {
				$format_string = $format_ambig_xml;
			} else {
				$format_string = $format_van_xml;
			}

			if ($my_slot3 eq "") {
				$temp_string = sprintf($format_string, $my_slot1, $my_slot2);
				$temp_string =~ s/<tag>category=\'\'<\/tag>//g;

				if ($direction eq "") {
					print $filename $temp_string;
				} else {
					$outstring = $temp_string;
				}
			} elsif ($my_slot1 eq "") {
				if ($direction eq "") {
					printf($filename $format_string, $my_slot3, $my_slot4);
				} else {
					$outstring = sprintf($format_string, $my_slot3, $my_slot4);
				}
			} else {
				if ($item_category eq "...external...") {
					if ($direction eq "") {
						printf($filename $format_string);
					} else {
						$outstring = $format_string;
					}
				} else {
					if ($direction eq "") {
						printf($filename $format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					} else {
						$outstring = sprintf($format_string, $my_slot1, $my_slot2, $my_slot3, $my_slot4);
					}
				}
			}
		}
	}

	$outstring = ChopChar($outstring);

	return($outstring);
}

sub CreateMainGrammar {

	my($gen_grammar_elem_hash, $general_args, $wordnet_args, $cat_args, $cleaning_args, $nuance_gsl_args, $osr_args, $speakfreely_args, $nuance9_args, $meaning_args, $compressed_already_hash, $wordlist_already_hash, $referencetag_hash) = @_;

	my($absolute_path);
	my($actual_repeat_num);
	my($add_item_category);
	my($add_sentence_count) = 0;
	my($ambig_active);
	my($changed_utt);
	my($compressed_alias_sentence);
	my($compressed_sentence);
	my($confirmed_as);
	my($confirm_name);
	my($confirm_val);
	my($correct_total);
	my($corrected_sentence);
	my($elem);
	my($elem1);
	my($elem2);
	my($elem3);
	my($elem4);
	my($elem5);
	my($encoding) = setEncoding($$general_args{"main_language"});
	my($error_total);
	my($errors_found) = 0;
	my($evalfile);
	my($filename);
	my($filtered_utt);
	my($freq_max);
	my($gen_grammar_type);
	my($grammargenline);
	my($i);
	my($i_elem);
	my($item_category);
	my($item_category1);
	my($item_category2);
	my($line);
	my($loopcnt);
	my($loopcnt2);
	my($modified_item);
	my($ngram_order_found) = 0;
	my($nl_contains_product_total);
	my($nl_contains_product_total_nuance9);
	my($nl_contains_product_total_nuance_speakfreely);
	my($nl_itemcategories_hash);
	my($nl_total_itemcategories);
	my($nl_total_itemcategories_nuance9);
	my($nl_total_itemcategories_nuance_speakfreely);
	my($nl_total_processed);
	my($num_iterations_found) = 0;
	my($orig_sentence);
	my($original_sentences);
	my($pg_elem);
	my($probval);
	my($product_max);
	my($rep_or1);
	my($rep_or2);
	my($rep_or3);
	my($repeat_num);
	my($rulename);
	my($save_best_found) = 0;
	my($sent_count);
	my($sentence1);
	my($sentence2);
	my($slen);
	my($tlen);
	my($slot_name);
	my($slot_val);
	my($source_file);
	my($squeezed_utt);
	my($ssm_output_filename_found) = 0;
	my($target_sentences) = "slmdirect_results\/createslm_test_sentences";
	my($temp_changed_utt);
	my($temp_elem);
	my($temp_elem2);
	my($temp_filtered_utt);
	my($temp_word_list);
	my($tot_classified_as);
	my($tot_per_cat_count);
	my($truthfile_eval);
	my($truthfile_test);
	my($truthfile_train);
	my($utt_source);
	my($wordbag_compressed_sentence);
	my($word_found);
	my($word_rp);
	my(%correct_hash);
	my(%error_hash);
	my(%guide_hash);
	my(%keep_min_freq_hash);
	my(%nl_contains_product);
	my(%nl_contains_product_nuance9);
	my(%nl_contains_product_nuance_speakfreely);
	my(%nl_generic_itemname_hash);
	my(%nl_generic_itemname_nuance_speakfreely_hash);
	my(%nl_generic_itemname_nuance9_hash);
	my(%nl_itemcategories_hash);
	my(%nl_itemcategories_nuance9_hash);
	my(%nl_itemcategories_nuance_speakfreely_hash);
	my(%nl_itemcategories_pc_hash);
	my(%nl_itemcategories_pc_nuance9_hash);
	my(%nl_itemcategories_pc_nuance_speakfreely_hash);
	my(%nl_itemcategories_rp_nuance9_hash);
	my(%nl_itemname_grammar_hash);
	my(%nl_itemname_grammar_nuance9_hash);
	my(%nl_itemname_grammar_filtered_nuance9_hash);
	my(%nl_itemname_grammar_rp_nuance9_hash);
	my(%nl_itemname_grammar_nuance_speakfreely_hash);
	my(%nl_total_itemname_hash);
	my(%nl_total_itemname_nuance9_hash);
	my(%nl_total_itemname_nuance_speakfreely_hash);
	my(%nuance9_TAGGEDCORPUS_hash);
	my(%nuance_speakfreely_TAGGEDCORPUS_hash);
	my(%itemname2utt_hash);
	my(%speakfreely_meaning_hash);
	my(%taggedcorpus_gsl_hash);
	my(%test_hash);
	my(%total_classified_as);
	my(%total_per_cat_count);
	my(%training_hash);
	my(%word_list_hash);
	my(@cat_array);
	my(@gram_elems);
	my(@guide_array);
	my(@pg_array);
	my(@rep_array);
	my(@sentcat_contents1_array);
	my(@sentcat_contents2_array);
	my(@test_array);

	open(NEWPARSEFILECOMP,"sort "."slmdirect_results\/createslmDIR_info_files\/info_compressed_transcription_total | uniq -c | sort -nr |") or die "cant fork $!";
	while (<NEWPARSEFILECOMP>) {
	  $elem = $_;
	  $elem = ChopChar($elem);

	  $elem =~ s/      ((\d)+) //g;
	  if ($elem ne "") {
		$slen = length($elem);
		$temp_elem = $elem;
		$temp_elem =~ s/ //g;
		$tlen = length($temp_elem);

		if (($slen - $tlen) < 6) {
		  $keep_min_freq_hash{$elem}++;
		}
	  }
	}

	foreach $grammargenline ( sort { $a cmp $b } keys %{$gen_grammar_elem_hash}) {

		($gen_grammar_type, $changed_utt, $filtered_utt, $item_category, $ambig_active, $utt_source, $repeat_num) = split ":", $grammargenline;

		$item_category =~ s/\, /,/g;
		($gen_grammar_type, $temp_changed_utt, $temp_filtered_utt, $confirmed_as, $temp_elem, $rulename) = retrieveGrammarElements($general_args, $cleaning_args, $gen_grammar_elem_hash, $gen_grammar_type, $changed_utt, $filtered_utt, $item_category, $ambig_active);

		$actual_repeat_num = $repeat_num * $$gen_grammar_elem_hash{$grammargenline};
#		print "herewww333: grammargenline=$grammargenline, gen_grammar_type=$gen_grammar_type, changed_utt=$changed_utt, temp_changed_utt=$temp_changed_utt, temp_filtered_utt=$temp_filtered_utt, temp_elem=$temp_elem, item_category=$item_category, rulename=$rulename, confirmed_as=$confirmed_as, ambig_active=$ambig_active, utt_source=$utt_source, repeat_num=$repeat_num, actual_repeat_num=$actual_repeat_num\n";

		$nl_total_processed += $actual_repeat_num;

		if ($gen_grammar_type eq "NUANCE_GSL_FILLER") {
			if ($temp_changed_utt !~ /-filler-/) {
				for ($i = 0; $i < $actual_repeat_num; $i++) {
					$taggedcorpus_gsl_hash{RemoveChar("_", $temp_changed_utt)}++;
				}
			}

			$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem, $wordlist_already_hash);
			$itemname2utt_hash{$temp_word_list}{"gsl_filler:$temp_elem:$item_category"} += $actual_repeat_num;

			($item_category, $item_category, $elem3) = Set_Elem_Format("", "NUANCE_GSL", 0, $item_category, $item_category, $$nuance_gsl_args{"test_slotname"}, $$nuance_gsl_args{"test_confirm_as"}, "", \%speakfreely_meaning_hash, $$general_args{"test_reject_name"});

			$nl_itemname_grammar_hash{$elem3}{$temp_elem} += $actual_repeat_num;
			$nl_total_itemname_hash{$elem3} += $actual_repeat_num;

			$nl_itemcategories_pc_hash{$elem3} = $item_category.":".$confirmed_as;
			$nl_itemcategories_hash{$elem3} += $actual_repeat_num;
			$nl_total_itemcategories += $actual_repeat_num;

			$nl_contains_product_total += $actual_repeat_num;
			$nl_contains_product{$utt_source} += $actual_repeat_num;
		}

		if ($gen_grammar_type eq "NUANCE_GSL") {
			if ($temp_changed_utt !~ /-filler-/) {
				for ($i = 0; $i < $actual_repeat_num; $i++) {
					$taggedcorpus_gsl_hash{RemoveChar("_", $temp_changed_utt)}++;
				}
			}

			($item_category, $confirmed_as, $elem3) = Set_Elem_Format($temp_changed_utt, "NUANCE_GSL", $ambig_active, $item_category, $confirmed_as, $$nuance_gsl_args{"test_slotname"}, $$nuance_gsl_args{"test_confirm_as"}, "", \%speakfreely_meaning_hash, $$general_args{"test_reject_name"});

			$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem, $wordlist_already_hash);
			$itemname2utt_hash{$temp_word_list}{"$temp_changed_utt:$item_category"} += $actual_repeat_num;

			$nl_itemname_grammar_hash{$elem3}{$temp_elem} += $actual_repeat_num;
			$nl_total_itemname_hash{$elem3} += $actual_repeat_num;

			$nl_itemcategories_pc_hash{$elem3} = $item_category.":".$confirmed_as;
			$nl_itemcategories_hash{$elem3} += $actual_repeat_num;
			$nl_total_itemcategories += $actual_repeat_num;

			$nl_contains_product_total += $actual_repeat_num;
			$nl_contains_product{$utt_source} += $actual_repeat_num;
		}

		if ($gen_grammar_type eq "NUANCE_SPEAKFREELY") {
			($rulename, $confirmed_as, $elem3) = Set_Elem_Format($temp_changed_utt, "NUANCE_SPEAKFREELY", $ambig_active, $item_category, $confirmed_as, $$osr_args{"test_slotname"}, $$osr_args{"test_confirm_as"}, $rulename, \%speakfreely_meaning_hash, $$general_args{"test_reject_name"});

			if (not defined $nuance_speakfreely_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}{$elem3}) {
				if (scalar keys %{ $nuance_speakfreely_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}} > 0) {
					DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "***ERROR***: Category Conflict\n\n\n");
					foreach $elem ( sort { $a cmp $b } keys %{$nuance_speakfreely_TAGGEDCORPUS_hash{$temp_changed_utt}}) {
						DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "\t[$elem]:\n\n\n");
						foreach $elem1 ( sort { $a cmp $b } keys %{$nuance_speakfreely_TAGGEDCORPUS_hash{$temp_changed_utt}{$elem}}) {
							DebugPrint ("BOTH", 1, "CreateMainGrammar", $debug, $err_no++, "[$elem1]");
						}
					}

					DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "\tENTERING:$changed_utt AS $item_category\n\n\n");
				}
			}

			$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem, $wordlist_already_hash);

			$itemname2utt_hash{$temp_word_list}{"$temp_changed_utt:$item_category"} += $actual_repeat_num;

			$nuance_speakfreely_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}{$elem3} += $actual_repeat_num;

			$temp_elem = FilterAmbigWords($general_args, $cleaning_args, $temp_changed_utt);
			$nl_itemname_grammar_nuance_speakfreely_hash{$elem3}{$temp_elem} += $actual_repeat_num;
			$nl_total_itemname_nuance_speakfreely_hash{$elem3} += $actual_repeat_num;

			$nl_itemcategories_pc_nuance_speakfreely_hash{$elem3} = $rulename;
			$nl_itemcategories_nuance_speakfreely_hash{$elem3} += $actual_repeat_num;
			$nl_total_itemcategories_nuance_speakfreely += $actual_repeat_num;

			$nl_contains_product_total_nuance_speakfreely += $actual_repeat_num;
			$nl_contains_product_nuance_speakfreely{$utt_source} += $actual_repeat_num;

			$filtered_utt = $temp_filtered_utt;
			if ($filtered_utt ne $temp_changed_utt) {
				$nuance_speakfreely_TAGGEDCORPUS_hash{RemoveChar("_", $filtered_utt)}{$elem3} += $actual_repeat_num;
			}
		}

		if ($gen_grammar_type eq "NUANCE9") {
			($rulename, $confirmed_as, $elem3) = Set_Elem_Format($temp_changed_utt, "NUANCE9", $ambig_active, $item_category, $confirmed_as, $$osr_args{"test_slotname"}, $$osr_args{"test_confirm_as"}, $rulename, \%speakfreely_meaning_hash, $$general_args{"test_reject_name"});

			if (not defined $nuance9_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}{$elem3}) {
				if (scalar keys %{ $nuance9_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}} > 0) {
					DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "***ERROR***: Category Conflict\n\n\n");
					foreach $elem ( sort { $a cmp $b } keys %{$nuance9_TAGGEDCORPUS_hash{$temp_changed_utt}}) {
						DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "\t[$elem]:\n\n\n");
						foreach $elem1 ( sort { $a cmp $b } keys %{$nuance9_TAGGEDCORPUS_hash{$temp_changed_utt}{$elem}}) {
							DebugPrint ("BOTH", 1, "CreateMainGrammar", $debug, $err_no++, "[$elem1]");
						}
					}

					DebugPrint ("LOGONLY", 1, "CreateMainGrammar", $debug, $err_no++, "\tENTERING:$changed_utt AS $item_category\n\n\n");
				}
			}

			$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem, $wordlist_already_hash);
			$itemname2utt_hash{$temp_word_list}{"$temp_changed_utt:$item_category"} += $actual_repeat_num;

			$nuance9_TAGGEDCORPUS_hash{RemoveChar("_", $temp_changed_utt)}{$elem3} += $actual_repeat_num;

			$temp_elem = FilterAmbigWords($general_args, $cleaning_args, $temp_changed_utt);
			$nl_itemname_grammar_nuance9_hash{$elem3}{$temp_elem} += $actual_repeat_num;
			$nl_total_itemname_nuance9_hash{$elem3} += $actual_repeat_num;

			$nl_itemcategories_pc_nuance9_hash{$elem3} = $rulename;
			$nl_itemcategories_nuance9_hash{$elem3} += $actual_repeat_num;
			$nl_total_itemcategories_nuance9 += $actual_repeat_num;

			$nl_contains_product_total_nuance9 += $actual_repeat_num;
			$nl_contains_product_nuance9{$utt_source} += $actual_repeat_num;

			$filtered_utt = FilterAmbigWords($general_args, $cleaning_args, $temp_filtered_utt);
#			$filtered_utt = $temp_filtered_utt;
			if ($filtered_utt ne $temp_changed_utt) {
				$nuance9_TAGGEDCORPUS_hash{RemoveChar("_", $filtered_utt)}{$elem3} += $actual_repeat_num;
				$nl_itemname_grammar_filtered_nuance9_hash{$elem3}{$temp_elem} = $filtered_utt;
				if ($$nuance9_args{"do_robust_parsing"}) {
				  $nl_itemname_grammar_rp_nuance9_hash{$elem3}{$filtered_utt} += $actual_repeat_num;
				}
			}

		}
	}

	if ($$osr_args{"addtestfile"} ne "") {
		if ($$osr_args{"addtestfile"} eq "default") {
			$$osr_args{"addtestfile"} = "slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input";
		} else {
			($$osr_args{"addtestfile"}, $evalfile) = split ":", $$osr_args{"addtestfile"};
		}

		$truthfile_train = "slmdirect_results\/createslmDIR_truth_files\/createslm_training_truth_file";
		if (not -e $truthfile_train) {
			$truthfile_train = "";
		}

		$truthfile_test = "slmdirect_results\/createslmDIR_truth_files\/createslm_test_truth_file";
		if (not -e $truthfile_test) {
			$truthfile_test = "";
		}

		$truthfile_eval = "slmdirect_results\/createslmDIR_truth_files\/createslm_eval_truth_file";
		if (not -e $truthfile_eval) {
			$truthfile_eval = "";
		}

	}

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {

		if ($nl_total_processed) {
			WriteMainGrammar ($$general_args{"main_language"}, $$general_args{"main_grammar_name"}, $$nuance_gsl_args{"pfsg_name"}, $$general_args{"grammarbase"}, $nl_total_processed, $nl_contains_product_total, $$general_args{"filter_corpus"});
		}

		if ((scalar keys %nl_itemcategories_hash) > 0 ) {
			open(NLITEMNAMEGRAMMAR,">"."slmdirect_results\/".$$general_args{"grammarbase"}."_nuance_gsl_nl_items.grammar") or die "cant write NLITEMNAMEGRAMMAR";
			print NLITEMNAMEGRAMMAR "SLMItems [\n";

			foreach (@{$$nuance_gsl_args{"all_gram_elems"}}) {
				@gram_elems = ();
				$freq_max = $$general_args{"product_prefix_num"};
				($add_item_category, $elem3, @gram_elems) = split ":";
				$nl_itemcategories_pc_hash{$elem3} = "$add_item_category:$add_item_category";

				foreach $elem (@gram_elems) {
					if ($elem ne "") {
						if ($elem =~ /\d/) {
							$freq_max = $elem * $$general_args{"product_prefix_num"};

							next;
						}

						if ($freq_max < $$general_args{"min_freq"}) {
							$freq_max = $$general_args{"min_freq"};
						}

						$temp_elem = FilterAmbigWords($general_args, $cleaning_args, $elem);
						if ($temp_elem ne "") {
							$temp_elem = ApplyClassGrammars ($general_args, $cleaning_args, $add_item_category, $temp_elem);
							$nl_itemname_grammar_hash{$elem3}{$temp_elem} += $freq_max;
							$nl_total_itemname_hash{$elem3} += $freq_max;

							$nl_itemcategories_hash{$elem3} += $freq_max;
							$nl_total_itemcategories += $freq_max;
						}
					}
				}
			}

			foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_hash{$elem1} }) {
					if (defined $nl_itemname_grammar_hash{$elem1}{$elem2}) {
						$nl_generic_itemname_hash{$elem1}{$elem2} += $nl_itemname_grammar_hash{$elem1}{$elem2};
						$nl_itemname_grammar_hash{$elem1}{$elem2} = 0;
					}
				}
			}

			foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_hash) {
				$loopcnt = 0;
				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_hash{$elem1} }) {
					if ($nl_itemname_grammar_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
						$loopcnt++;
					} else {
						$nl_total_itemname_hash{$elem1} -= $nl_itemname_grammar_hash{$elem1}{$elem2};
						$nl_itemname_grammar_hash{$elem1}{$elem2} = 0;
					}
				}

				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_hash{$elem1} }) {
					if ($nl_generic_itemname_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
						$loopcnt++;
					} else {
						$nl_total_itemname_hash{$elem1} -= $nl_generic_itemname_hash{$elem1}{$elem2};
						$nl_generic_itemname_hash{$elem1}{$elem2} = 0;
					}
				}

				if ($loopcnt == 0) {
					$nl_itemcategories_hash{$elem1}--;
					$nl_total_itemcategories--;
				}
			}

			foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_hash) {
				$loopcnt = 0;
				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_hash{$elem1} }) {
					if ($nl_itemname_grammar_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {

						if ($loopcnt == 0) {
							printf(NLITEMNAMEGRAMMAR "\t[\t;\"%s\"\n", $nl_itemcategories_pc_hash{$elem1});
						}

						$loopcnt++;

						$temp_elem2 = $elem2;
						$temp_elem2 =~ s/\ª/\?/g;
						if ($$general_args{"normalization_level"} != 0) {
							printf(NLITEMNAMEGRAMMAR "\t\t(%s)~%s\n", $temp_elem2, $$general_args{"normalization_level"} + ($nl_itemname_grammar_hash{$elem1}{$elem2}/$nl_total_itemname_hash{$elem1}));
						} else {
							printf(NLITEMNAMEGRAMMAR "\t\t(%s)~%s\n", $temp_elem2, $nl_itemname_grammar_hash{$elem1}{$elem2}/$nl_total_itemname_hash{$elem1});
						}

						$temp_elem2 = $elem2;
						$temp_elem2 =~ s/\ª//g;
						$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

						$word_list_hash{$temp_word_list}{$elem1}++;
					}
				}

				$loopcnt2 = 0;
				$probval = 0;
				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_hash{$elem1} }) {
					if ($nl_generic_itemname_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {

						if ($loopcnt == 0) {
							printf(NLITEMNAMEGRAMMAR "\t[\t;\"%s\"\n", $nl_itemcategories_pc_hash{$elem1});
						}

						if ($loopcnt2 == 0) {
							print NLITEMNAMEGRAMMAR ";\t\t[\t;\"Generic Section\"\n";
						}

						$loopcnt++;
						$loopcnt2++;

						$temp_elem2 = $elem2;
						$temp_elem2 =~ s/\ª/\?/g;
						printf(NLITEMNAMEGRAMMAR "\t\t\t(%s)\n", $temp_elem2);
						$probval += $nl_generic_itemname_hash{$elem1}{$elem2};

						$temp_elem2 = $elem2;
						$temp_elem2 =~ s/\ª//g;
						$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

						$word_list_hash{$temp_word_list}{$elem1}++;
					}
				}

				if ($loopcnt2 > 0) {
					if ($$general_args{"normalization_level"} != 0) {
						printf(NLITEMNAMEGRAMMAR "\t\t\t(%s)~%3.30f\n", $elem2, $$general_args{"normalization_level"} + ($$general_args{"generic_scale_factor"}*$probval/$nl_total_itemname_hash{$elem1}));
					} else {
						printf(NLITEMNAMEGRAMMAR "\t\t\t(%s)~%3.30f\n", $elem2, $$general_args{"generic_scale_factor"}*$probval/$nl_total_itemname_hash{$elem1});
					}
				}

				if ($loopcnt > 0) {
					if ($$general_args{"normalization_level"} != 0) {
						printf(NLITEMNAMEGRAMMAR "\t]~%s %s\n\n", $$general_args{"normalization_level"} + ($nl_itemcategories_hash{$elem1}/$nl_total_itemcategories), $elem1);
					} else {
						printf(NLITEMNAMEGRAMMAR "\t]~%s %s\n\n", $nl_itemcategories_hash{$elem1}/$nl_total_itemcategories, $elem1);
					}
				}
			}

			print NLITEMNAMEGRAMMAR "]\n";

			close(NLITEMNAMEGRAMMAR);

			CheckWordList(\%word_list_hash, \%itemname2utt_hash);
		}

		open(TAGGEDCORPUS,">".$$general_args{"taggedcorpusfile"}) or die "cant write TAGGEDCORPUS";
		foreach $elem2 ( sort {  $a cmp $b } keys %taggedcorpus_gsl_hash) {
			if ($$general_args{"downcase_utt"}) {
				$elem2 = lc ($elem2);
			}

			for ($i = 0; $i < $taggedcorpus_gsl_hash{$elem2}; $i++) {
				print TAGGEDCORPUS "$elem2\n";
			}
		}

		if ($$general_args{"do_use_product_prefix"}) {
			foreach (@{$$nuance_gsl_args{"all_gram_elems"}}) {
				@gram_elems = ();
				($add_item_category, $elem3, @gram_elems) = split ":";
				$product_max = $$general_args{"product_prefix_num"};
				foreach $elem (@gram_elems) {
					if ($elem ne "") {

						if ($elem =~ /\d/) {
							$product_max = $elem * $$general_args{"product_prefix_num"};

							next;
						}

						@pg_array = ();

						if ( ($elem =~ /\[/) || ($elem =~ /\(/) ) {
							@pg_array = ParseGrammar($elem);
						} else {
							push @pg_array, $elem;
						}

						foreach $pg_elem (@pg_array) {
							foreach $elem1 (@{$$general_args{"product_prefix"}}) {
								if (( (substr($pg_elem,0,1) =~ /a|e|i|o|u/) && (($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")) ) || ((substr($pg_elem,0,1) !~ /a|e|i|o|u/) && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a"))) || ((($elem1 ne "an") && (substr($elem1,length($elem1)-3) ne " an")) && (($elem1 ne "a") && (substr($elem1,length($elem1)-2) ne " a")))) {
									if ( not ((substr($pg_elem,length($pg_elem)-1) eq "s") && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a") || ($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")))) {
										for ($i = 0; $i < $product_max; $i++) {
											print TAGGEDCORPUS "$elem1 $pg_elem\n";
										}
									}
								}
							}
						}
					}
				}
			}
		}

		close(TAGGEDCORPUS);

		open(BATCHFILE,">"."slmdirect_results\/slmp_compile_nuance_gsl.bat") or die "cant write BATCHFILE";
		print BATCHFILE "train-slm -corpus "."slmdirect_results\/createslm_tagged_corpus -slm ".$$general_args{"company_name"}."_3gram -vocab "."slmdirect_results\/createslm_vocab_uniq.sorted -n 3\n\n";

		print BATCHFILE "nuance-compile ".$$general_args{"company_name"}."_master English.America -o SLMDIRECT_GSL_PACKAGE -auto_pron -dont_flatten -write_missing_models ".$$general_args{"company_name"}.".missing_models -merge_dictionary ".$$general_args{"grammarbase"}.".dictionary\n";

		close(BATCHFILE);

		if ($$general_args{"run_bats"}) {
			my($cmd);
			$cmd = "cmd /c slmp_compile_nuance_gsl.bat>>"."slmdirect_results\/createslm_temp_bat_log";
			DebugPrint ("BOTH", 0.1, "CreateMainGrammar", $debug, $err_no++, "Running: slmp_compile_nuance_gsl.bat ...");
			system($cmd);
		}
	}

	if (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
		if ($$cat_args{"do_precision_recall"} && ($$osr_args{"addtestfile"} ne "")) {
			if (($$cat_args{"knowncats"} ne "") && ($truthfile_train ne "")) {
				open(TRUTHIN,"<"."slmdirect_results\/".$$cat_args{"knowncats"}.$$general_args{"language_suffix"}) or die "cant open ".$$cat_args{"knowncats"}.$$general_args{"language_suffix"};
				(@guide_array) = (<TRUTHIN>);
				close(TRUTHIN);

				foreach $elem (@guide_array) {
					($item_category, $orig_sentence, $corrected_sentence, $compressed_sentence, $compressed_alias_sentence, $wordbag_compressed_sentence, $squeezed_utt, $source_file) = split "\t", $elem;
					$guide_hash{$corrected_sentence} = $item_category;
				}

				FillTruth($general_args, $cleaning_args, $osr_args, $truthfile_train, \%guide_hash, "train");

				undef %guide_hash;
			}

			if (($$osr_args{"addtestfile"} ne "") && ($truthfile_test ne "")) {
				open(TRUTHIN,"<"."slmdirect_results\/".$$osr_args{"addtestfile"}) or die "cant open ".$$osr_args{"addtestfile"};
				(@guide_array) = (<TRUTHIN>);
				close(TRUTHIN);

				foreach $elem (@guide_array) {
					($filename, $corrected_sentence, $item_category, $orig_sentence) = split "\t", $elem;
					$guide_hash{$corrected_sentence} = $item_category;
				}

				FillTruth($general_args, $cleaning_args, $osr_args, $truthfile_test, \%guide_hash, "test");

				undef %guide_hash;
			}

			if (($evalfile ne "") && ($truthfile_eval ne "")) {
				open(TRUTHIN,"<"."slmdirect_results\/$evalfile") or die "cant open $evalfile";
				(@guide_array) = (<TRUTHIN>);
				close(TRUTHIN);

				foreach $elem (@guide_array) {
					($item_category, $orig_sentence, $corrected_sentence) = split "\t", $elem;
					$guide_hash{$corrected_sentence} = $item_category;
				}

				FillTruth($general_args, $cleaning_args, $osr_args, $truthfile_eval, \%guide_hash, "eval");

				undef %guide_hash;
			}

			$original_sentences = $$osr_args{"addtestfile"};

			open(SENTCATIN1,"<"."slmdirect_results\/$original_sentences") or die "cant open $original_sentences";
			(@sentcat_contents1_array) = (<SENTCATIN1>);
			close(SENTCATIN1);

			open(SENTCATOUT1,">$target_sentences") or die "cant write $target_sentences";

			foreach $elem (@sentcat_contents1_array) {
				($filename, $corrected_sentence, $item_category1, $orig_sentence) = split "\t", $elem;
				$item_category1 = NormCat($item_category1, $$general_args{"test_reject_name"});
				if (lc($item_category1) !~ /blank/) {
					$total_per_cat_count{$item_category1}++;
					$tot_per_cat_count++;
					$sentence1 = ChopChar($sentence1);

					print SENTCATOUT1 "$sentence1\n";
				}
			}

			close(SENTCATOUT1);

			CALL_SLMDirect(0, 0, $vanilla_callingProg, $$general_args{"main_language"}, "", "", $$general_args{"grammar_type"}, "", "createslm_init_nlrules", "temp1234", $$general_args{"downcase_utt"}, $$cleaning_args{"removerepeats"}, $target_sentences, "", ".", 0, "", 0, "", "");

			open(SENTCATIN2,"<temp1234_category_only") or die "cant open temp1234_category_only";
			(@sentcat_contents2_array) = (<SENTCATIN2>);
			close(SENTCATIN2);

			open(SENTPR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_precision_recall") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_precision_recall";

			$sent_count = 0;
			foreach $elem (@sentcat_contents1_array) {
				($item_category1, $sentence1) = split "\t", $elem;
				if (lc($item_category1) !~ /blank/) {
					$sentence1 = ChopChar($sentence1);
					$elem1 = $sentcat_contents2_array[$sent_count];
					($sentence2, $item_category2) = split "\t", $elem1;
					$item_category2 = ChopChar($item_category2);
					if ($item_category2 eq "") {
						$item_category2 = "*Blank*";
					}

					$item_category1 = lc($item_category1);
					$item_category2 = lc($item_category2);

					$total_classified_as{$item_category2}++;
					$tot_classified_as++;

					if ($item_category1 ne $item_category2) {
						$errors_found = 1;
						$error_hash{"$item_category1: $sentence1"}{"$item_category2: $sentence2"}++;

						$error_total++;
					} else {
						$correct_hash{$item_category1}++;
						$correct_total++;
					}

					$sent_count++;
				}
			}

			print SENTPR "Total Recall: (".$correct_total."/".$tot_per_cat_count."): ", $correct_total/$tot_per_cat_count, "\n";
			print SENTPR "Total Precision: (".$correct_total."/".$tot_classified_as."): ", $correct_total/$tot_classified_as, "\n\n";

#			foreach $elem ( sort { ($correct_hash{$b}/$total_per_cat_count{$b}) <=> ($correct_hash{$a}/$total_per_cat_count{$a}) } keys %total_per_cat_count) {
			foreach $elem ( sort {  $a cmp $b } keys %total_per_cat_count) {
				print SENTPR "Recall: (".$correct_hash{$elem}."/".$total_per_cat_count{$elem}."): $elem: ", $correct_hash{$elem}/$total_per_cat_count{$elem}, "\n";

				if ($total_classified_as{$elem} == 0) {
					print SENTPR "Precision: $elem: 0\n\n";
				} else {
					print SENTPR "Precision: (".$correct_hash{$elem}."/".$total_classified_as{$elem}."): $elem: ", $correct_hash{$elem}/$total_classified_as{$elem}, "\n\n";
				}
			}

			foreach $elem ( sort { $a cmp $b } keys %error_hash) {
				foreach $elem1 ( sort { $a cmp $b } keys %{$error_hash{$elem}}) {
					print SENTPR "Hand-Assigned: $elem\nRule-Assigned: $elem1\n\n";
				}
			}

			close(SENTPR);

			unlink "temp1234";
			unlink "temp1234_category_only";
		}
	}

# SpeakFreely
	if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
		if ($$general_args{"do_use_product_prefix"}) {
			foreach (@{$$osr_args{"all_gram_elems"}}) {
				@gram_elems = ();
				($add_item_category, $elem3, @gram_elems) = split ":";
				$product_max = $$general_args{"product_prefix_num"};
				foreach $elem (@gram_elems) {
					if ($elem ne "") {

						if ($elem =~ /\d/) {
							$product_max = $elem * $$general_args{"product_prefix_num"};

							next;
						}

						@pg_array = ();

						if ( ($elem =~ /\[/) || ($elem =~ /\(/) ) {
							@pg_array = ParseGrammar($elem);
						} else {
							push @pg_array, $elem;
						}

						foreach $pg_elem (@pg_array) {
							foreach $elem1 ($$general_args{"product_prefix"}) {
								if (( (substr($pg_elem,0,1) =~ /a|e|i|o|u/) && (($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")) ) || ((substr($pg_elem,0,1) !~ /a|e|i|o|u/) && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a"))) || ((($elem1 ne "an") && (substr($elem1,length($elem1)-3) ne " an")) && (($elem1 ne "a") && (substr($elem1,length($elem1)-2) ne " a")))) {
									if ( not ((substr($pg_elem,length($pg_elem)-1) eq "s") && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a") || ($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")))) {
										for ($i = 0; $i < $product_max; $i++) {
											$nuance_speakfreely_TAGGEDCORPUS_hash{"$elem1 $pg_elem"}{$elem3}++;
										}
									}
								}
							}
						}
					}
				}
			}
		}

#		if ($nl_total_processed) {
#			WriteMainGrammar_nuance_variant_xml ($$general_args{"main_language"}, "NUANCE_SPEAKFREELY", $$general_args{"main_grammar_name"}, $$general_args{"grammarbase"}, $nl_contains_product_total_nuance_speakfreely, $$general_args{"filter_corpus"}, $$cleaning_args{"top_skip"}, $$general_args{"tuning_version"}, $$general_args{"test_reject_name"}, $$speakfreely_args{"do_normal_slm"}, $$speakfreely_args{"do_robust_parsing"});
#		}

		if ((scalar keys %nl_itemcategories_nuance_speakfreely_hash) > 0 ) {
			if ($$speakfreely_args{"do_robust_parsing"}) {
#hereqaz999: indent candidate
				open(TRAINING_robust_parsing_nuance_speakfreely,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance_speakfreely_robust_parsing.xml") or die "cant write TRAINING_robust_parsing_nuance_speakfreely";
				print TRAINING_robust_parsing_nuance_speakfreely "<\?xml version=\"1.0\" encoding=\"ISO-8859-1\"\?>\n",
				"<grammar version=\"1\.0\" xmlns=\"http:\/\/www\.w3\.org\/2001\/06\/grammar\" xml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"concepts\"> <meta name=\"swirec_fsm_grammar\" ",
				"content=\"nuance_speakfreely_ngram_SP\.fsm\"\/> <meta name=\"swirec_fsm_wordlist\" content=\"nuance_speakfreely_ngram_SP\.wordlist\"\/>\n",
				"<conceptset id=\"concepts\" xmlns=\"http:\/\/www\.scansoft\.com\/grammar\">\n",
				"\t<concept>\n",
				"\t\t<ruleref uri=\"#SLMItems\"/>\n",
				"\t\t<tag>".$$osr_args{"test_slotname"}."=SLMItems.".$$osr_args{"test_slotname"}."</tag>\n",
				"\t\t<tag>".$$osr_args{"test_confirm_as"}."=SLMItems.".$$osr_args{"test_confirm_as"}."</tag>\n",
				"\t\t<tag>ITEM_NAME=SLMItems.".$$osr_args{"test_slotname"}."</tag>\n",
				"\t\t\t<tag>".$$osr_args{"test_slotname"}."=SLMItems.".$$osr_args{"test_slotname"}."</tag>\n",
				"\t\t<tag>".$$osr_args{"test_confirm_as"}."=SLMItems.".$$osr_args{"test_confirm_as"}."</tag>\n",
				"\t\t<tag>AMBIG_KEY=SLMItems.AMBIG_KEY</tag>\n",
				"\t\t<tag>CONFVAL=SLMItems.CONFVAL</tag>\n",
				"\t\t<tag>LITERAL=SLMItems.LITERAL</tag>\n\n",
				"\t<\/concept>\n",
				"<\/conceptset>\n\n";

				print TRAINING_robust_parsing_nuance_speakfreely "<rule id=\"SLMItems\">\n<one-of>\n";
			}
		}

		if ($$speakfreely_args{"do_normal_slm"}) {
#hereqaz101010: indent candidate
			open(NLITEMNAMEGRAMMAR_nuance_speakfreely,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance_speakfreely_nl_items.grxml") or die "cant write NLITEMNAMEGRAMMAR_nuance_speakfreely";
			print NLITEMNAMEGRAMMAR_nuance_speakfreely "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"ROOT\">\n\n",
			"\t<rule id=\"ROOT\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#SLMItems\"/>\n",
			"\t\t\t<tag>if(SLMItems.Item_Name) {ITEM_NAME=SLMItems.".$$osr_args{"test_slotname"}."}</tag>\n",
			"\t\t\t<tag>if(SLMItems.".$$osr_args{"test_confirm_as"}.") {".$$osr_args{"test_confirm_as"}."=SLMItems.".$$osr_args{"test_confirm_as"}."}</tag>\n",
#			"\t\t\t<tag>if(SLMItems.Ambig_Key) {AMBIG_KEY=SLMItems.Ambig_Key}</tag>\n",
			"\t\t\t<tag>if(SLMItems.".$$osr_args{"test_slotname"}.") {".$$osr_args{"test_slotname"}."=SLMItems.".$$osr_args{"test_slotname"}."}</tag>\n",
			"\t\t\t<tag>if(SLMItems.Literal) {LITERAL=SLMItems.Literal}</tag>\n",
			"\t\t\t<tag>if(SLMItems.Confval) {CONFVAL=SLMItems.Confval}</tag>\n",

			"\t\t</item>\n\t</rule>\n\n";

			print NLITEMNAMEGRAMMAR_nuance_speakfreely "<rule id=\"SLMItems\">\n<one-of>\n";
		}

		foreach (@{$$osr_args{"all_gram_elems_nuance_class_full_xml"}}) {
			@gram_elems = ();
			$freq_max = $$general_args{"product_prefix_num"};
			($add_item_category, $elem3, @gram_elems) = split ":";
			$add_item_category =~ s/ /_/g;
			$nl_itemcategories_pc_nuance_speakfreely_hash{$elem3} = $add_item_category;

			foreach $elem (@gram_elems) {
				if ($elem ne "") {
					if ($elem =~ /\d/) {
						$freq_max = $elem * $$general_args{"product_prefix_num"};

						next;
					}

					if ($freq_max < $$general_args{"min_freq"}) {
						$freq_max = $$general_args{"min_freq"};
					}

					$temp_elem = FilterAmbigWords($general_args, $cleaning_args, $elem);

					if ($temp_elem =~ /(\[(\w|\s)+\])+/) {
						$rep_or1 = $1;
						$rep_or2 = $1;

						$rep_or1 =~ s/\[/\\\[/g;
						$rep_or1 =~ s/\]/\\\]/g;

							$rep_or2 =~ s/\[//g;
							$rep_or2 =~ s/\]//g;

							(@rep_array) = split " ", $rep_or2;

							$rep_or3 = "\n\t\t<one-of>\n";

							foreach $i_elem (@rep_array) {
								$rep_or3 = $rep_or3."\t\t\t<item>$i_elem<\/item>\n";
							}

						$rep_or3 = $rep_or3."\t\t<\/one-of>\n\t";

						$temp_elem =~ s/$rep_or1/$rep_or3/g;
						$temp_elem = "\n\t\t".$temp_elem;
					}

					$temp_elem =~ s/\[/\n\t\t<one-of>\n<item>/g;
					$temp_elem =~ s/\]/<\/item>\n<\/one-of>\n/g;
					$temp_elem =~ s/\(/<item>/g;
					$temp_elem =~ s/\)/<\/item>\n/g;

					if ($temp_elem ne "") {
						$nl_itemname_grammar_nuance_speakfreely_hash{$elem3}{$temp_elem} += $freq_max;
						$nl_total_itemname_hash{$elem3} += $freq_max;

						$nl_itemcategories_nuance_speakfreely_hash{$elem3} += $freq_max;
						$nl_total_itemcategories_nuance_speakfreely += $freq_max;
					}
				}
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_pc_nuance_speakfreely_hash) {
			if (scalar keys %{$nl_itemname_grammar_nuance_speakfreely_hash{$elem1}} > 0) {
				$temp_elem = 0;
				foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance_speakfreely_hash{$elem1} }) {
					if ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2} >= $$general_args{"min_freq"}) {
						$temp_elem = 1;
						last;
					}
				}

				if ($temp_elem) {
					if ($$speakfreely_args{"do_robust_parsing"}) {
						print TRAINING_robust_parsing_nuance_speakfreely "$elem1\n";
					}

					if ($$speakfreely_args{"do_normal_slm"}) {
						print NLITEMNAMEGRAMMAR_nuance_speakfreely "$elem1\n";
					}
				}
			}
		}

		if ($$speakfreely_args{"do_robust_parsing"}) {
			print TRAINING_robust_parsing_nuance_speakfreely "<\/one-of>\n<\/rule>\n\n";
		}

		if ($$speakfreely_args{"do_normal_slm"}) {
		    print NLITEMNAMEGRAMMAR_nuance_speakfreely "<\/one-of>\n<\/rule>\n\n";
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance_speakfreely_hash) {
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance_speakfreely_hash{$elem1} }) {
				if (defined $nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2}) {
					$nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2} += $nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2};
					$nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2} = 0;
				}
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance_speakfreely_hash) {
			$loopcnt = 0;
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance_speakfreely_hash{$elem1} }) {
				if ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
					$loopcnt++;
				} else {
					$nl_total_itemname_hash{$elem1} -= $nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2};
					$nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2} = 0;
				}
			}

			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance_speakfreely_hash{$elem1} }) {
				if ($nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
					$loopcnt++;
				} else {
					$nl_total_itemname_hash{$elem1} -= $nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2};
					$nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2} = 0;
				}
			}

			if ($loopcnt == 0) {
				$nl_itemcategories_nuance_speakfreely_hash{$elem1}--;
				$nl_total_itemcategories_nuance_speakfreely--;
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance_speakfreely_hash) {
			$loopcnt = 0;
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance_speakfreely_hash{$elem1} }) {
				if ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {

					if ($loopcnt == 0) {
						if ($$speakfreely_args{"do_robust_parsing"}) {
							printf (TRAINING_robust_parsing_nuance_speakfreely "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance_speakfreely_hash{$elem1});
						}

						if ($$speakfreely_args{"do_normal_slm"}) {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance_speakfreely_hash{$elem1});
						}
					}

					$loopcnt++;

					if ($$speakfreely_args{"do_robust_parsing"}) {
						if ($$general_args{"normalization_level"} != 0) {
							printf (TRAINING_robust_parsing_nuance_speakfreely "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
						} else {
							printf (TRAINING_robust_parsing_nuance_speakfreely "\t<item weight=\"".$nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
						}
					}

					if ($$speakfreely_args{"do_normal_slm"}) {
						if ($$general_args{"normalization_level"} != 0) {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
							printf("\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
						} else {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "\t<item weight=\"".$nl_itemname_grammar_nuance_speakfreely_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
						}
					}

					$temp_elem2 = $elem2;
					$temp_elem2 =~ s/\ª//g;
					$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

					$word_list_hash{$temp_word_list}{$elem1}++;
				}
			}

			$loopcnt2 = 0;
			$probval = 0;
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance_speakfreely_hash{$elem1} }) {
				if ($nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {

					if ($loopcnt2 == 0) {
						if ($$speakfreely_args{"do_robust_parsing"}) {
							printf (TRAINING_robust_parsing_nuance_speakfreely "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance_speakfreely_hash{$elem1});
							print TRAINING_robust_parsing_nuance_speakfreely "\<\!-- \"Start Generic Section\"--\>\n";
						}

						if ($$speakfreely_args{"do_normal_slm"}) {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance_speakfreely_hash{$elem1});
							print NLITEMNAMEGRAMMAR_nuance_speakfreely "\<\!-- \"Start Generic Section\"--\>\n";
						}
					}

					$loopcnt++;
					$loopcnt2++;

#					printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "\t\t\t(%s)~%s\n", $elem2, $nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2}/$nl_total_itemname_hash{$elem1});
					if ($$speakfreely_args{"do_robust_parsing"}) {
						if ($$general_args{"normalization_level"} != 0) {
							printf (TRAINING_robust_parsing_nuance_speakfreely "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
						} else {
							printf (TRAINING_robust_parsing_nuance_speakfreely "\t<item weight=\"".$nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
						}
					}

					if ($$speakfreely_args{"do_normal_slm"}) {
						if ($$general_args{"normalization_level"} != 0) {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
						} else {
							printf(NLITEMNAMEGRAMMAR_nuance_speakfreely "\t<item weight=\"".$nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
						}
					}

					$probval += $nl_generic_itemname_nuance_speakfreely_hash{$elem1}{$elem2};

					$temp_elem2 = $elem2;
					$temp_elem2 =~ s/\ª//g;
					$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

					$word_list_hash{$temp_word_list}{$elem1}++;
				}
			}

			if ($loopcnt2 > 0) {
				if ($$speakfreely_args{"do_robust_parsing"}) {
					print TRAINING_robust_parsing_nuance_speakfreely "\<\!-- \"End Generic Section\"--\>\n";
				}

				if ($$speakfreely_args{"do_normal_slm"}) {
					print NLITEMNAMEGRAMMAR_nuance_speakfreely "\<\!-- \"End Generic Section\"--\>\n";
				}
			}

			if ($loopcnt > 0) {
				if ($$speakfreely_args{"do_robust_parsing"}) {
					print TRAINING_robust_parsing_nuance_speakfreely "</one-of>\n</rule>\n";
				}

				if ($$speakfreely_args{"do_normal_slm"}) {
					print NLITEMNAMEGRAMMAR_nuance_speakfreely "</one-of>\n</rule>\n";
				}
			}
		}

		if ($$speakfreely_args{"do_robust_parsing"}) {
			print TRAINING_robust_parsing_nuance_speakfreely "</grammar>\n";
			close(TRAINING_robust_parsing_nuance_speakfreely);
		}

		if ($$speakfreely_args{"do_normal_slm"}) {
			print NLITEMNAMEGRAMMAR_nuance_speakfreely "<\/grammar>\n";
			close(NLITEMNAMEGRAMMAR_nuance_speakfreely);
		}

		CheckWordList(\%word_list_hash, \%itemname2utt_hash);

# Nuance SpeakFreely SLM FSM

		if ($$speakfreely_args{"do_robust_parsing"}) {
			open(TRAINING_slm_fsm_nuance_speakfreely,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance_speakfreely_training_slm_fsm.xml") or die "cant write TRAINING_slm_fsm_nuance_speakfreely";

			print TRAINING_slm_fsm_nuance_speakfreely "<\?xml version=\"1.0\" encoding=\"ISO-8859-1\"\?>\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<\!DOCTYPE SpeakFreelyConfig SYSTEM \"".$$speakfreely_args{"swisrsdk_location"}."\/config\/SpeakFreelyConfig.dtd\">\n<SpeakFreelyConfig version=\"4.0.0\">\n";

			print TRAINING_slm_fsm_nuance_speakfreely "<!-- PARAMETER SETTINGS -->\n";

			foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
				if ($elem1 =~ /ngram_order/) {
					$ngram_order_found = 1;
				}
			}
			print TRAINING_slm_fsm_nuance_speakfreely "<param name=\"language\">\n\t<value>".$$general_args{"main_language"}."</value>\n</param>\n";

			if (!$ngram_order_found) {
				print TRAINING_slm_fsm_nuance_speakfreely "<param name=\"ngram_order\">\n\t<value>2</value>\n</param>\n";
			}

			print TRAINING_slm_fsm_nuance_speakfreely "<param name=\"fsm_out\">\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<value>nuance_speakfreely_ngram_SP.fsm<\/value>\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<\/param>\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<param name=\"wordlist_out\">\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<value>nuance_speakfreely_ngram_SP.wordlist<\/value>\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<\/param>\n\n";

			foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
				print TRAINING_slm_fsm_nuance_speakfreely "<param name=\"$elem1\"><value>";
				print TRAINING_slm_fsm_nuance_speakfreely $$osr_args{"training_items"}{"param"}{$elem1};
				print TRAINING_slm_fsm_nuance_speakfreely "<\/value><\/param>\n\n";
			}

			if ((scalar keys %{ $$osr_args{"training_items"}{"meta"} }) > 0) {
				print TRAINING_slm_fsm_nuance_speakfreely "<\!-- META PARAMETER INFORMATION -->\n";
				foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"meta"} }) {
					print TRAINING_slm_fsm_nuance_speakfreely "<meta name=\"$elem1\" content=\"", $$osr_args{"training_items"}{"meta"}{$elem1}, "\"/>\n";
				}
			}

			if ((scalar keys %{ $$osr_args{"add_dictionaries"} }) > 0) {
				print TRAINING_slm_fsm_nuance_speakfreely "\n\n";
				print TRAINING_slm_fsm_nuance_speakfreely "<\!-- DICTIONARY INFORMATION -->\n";
				foreach $elem1 ( sort { $a cmp $b } keys %{$$osr_args{"add_dictionaries"}}) {
					printf(TRAINING_slm_fsm_nuance_speakfreely "<lexicon uri=\"%s\?SWI.type=backup\"/>\n", $elem1);
				}
			}

			print TRAINING_slm_fsm_nuance_speakfreely "\n\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<\!-- VOCABULARY INFORMATION -->\n";
			print TRAINING_slm_fsm_nuance_speakfreely "<vocab>\n";
			foreach $elem1 ( sort { $a cmp $b } keys %{$$general_args{"full_vocab"}}) {
			  @test_array = grep {/\b$elem1\b/} @{$$osr_args{"training_stop_items"}};

			  if (scalar(@test_array) == 0) {
				printf(TRAINING_slm_fsm_nuance_speakfreely "<item>%s</item>\n", $elem1);
			  } else {
				$word_found = 0;
				foreach $elem2 (@test_array) {
				  if ($elem1 eq $elem2) {
					$word_found = 1;
				  }
				}

				if (!$word_found) {
				  printf(TRAINING_slm_fsm_nuance_speakfreely "<item>%s</item>\n", $elem1);
				}
			  }

			  @test_array = ();
			}

			print TRAINING_slm_fsm_nuance_speakfreely "<\!-- BEGIN STOP WORDS IN VOCABULARY -->\n";
			foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
			  printf(TRAINING_slm_fsm_nuance_speakfreely "<item>%s</item>\n", $elem1);
			}

			print TRAINING_slm_fsm_nuance_speakfreely "<\!-- END STOP WORDS IN VOCABULARY -->\n\n";

			$absolute_path = "./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_";
			foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}}) {
			  $modified_item = setClassGrammarVocabItem("fsm_speakfreely", $elem1, $absolute_path);

#				print TRAINING_slm_fsm_nuance_speakfreely "<ruleref uri=\"./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_"."$elem3\.grxml\"\n\ttag=\"uni='$elem2:' + ROOT.$elem2\"/>\n";
			  print TRAINING_slm_fsm_nuance_speakfreely $modified_item;
			}

			print TRAINING_slm_fsm_nuance_speakfreely "</vocab>\n\n";

			if ((scalar (@{$$osr_args{"training_stop_items"}})) > 0) {
				print TRAINING_slm_fsm_nuance_speakfreely "<\!-- STOP WORDS -->\n";
				print TRAINING_slm_fsm_nuance_speakfreely "<stop>\n";
				foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
					printf(TRAINING_slm_fsm_nuance_speakfreely "\t<item>%s</item>\n", $elem1);
				}

				print TRAINING_slm_fsm_nuance_speakfreely "</stop>\n";
			}

			print TRAINING_slm_fsm_nuance_speakfreely "<training>\n";

			foreach $elem1 ( sort { $a cmp $b } keys %nuance_speakfreely_TAGGEDCORPUS_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$nuance_speakfreely_TAGGEDCORPUS_hash{$elem1} }) {
					if ($nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
						$elem3 = $elem2;
						$elem3 =~ s/<item>\n\t//g;
						$elem3 =~ s/\n<\/item>//g;
						$elem3 =~ s/<ruleref uri=\"\#(\w+)(\-(\w+))*\" \/>\n\t//g;
						$elem3 =~ s/<\/tag><tag>/:/g;
						$elem3 =~ s/<tag>//g;
						$elem3 =~ s/<\/tag>//g;

						$elem4 = $elem1;

						$elem3 =~ s/=/:/g;
						$elem3 =~ s/\'//g;
						$elem3 = ChopChar($elem3);

						foreach $elem5 ( sort { $a cmp $b } keys %{ $speakfreely_meaning_hash{$elem1} }) {
							$training_hash{$elem5}{$elem4} += $nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2};
						}
					} else {
					  $elem4 = $elem1;

					  $compressed_sentence = ApplyChooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $elem4, $compressed_already_hash);

					  if (defined $keep_min_freq_hash{$compressed_sentence}) {
						foreach $elem5 ( sort { $a cmp $b } keys %{ $speakfreely_meaning_hash{$elem1} }) {
							$training_hash{$elem5}{$elem4} += $nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2};
						}
					  }
					}
				}
			}

			open(SENTOUT,">"."slmdirect_results\/createslm_final_sentences".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslm_final_sentences".$$general_args{"language_suffix"};
			foreach $elem1 ( sort { $a cmp $b } keys %training_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$training_hash{$elem1} }) {
					printf (TRAINING_slm_fsm_nuance_speakfreely "<sentence count=\"%s\">\n", $training_hash{$elem1}{$elem2}+$add_sentence_count);

					printf (TRAINING_slm_fsm_nuance_speakfreely "%s\n", $elem2);
					print TRAINING_slm_fsm_nuance_speakfreely "</sentence>\n";

					print SENTOUT "$elem2\t$elem1\t", $training_hash{$elem1}{$elem2}, "\n";
				}
			}

			print TRAINING_slm_fsm_nuance_speakfreely "</training>\n\n";
			close(SENTOUT);

			if ($$osr_args{"addtestfile"} ne "") {
				print TRAINING_slm_fsm_nuance_speakfreely "<test>\n";
				undef %test_hash;
				if ($$osr_args{"addtestfile"} !~ /createslm_applytags_test_input/) {
					getAndCleanTestData($general_args, $cleaning_args, $osr_args, $cat_args, \%test_hash, $referencetag_hash);
				} else {
					open(ADDTEST,"<".$$osr_args{"addtestfile"}) or die "cant open ".$$osr_args{"addtestfile"};

					undef %test_hash;
					while(<ADDTEST>) {
						$line = $_;

						if (substr($line,0,1) eq "#") {
							next;
						}

						$line = ChopChar($line);

						($filename, $corrected_sentence, $item_category, $orig_sentence) = split "\t", $line;
						$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
						if ((lc($item_category) !~ /blank/)) {
							my($temp_elem) = $orig_sentence;

							$temp_elem =~ s/\-/ /g;
							$temp_elem =~ s/\_/ /g;
							$temp_elem = TrimChars($temp_elem);
							if (defined $$cat_args{"sentence_cat_assignments"}{$temp_elem}) {
								if (lc($item_category) ne lc($$cat_args{"sentence_cat_assignments"}{$temp_elem})) {
									DebugPrint ("BOTH", 2, "CreateMainGrammar", $debug, $err_no++, "$item_category changed to ".$$cat_args{"sentence_cat_assignments"}{$orig_sentence}." for trans=$orig_sentence");

									$item_category = $$cat_args{"sentence_cat_assignments"}{$temp_elem};
									$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
								}
							}

							if ($corrected_sentence ne "") {
								$test_hash{$corrected_sentence}{$item_category}++;
							}
						}
					}
				}

				foreach $elem1 ( sort { $a cmp $b } keys %test_hash) {
					foreach $elem2 ( sort { $a cmp $b } keys %{ $test_hash{$elem1} }) {
						print TRAINING_slm_fsm_nuance_speakfreely "<sentence meaning=\"".$$osr_args{"test_slotname"}.":",uc($elem2),":".$$osr_args{"test_confirm_as"}.":",uc($elem2),"\" count=\"", $test_hash{$elem1}{$elem2},"\">\n";
						print TRAINING_slm_fsm_nuance_speakfreely "    $elem1\n";
						print TRAINING_slm_fsm_nuance_speakfreely "</sentence>\n";
					}
				}

				print TRAINING_slm_fsm_nuance_speakfreely "</test>\n\n";
			}

			print TRAINING_slm_fsm_nuance_speakfreely "</SpeakFreelyConfig>\n";

			close(TRAINING_slm_fsm_nuance_speakfreely);
		}

# Write SpeakFreely Training.xml file

		if ($$speakfreely_args{"do_normal_slm"}) {
#hereqaz111111: indent candidate
			open(TRAINING_nuance_speakfreely,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance_speakfreely_training.xml") or die "cant write TRAINING_nuance_speakfreely";
			print TRAINING_nuance_speakfreely "<\?xml version=\"1.0\" encoding=\"$encoding\"\?>\n";
			print TRAINING_nuance_speakfreely "<\!DOCTYPE SpeakFreelyConfig SYSTEM \"".$$speakfreely_args{"swisrsdk_location"}."\/config\/SpeakFreelyConfig.dtd\">\n<SpeakFreelyConfig version=\"2.0.0\">\n";

			print TRAINING_nuance_speakfreely "<!-- PARAMETER SETTINGS -->\n";
			foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
				if ($elem1 =~ /ngram_order/) {
					$ngram_order_found = 1;
				}
			}
			print TRAINING_nuance_speakfreely "<param name=\"language\">\n\t<value>".$$general_args{"main_language"}."</value>\n</param>\n";

			if (!$ngram_order_found) {
				print TRAINING_nuance_speakfreely "<param name=\"ngram_order\">\n\t<value>2</value>\n</param>\n";
			}

			print TRAINING_nuance_speakfreely "<param name=\"root_ecmascript\">\n<value>\n";

			print TRAINING_nuance_speakfreely "\tvar test_meaning = SWI_meaning;\n";
			print TRAINING_nuance_speakfreely "\tif (test_meaning.indexOf(\':\') \&gt; 0) {\n";
			print TRAINING_nuance_speakfreely "\t\tvar TheSplit = test_meaning.split(\'\:\');\n";
			print TRAINING_nuance_speakfreely "\t\tif (TheSplit[0].match(/".$$osr_args{"test_slotname"}."/)) {\n";
			print TRAINING_nuance_speakfreely "\t\t\tITEM_NAME = TheSplit[1];\n";
			print TRAINING_nuance_speakfreely "\t\t\tCATEGORY = TheSplit[1];\n";
			print TRAINING_nuance_speakfreely "\t\t\tCONFVAL = ssm_score;\n";
			print TRAINING_nuance_speakfreely "\t\t}\n";
			print TRAINING_nuance_speakfreely "\t\telse {\n";
			print TRAINING_nuance_speakfreely "\t\t\tAMBIG_KEY = TheSplit[1];\n";
			print TRAINING_nuance_speakfreely "\t\t}\n";
			print TRAINING_nuance_speakfreely "\n\t\t".$$osr_args{"test_confirm_as"}." = TheSplit[3];\n";

			print TRAINING_nuance_speakfreely "\t}\n";
			print TRAINING_nuance_speakfreely "<\/value>\n<\/param>\n\n";

			foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
				print TRAINING_nuance_speakfreely "<param name=\"$elem1\"><value>";
				print TRAINING_nuance_speakfreely $$osr_args{"training_items"}{"param"}{$elem1};
				print TRAINING_nuance_speakfreely "<\/value><\/param>\n\n";
			}

			if ((scalar keys %{ $$osr_args{"training_items"}{"meta"} }) > 0) {
				print TRAINING_nuance_speakfreely "<\!-- META PARAMETER INFORMATION -->\n";
				foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"meta"} }) {
					print TRAINING_nuance_speakfreely "<meta name=\"$elem1\" content=\"", $$osr_args{"training_items"}{"meta"}{$elem1}, "\"/>\n";
				}
			}

			if ((scalar keys %{ $$osr_args{"add_dictionaries"} }) > 0) {
				print TRAINING_nuance_speakfreely "\n\n";
				print TRAINING_nuance_speakfreely "<\!-- DICTIONARY INFORMATION -->\n";
				foreach $elem1 ( sort { $a cmp $b } keys %{$$osr_args{"add_dictionaries"}}) {
					printf(TRAINING_nuance_speakfreely "<lexicon uri=\"%s\?SWI.type=backup\"/>\n", $elem1);
				}
			}

			print TRAINING_nuance_speakfreely "\n\n";
			print TRAINING_nuance_speakfreely "<\!-- VOCABULARY INFORMATION -->\n";
			print TRAINING_nuance_speakfreely "<vocab>\n";
			foreach $elem1 ( sort { $a cmp $b } keys %{$$general_args{"full_vocab"}}) {
			  @test_array = grep {/\b$elem1\b/} @{$$osr_args{"training_stop_items"}};
			  if (scalar(@test_array) == 0) {
				printf(TRAINING_nuance_speakfreely "<item>%s</item>\n", $elem1);
			  } else {
				$word_found = 0;
				foreach $elem2 (@test_array) {
				  if ($elem1 eq $elem2) {
					$word_found = 1;
				  }
				}

				if (!$word_found) {
				  printf(TRAINING_nuance_speakfreely "<item>%s</item>\n", $elem1);
				}
			  }

			  @test_array = ();
			}

			print TRAINING_nuance_speakfreely "<\!-- BEGIN STOP WORDS IN VOCABULARY -->\n";
			foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
			  printf(TRAINING_nuance_speakfreely "<item>%s</item>\n", $elem1);
			}

			print TRAINING_nuance_speakfreely "<\!-- END STOP WORDS IN VOCABULARY -->\n\n";

			$absolute_path = "./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_";
			foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}}) {
			  $modified_item = setClassGrammarVocabItem("speakfreely", $elem1, $absolute_path);

			  print TRAINING_nuance_speakfreely $modified_item;
			}

			print TRAINING_nuance_speakfreely "</vocab>\n\n";

			if ((scalar (@{$$osr_args{"training_stop_items"}})) > 0) {
				print TRAINING_nuance_speakfreely "<\!-- STOP WORDS -->\n";
				print TRAINING_nuance_speakfreely "<stop>\n";
				foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
					printf(TRAINING_nuance_speakfreely "\t<item>%s</item>\n", $elem1);
				}

				print TRAINING_nuance_speakfreely "</stop>\n";
			}

			print TRAINING_nuance_speakfreely "<training>\n";

			foreach $elem1 ( sort { $a cmp $b } keys %nuance_speakfreely_TAGGEDCORPUS_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$nuance_speakfreely_TAGGEDCORPUS_hash{$elem1} }) {
					if ($nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
						$elem3 = $elem2;
						$elem3 =~ s/<item>\n\t//g;
						$elem3 =~ s/\n<\/item>//g;
						$elem3 =~ s/<ruleref uri=\"\#(\w+)(\-(\w+))*\" \/>\n\t//g;
						$elem3 =~ s/<\/tag><tag>/:/g;
						$elem3 =~ s/<tag>//g;
						$elem3 =~ s/<\/tag>//g;

						$elem4 = $elem1;

						$elem3 =~ s/=/:/g;
						$elem3 =~ s/\'//g;
						$elem3 = ChopChar($elem3);

						foreach $elem5 ( sort { $a cmp $b } keys %{ $speakfreely_meaning_hash{$elem1} }) {
							$training_hash{$elem5}{$elem4} += $nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2};
						}
					} else {
					  $elem4 = $elem1;
					  $compressed_sentence = ApplyChooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $elem4, $compressed_already_hash);

					  if (defined $keep_min_freq_hash{$compressed_sentence}) {
						foreach $elem5 ( sort { $a cmp $b } keys %{ $speakfreely_meaning_hash{$elem1} }) {
							$training_hash{$elem5}{$elem4} += $nuance_speakfreely_TAGGEDCORPUS_hash{$elem1}{$elem2};
						}
					  }
					}
				}
			}

			open(SENTOUT,">"."slmdirect_results\/createslm_final_sentences".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslm_final_sentences".$$general_args{"language_suffix"};
			foreach $elem1 ( sort { $a cmp $b } keys %training_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$training_hash{$elem1} }) {
					if (($training_hash{$elem1}{$elem2} >= 2) || (defined $$general_args{"just_keywords"}{$elem2})) {
						printf (TRAINING_nuance_speakfreely "<sentence meaning=\"%s\" memorize=\"1\" count=\"%s\">\n", $elem1, $training_hash{$elem1}{$elem2}+$add_sentence_count);
					} else {
						printf (TRAINING_nuance_speakfreely "<sentence meaning=\"%s\" count=\"%s\">\n", $elem1, $training_hash{$elem1}{$elem2}+$add_sentence_count);
					}

					printf (TRAINING_nuance_speakfreely "%s\n", $elem2);
					print TRAINING_nuance_speakfreely "</sentence>\n";

					print SENTOUT "$elem2\t$elem1\t", $training_hash{$elem1}{$elem2}, "\n";
				}
			}

			print TRAINING_nuance_speakfreely "</training>\n\n";
			close(SENTOUT);

			if ($$osr_args{"addtestfile"} ne "") {
				print TRAINING_nuance_speakfreely "<test>\n";
				undef %test_hash;
				if ($$osr_args{"addtestfile"} !~ /createslm_applytags_test_input/) {
					getAndCleanTestData($general_args, $cleaning_args, $osr_args, $cat_args, \%test_hash, $referencetag_hash);
				} else {
					open(ADDTEST,"<".$$osr_args{"addtestfile"}) or die "cant open ".$$osr_args{"addtestfile"};
					while(<ADDTEST>) {
						$line = $_;

						if (substr($line,0,1) eq "#") {
							next;
					}

						$line = ChopChar($line);

						($filename, $corrected_sentence, $item_category, $orig_sentence) = split "\t", $line;
						$item_category = NormCat($item_category, $$general_args{"test_reject_name"});

						if ((lc($item_category) !~ /blank/)) {
							$temp_elem = $orig_sentence;

							$temp_elem =~ s/\-/ /g;
							$temp_elem =~ s/\_/ /g;
							$temp_elem = TrimChars($temp_elem);
							if (defined $$cat_args{"sentence_cat_assignments"}{$temp_elem}) {
								if (lc($item_category) ne lc($$cat_args{"sentence_cat_assignments"}{$temp_elem})) {
									DebugPrint ("BOTH", 2, "CreateMainGrammar", $debug, $err_no++, "$item_category changed to ".$$cat_args{"sentence_cat_assignments"}{$orig_sentence}." for trans=$orig_sentence");

									$item_category = $$cat_args{"sentence_cat_assignments"}{$temp_elem};
									$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
								}
							}

							if ($corrected_sentence ne "") {
								$test_hash{$corrected_sentence}{$item_category}++;
							}
						}
					}
				}

				foreach $elem1 ( sort { $a cmp $b } keys %test_hash) {
					foreach $elem2 ( sort { $a cmp $b } keys %{ $test_hash{$elem1} }) {
						print TRAINING_nuance_speakfreely "<sentence meaning=\"".$$osr_args{"test_slotname"}.":",$elem2,":".$$osr_args{"test_confirm_as"}.":",$elem2,"\" count=\"", $test_hash{$elem1}{$elem2},"\">\n";
						print TRAINING_nuance_speakfreely "    $elem1\n";
						print TRAINING_nuance_speakfreely "</sentence>\n";
					}
				}

				print TRAINING_nuance_speakfreely "</test>\n\n";
			}

			print TRAINING_nuance_speakfreely "</SpeakFreelyConfig>\n";

			close(TRAINING_nuance_speakfreely);
		}

		open(BATCHFILE,">"."slmdirect_results\/slmp_compile_nuance_speakfreely.bat") or die "cant write BATCHFILE";
		if ($$speakfreely_args{"do_robust_parsing"}) {
			print BATCHFILE "sgc -train ".$$general_args{"grammarbase"}."_nuance_speakfreely_training_slm_fsm.xml"." -no_gram\n\n";
		}

		if ($$speakfreely_args{"do_normal_slm"}) {
			print BATCHFILE "sgc -ssm -train ".$$general_args{"grammarbase"}."_nuance_speakfreely_training.xml"."\n\n";
			print BATCHFILE "sgc ".$$general_args{"grammarbase"}."_nuance_speakfreely_nl_items.grxml"."\n";
		}

		close(BATCHFILE);

		if ($$general_args{"run_bats"}) {
			my($cmd);
			$cmd = "cmd /c slmp_compile_nuance_speakfreely.bat>>"."slmdirect_results\/createslm_temp_bat_log";
			DebugPrint ("BOTH", 0.1, "CreateMainGrammar", $debug, $err_no++, "Running: slmp_compile_nuance_speakfreely.bat ...");
			system($cmd);
		}
	}
# Nuance9

	if ($$general_args{"grammar_type"} eq "NUANCE9") {
		if ($$general_args{"do_use_product_prefix"}) {
			foreach (@{$$osr_args{"all_gram_elems"}}) {
				@gram_elems = ();
				($add_item_category, $elem3, @gram_elems) = split ":";
				$product_max = $$general_args{"product_prefix_num"};
				foreach $elem (@gram_elems) {
					if ($elem ne "") {

						if ($elem =~ /\d/) {
							$product_max = $elem * $$general_args{"product_prefix_num"};

							next;
						}

						@pg_array = ();

						if ( ($elem =~ /\[/) || ($elem =~ /\(/) ) {
							@pg_array = ParseGrammar($elem);
						} else {
							push @pg_array, $elem;
						}

						foreach $pg_elem (@pg_array) {
							foreach $elem1 ($$general_args{"product_prefix"}) {
								if (( (substr($pg_elem,0,1) =~ /a|e|i|o|u/) && (($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")) ) || ((substr($pg_elem,0,1) !~ /a|e|i|o|u/) && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a"))) || ((($elem1 ne "an") && (substr($elem1,length($elem1)-3) ne " an")) && (($elem1 ne "a") && (substr($elem1,length($elem1)-2) ne " a")))) {
									if ( not ((substr($pg_elem,length($pg_elem)-1) eq "s") && (($elem1 eq "a") || (substr($elem1,length($elem1)-2) eq " a") || ($elem1 eq "an") || (substr($elem1,length($elem1)-3) eq " an")))) {
										for ($i = 0; $i < $product_max; $i++) {
											$nuance9_TAGGEDCORPUS_hash{"$elem1 $pg_elem"}{$elem3}++;
										}
									}
								}
							}
						}
					}
				}
			}
		}

#		if ($nl_total_processed) {
#			WriteMainGrammar_nuance_variant_xml ($$general_args{"main_language"}, "NUANCE9", $$general_args{"main_grammar_name"}, $$general_args{"grammarbase"}, $nl_contains_product_total_nuance9, $$general_args{"filter_corpus"}, $$cleaning_args{"top_skip"}, $$general_args{"tuning_version"}, $$general_args{"test_reject_name"}, $$nuance9_args{"do_normal_slm"}, $$nuance9_args{"do_robust_parsing"});
#		}

		if ((scalar keys %nl_itemcategories_nuance9_hash) > 0 ) {
			if ($$nuance9_args{"do_robust_parsing"}) {
				open(TRAINING_robust_parsing_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_robust_parsing.xml") or die "cant write TRAINING_robust_parsing_nuance9";
				print TRAINING_robust_parsing_nuance9 "<\?xml version=\"1.0\" encoding=\"ISO-8859-1\"\?>\n",
				"<grammar version=\"1\.0\" xmlns=\"http:\/\/www\.w3\.org\/2001\/06\/grammar\" xml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"concepts\"> <meta name=\"swirec_fsm_grammar\" ",
				"content=\"nuance9_ngram_SP\.fsm\"\/> <meta name=\"swirec_fsm_wordlist\" content=\"nuance9_ngram_SP\.wordlist\"\/>\n",
				"<conceptset id=\"concepts\" xmlns=\"http:\/\/www\.scansoft\.com\/grammar\">\n",
				"\t<concept>\n",
				"\t\t<ruleref uri=\"#SLMItems\"/>\n",
				"\t\t<tag>if(SLMItems.".$$osr_args{"test_slotname"}.") {".$$osr_args{"test_slotname"}."=SLMItems.".$$osr_args{"test_slotname"}."}</tag>\n",
				"\t\t<tag>if(SLMItems.".$$osr_args{"test_confirm_as"}.") {".$$osr_args{"test_confirm_as"}."=SLMItems.".$$osr_args{"test_confirm_as"}."}</tag>\n";

				foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_pc_nuance9_hash) {
				  if (scalar keys %{$nl_itemname_grammar_rp_nuance9_hash{$elem1}} > 0) {
					$temp_elem = 0;
					foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_rp_nuance9_hash{$elem1} }) {
					  if ($nl_itemname_grammar_rp_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"}) {
						$temp_elem = 1;
						last;
					  }
					}

					if ($temp_elem) {
#qazhere
					  while ($elem1 =~ /((\w|\_|\d)+\=)+/g) {
						$word_rp = $1;
						$word_rp =~ s/\=//g;
						if (($word_rp ne "uri") && ($word_rp ne $$osr_args{"test_slotname"})&& ($word_rp ne $$osr_args{"test_confirm_as"})) {
						  $nl_itemcategories_rp_nuance9_hash{$word_rp}++;
						  print "qazhere111:word_rp=$word_rp\n";
						}
					  }
					}
				  }
				}

				foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_rp_nuance9_hash) {
				  print TRAINING_robust_parsing_nuance9 "\t\t<tag>if(SLMItems.".$elem1.") {$elem1=SLMItems."."$elem1"."}</tag>\n";
				}

#				"\t\t<tag>ITEM_NAME=SLMItems.".$$osr_args{"test_slotname"}."</tag>\n",
#				"\t\t<tag>AMBIG_KEY=SLMItems.AMBIG_KEY</tag>\n",
#				"\t\t<tag>CONFVAL=SLMItems.CONFVAL</tag>\n",
#				"\t\t<tag>LITERAL=SLMItems.LITERAL</tag>\n\n",
				print TRAINING_robust_parsing_nuance9 "\t<\/concept>\n",
				"<\/conceptset>\n\n";

				print TRAINING_robust_parsing_nuance9 "<rule id=\"SLMItems\">\n<one-of>\n";
			}
		}

		if ($$nuance9_args{"do_normal_slm"}) {
#hereqaz121212: indent candidate
			open(WRAPPERGRAMMAR_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_wrapper.grxml") or die "cant write WRAPPERGRAMMAR_nuance9";
			print WRAPPERGRAMMAR_nuance9 "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"dummy\">\n\n",

			"\t<meta name=\"swirec_fsm_grammar\" ",
			"\tcontent=\"nuance9_ngram_SP\.fsm\"\/> <meta name=\"swirec_fsm_wordlist\" content=\"nuance9_ngram_SP\.wordlist\"\/>\n\n",

#			"\t<semantic_interpretation xmlns=\"http://www.nuance.com/semantics\" priority=\"1\">\n",
#			"\t\t<component>\n",
#			"\t\t\t<interpreter uri=\"#".$$general_args{"grammarbase"}."_Explicit_Top\" type=\"application/srgs+xml\"\/>\n",
#			"\t\t</component>\n",
#			"\t<\/semantic_interpretation>\n\n",
#
#			"\t<semantic_interpretation xmlns=\"http://www.nuance.com/semantics\" priority=\"2\">\n",
#			"\t\t<component>\n",
#			"\t\t\t<interpreter uri=\"#".$$general_args{"grammarbase"}."_Explicit_SLMItems\" type=\"application/srgs+xml\"\/>\n",
#			"\t\t</component>\n",
#			"\t<\/semantic_interpretation>\n\n",

			"\t<semantic_interpretation xmlns=\"http://www.nuance.com/semantics\" priority=\"1\">\n",
			"\t\t<component confidence_threshold=\"0.00\">\n",
			"\t\t\t<interpreter uri=\"", $$general_args{"grammarbase"}."_nuance9_training_ssm.ssm\" type=\"application\/x-vnd.nuance.ssm\"\/>\n",
			"\t\t\t<\!-- <confidence_engine uri=\"conf.out\" type=\"application\/x-vnd\.nuance\.confengine\"\/> -->\n",
			"\t\t</component>\n",
			"\t<\/semantic_interpretation>\n\n",

			"\t<rule id=\"dummy\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<tag>NOTHING=\'DUMMY\'</tag>\n",
			"\t\t</item>\n\t</rule>\n\n",
			"<\/grammar>\n";

			close(WRAPPERGRAMMAR_nuance9);

			open(NLITEMNAMEGRAMMAR_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_nl_itemname.grxml") or die "cant write NLITEMNAMEGRAMMAR_nuance9";
			print NLITEMNAMEGRAMMAR_nuance9 "<\?xml version=\"1.0\" encoding=\"$encoding\" ?>\n",
			"<grammar version=\"1.0\" xmlns=\"http://www.w3.org/2001/06/grammar\" \n\t\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n",
			"\t\txsi:schemaLocation=\"http://www.w3.org/2001/06/grammar\n",
			"\t\thttp://www.w3.org/TR/speech-grammar/grammar.xsd\"\n",
			"\txml:lang=\"".$$general_args{"main_language"}."\" mode=\"voice\" root=\"".$$general_args{"grammarbase"}."_Explicit_SLMItems\">\n\n",

			"\t<rule id=\"".$$general_args{"grammarbase"}."_Explicit_SLMItems\" scope=\"public\">\n",
			"\t\t<item>\n",
			"\t\t\t<ruleref uri=\"#SLMItems\"/>\n",
			"\t\t\t<tag>if(SLMItems.Item_Name) {ITEM_NAME=SLMItems.".$$osr_args{"test_slotname"}."}</tag>\n",
			"\t\t\t<tag>if(SLMItems.".$$osr_args{"test_confirm_as"}.") {".$$osr_args{"test_confirm_as"}."=SLMItems.".$$osr_args{"test_confirm_as"}."}</tag>\n",
#			"\t\t\t<tag>if(SLMItems.Ambig_Key) {AMBIG_KEY=SLMItems.Ambig_Key}</tag>\n",
			"\t\t\t<tag>if(SLMItems.".$$osr_args{"test_slotname"}.") {".$$osr_args{"test_slotname"}."=SLMItems.".$$osr_args{"test_slotname"}."}</tag>\n",
			"\t\t\t<tag>if(SLMItems.Literal) {LITERAL=SLMItems.Literal}</tag>\n",
			"\t\t\t<tag>if(SLMItems.Confval) {CONFVAL=SLMItems.Confval}</tag>\n",

			"\t\t</item>\n\t</rule>\n\n";

			print NLITEMNAMEGRAMMAR_nuance9 "<rule id=\"SLMItems\">\n<one-of>\n";
		}

		foreach (@{$$osr_args{"all_gram_elems_nuance_class_full_xml"}}) {
			@gram_elems = ();
			$freq_max = $$general_args{"product_prefix_num"};
			($add_item_category, $elem3, @gram_elems) = split ":";
			$add_item_category =~ s/ /_/g;
			$nl_itemcategories_pc_nuance9_hash{$elem3} = $add_item_category;

			foreach $elem (@gram_elems) {
				if ($elem ne "") {
					if ($elem =~ /\d/) {
						$freq_max = $elem * $$general_args{"product_prefix_num"};

						next;
					}

					if ($freq_max < $$general_args{"min_freq"}) {
						$freq_max = $$general_args{"min_freq"};
					}

					$temp_elem = FilterAmbigWords($general_args, $cleaning_args, $elem);

					if ($temp_elem =~ /(\[(\w|\s)+\])+/) {
						$rep_or1 = $1;
						$rep_or2 = $1;

						$rep_or1 =~ s/\[/\\\[/g;
						$rep_or1 =~ s/\]/\\\]/g;

						$rep_or2 =~ s/\[//g;
						$rep_or2 =~ s/\]//g;

						(@rep_array) = split " ", $rep_or2;

						$rep_or3 = "\n\t\t<one-of>\n";

						foreach $i_elem (@rep_array) {
							$rep_or3 = $rep_or3."\t\t\t<item>$i_elem<\/item>\n";
						}

						$rep_or3 = $rep_or3."\t\t<\/one-of>\n\t";

						$temp_elem =~ s/$rep_or1/$rep_or3/g;
						$temp_elem = "\n\t\t".$temp_elem;
					}

					$temp_elem =~ s/\[/\n\t\t<one-of>\n<item>/g;
					$temp_elem =~ s/\]/<\/item>\n<\/one-of>\n/g;
					$temp_elem =~ s/\(/<item>/g;
					$temp_elem =~ s/\)/<\/item>\n/g;

					if ($temp_elem ne "") {
						$nl_itemname_grammar_nuance9_hash{$elem3}{$temp_elem} += $freq_max;
						$nl_total_itemname_nuance9_hash{$elem3} += $freq_max;

						$nl_itemcategories_nuance9_hash{$elem3} += $freq_max;
						$nl_total_itemcategories_nuance9 += $freq_max;
					}
				}
			}
		}

		if ($$nuance9_args{"do_normal_slm"}) {
		  foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_pc_nuance9_hash) {
			if (scalar keys %{$nl_itemname_grammar_nuance9_hash{$elem1}} > 0) {
			  $temp_elem = 0;
			  foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance9_hash{$elem1} }) {
				if ($nl_itemname_grammar_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"}) {
				  $temp_elem = 1;
				  last;
				}
			  }

			  if ($temp_elem) {
				print NLITEMNAMEGRAMMAR_nuance9 "$elem1\n";
			  }
			}
		  }

		  print NLITEMNAMEGRAMMAR_nuance9 "<\/one-of>\n<\/rule>\n\n";
		}

		if ($$nuance9_args{"do_robust_parsing"}) {
		  foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_pc_nuance9_hash) {
			if (scalar keys %{$nl_itemname_grammar_rp_nuance9_hash{$elem1}} > 0) {
			  $temp_elem = 0;
			  foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_rp_nuance9_hash{$elem1} }) {
				if ($nl_itemname_grammar_rp_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"}) {
				  $temp_elem = 1;
				  last;
				}
			  }

			  if ($temp_elem) {
				print TRAINING_robust_parsing_nuance9 "$elem1\n";
			  }
			}
		  }

		  print TRAINING_robust_parsing_nuance9 "<\/one-of>\n<\/rule>\n\n";
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance9_hash) {
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance9_hash{$elem1} }) {
				if (defined $nl_itemname_grammar_nuance9_hash{$elem1}{$elem2}) {
					$nl_generic_itemname_nuance9_hash{$elem1}{$elem2} += $nl_itemname_grammar_nuance9_hash{$elem1}{$elem2};
					$nl_itemname_grammar_nuance9_hash{$elem1}{$elem2} = 0;
				}
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance9_hash) {
			$loopcnt = 0;
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance9_hash{$elem1} }) {
				if ($nl_itemname_grammar_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
					$loopcnt++;
				} else {
					$nl_total_itemname_nuance9_hash{$elem1} -= $nl_itemname_grammar_nuance9_hash{$elem1}{$elem2};
					$nl_itemname_grammar_nuance9_hash{$elem1}{$elem2} = 0;
				}
			}

			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance9_hash{$elem1} }) {
				if ($nl_generic_itemname_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
					$loopcnt++;
				} else {
					$nl_total_itemname_nuance9_hash{$elem1} -= $nl_generic_itemname_nuance9_hash{$elem1}{$elem2};
					$nl_generic_itemname_nuance9_hash{$elem1}{$elem2} = 0;
				}
			}

			if ($loopcnt == 0) {
				$nl_itemcategories_nuance9_hash{$elem1}--;
				$nl_total_itemcategories_nuance9--;
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %nl_itemcategories_nuance9_hash) {
		  $loopcnt = 0;

		  if ($$nuance9_args{"do_normal_slm"}) {
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_nuance9_hash{$elem1} }) {
			  if ($nl_itemname_grammar_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
				if ($loopcnt == 0) {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance9_hash{$elem1});
				}

				$loopcnt++;

				$temp_elem2 = $elem2;
				if (defined $nl_itemname_grammar_filtered_nuance9_hash{$elem1}{$elem2}) {
				  $temp_elem2 = $nl_itemname_grammar_filtered_nuance9_hash{$elem1}{$elem2};
				}

				if ($$general_args{"normalization_level"} != 0) {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_itemname_grammar_nuance9_hash{$elem1}{$elem2})."\">%s</item>\n", $temp_elem2);
				} else {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "\t<item weight=\"".$nl_itemname_grammar_nuance9_hash{$elem1}{$elem2}."\">%s</item>\n", $temp_elem2);
				}

				$temp_elem2 = $elem2;
				$temp_elem2 =~ s/\ª//g;
				$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

				$word_list_hash{$temp_word_list}{$elem1}++;
			  }
			}
		  }

		  if ($$nuance9_args{"do_robust_parsing"}) {
			foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_itemname_grammar_rp_nuance9_hash{$elem1} }) {
			  if ($nl_itemname_grammar_rp_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
				if ($loopcnt == 0) {
				  printf (TRAINING_robust_parsing_nuance9 "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance9_hash{$elem1});
				}

				$loopcnt++;

				if ($$general_args{"normalization_level"} != 0) {
				  printf (TRAINING_robust_parsing_nuance9 "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_itemname_grammar_rp_nuance9_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
				} else {
				  printf (TRAINING_robust_parsing_nuance9 "\t<item weight=\"".$nl_itemname_grammar_rp_nuance9_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
				}

				$temp_elem2 = $elem2;
				$temp_elem2 =~ s/\ª//g;
				$temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

				$word_list_hash{$temp_word_list}{$elem1}++;
			  }
			}
		  }

		  $loopcnt2 = 0;
		  $probval = 0;
		  foreach $elem2 ( sort { $a cmp $b } keys %{ $nl_generic_itemname_nuance9_hash{$elem1} }) {
			if ($nl_generic_itemname_nuance9_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {

			  if ($loopcnt2 == 0) {
				if ($$nuance9_args{"do_robust_parsing"}) {
				  printf (TRAINING_robust_parsing_nuance9 "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance9_hash{$elem1});
				  print TRAINING_robust_parsing_nuance9 "\<\!-- \"Start Generic Section\"--\>\n";
				}

				if ($$nuance9_args{"do_normal_slm"}) {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "<rule id=\"%s\">\n<one-of>\n", $nl_itemcategories_pc_nuance9_hash{$elem1});
				  print NLITEMNAMEGRAMMAR_nuance9 "\<\!-- \"Start Generic Section\"--\>\n";
				}
			  }

			  $loopcnt++;
			  $loopcnt2++;

#					printf(NLITEMNAMEGRAMMAR_nuance9 "\t\t\t(%s)~%s\n", $elem2, $nl_generic_itemname_nuance9_hash{$elem1}{$elem2}/$nl_total_itemname_nuance9_hash{$elem1});
			  if ($$nuance9_args{"do_robust_parsing"}) {
				if ($$general_args{"normalization_level"} != 0) {
				  printf (TRAINING_robust_parsing_nuance9 "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_generic_itemname_nuance9_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
				} else {
				  printf (TRAINING_robust_parsing_nuance9 "\t<item weight=\"".$nl_generic_itemname_nuance9_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
				}
			  }

			  if ($$nuance9_args{"do_normal_slm"}) {
				if ($$general_args{"normalization_level"} != 0) {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "\t<item weight=\"".$$general_args{"normalization_level"} + ($nl_generic_itemname_nuance9_hash{$elem1}{$elem2})."\">%s</item>\n", $elem2);
				} else {
				  printf(NLITEMNAMEGRAMMAR_nuance9 "\t<item weight=\"".$nl_generic_itemname_nuance9_hash{$elem1}{$elem2}."\">%s</item>\n", $elem2);
				}
			  }

			  $probval += $nl_generic_itemname_nuance9_hash{$elem1}{$elem2};

			  $temp_elem2 = $elem2;
			  $temp_elem2 =~ s/\ª//g;
			  $temp_word_list = GenWordListRemoveStopWords($meaning_args, $wordnet_args, $temp_elem2, $wordlist_already_hash);

			  $word_list_hash{$temp_word_list}{$elem1}++;
			}
		  }

		  if ($loopcnt2 > 0) {
			if ($$nuance9_args{"do_robust_parsing"}) {
			  print TRAINING_robust_parsing_nuance9 "\<\!-- \"End Generic Section\"--\>\n";
			}

			if ($$nuance9_args{"do_normal_slm"}) {
			  print NLITEMNAMEGRAMMAR_nuance9 "\<\!-- \"End Generic Section\"--\>\n";
			}
		  }

		  if ($loopcnt > 0) {
			if ($$nuance9_args{"do_robust_parsing"}) {
			  print TRAINING_robust_parsing_nuance9 "</one-of>\n</rule>\n";
			}

			if ($$nuance9_args{"do_normal_slm"}) {
			  print NLITEMNAMEGRAMMAR_nuance9 "</one-of>\n</rule>\n";
			}
		  }
		}

		if ($$nuance9_args{"do_robust_parsing"}) {
		  print TRAINING_robust_parsing_nuance9 "</grammar>\n";
		  close(TRAINING_robust_parsing_nuance9);
		}

		if ($$nuance9_args{"do_normal_slm"}) {
		  print NLITEMNAMEGRAMMAR_nuance9 "<\/grammar>\n";
		  close(NLITEMNAMEGRAMMAR_nuance9);
		}

		CheckWordList(\%word_list_hash, \%itemname2utt_hash);

# Nuance9 SLM FSM

#hereqaz131313: indent candidate
		open(TRAINING_slm_fsm_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_training_slm_fsm.xml") or die "cant write TRAINING_slm_fsm_nuance9";

		print TRAINING_slm_fsm_nuance9 "<\?xml version=\"1.0\" encoding=\"ISO-8859-1\"\?>\n";
		print TRAINING_slm_fsm_nuance9 "<\!DOCTYPE SLMTraining SYSTEM \"".$$nuance9_args{"swisrsdk_location"}."\/config\/SLMTraining.dtd\">\n<SLMTraining version=\"4.0.0\" xml:lang=\"".$$general_args{"main_language"}."\">\n";

		print TRAINING_slm_fsm_nuance9 "<!-- PARAMETER SETTINGS -->\n";

		foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
			if ($elem1 =~ /ngram_order/) {
				$ngram_order_found = 1;
			}
		}
		print TRAINING_slm_fsm_nuance9 "<param name=\"language\">\n\t<value>".$$general_args{"main_language"}."</value>\n</param>\n";

		if (!$ngram_order_found) {
			print TRAINING_slm_fsm_nuance9 "<param name=\"ngram_order\">\n\t<value>2</value>\n</param>\n";
		}

		print TRAINING_slm_fsm_nuance9 "<param name=\"fsm_out\">\n";
		print TRAINING_slm_fsm_nuance9 "<value>nuance9_ngram_SP.fsm<\/value>\n";
		print TRAINING_slm_fsm_nuance9 "<\/param>\n";
		print TRAINING_slm_fsm_nuance9 "<param name=\"wordlist_out\">\n";
		print TRAINING_slm_fsm_nuance9 "<value>nuance9_ngram_SP.wordlist<\/value>\n";
		print TRAINING_slm_fsm_nuance9 "<\/param>\n\n";

		foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"param"} }) {
			print TRAINING_slm_fsm_nuance9 "<param name=\"$elem1\"><value>";
			print TRAINING_slm_fsm_nuance9 $$osr_args{"training_items"}{"param"}{$elem1};
			print TRAINING_slm_fsm_nuance9 "<\/value><\/param>\n\n";
		}

		if ((scalar keys %{ $$osr_args{"training_items"}{"meta"} }) > 0) {
			print TRAINING_slm_fsm_nuance9 "<\!-- META PARAMETER INFORMATION -->\n";
			foreach $elem1 ( sort { $a cmp $b } keys %{ $$osr_args{"training_items"}{"meta"} }) {
				print TRAINING_slm_fsm_nuance9 "<meta name=\"$elem1\" content=\"", $$osr_args{"training_items"}{"meta"}{$elem1}, "\"/>\n";
			}
		}

		if ((scalar keys %{ $$nuance9_args{"add_dictionaries"} }) > 0) {
			print TRAINING_slm_fsm_nuance9 "\n\n";
			print TRAINING_slm_fsm_nuance9 "<\!-- DICTIONARY INFORMATION -->\n";
			foreach $elem1 ( sort { $a cmp $b } keys %{$$nuance9_args{"add_dictionaries"}}) {
			  printf(TRAINING_slm_fsm_nuance9 "<lexicon uri=\"%s\?SWI.type=backup\"/>\n", $elem1);
			}
		}

		print TRAINING_slm_fsm_nuance9 "\n\n";
		print TRAINING_slm_fsm_nuance9 "<\!-- VOCABULARY INFORMATION -->\n";
		print TRAINING_slm_fsm_nuance9 "<vocab>\n";
		foreach $elem1 ( sort { $a cmp $b } keys %{$$general_args{"full_vocab"}}) {
		  @test_array = grep {/\b$elem1\b/} @{$$osr_args{"training_stop_items"}};
		  if (scalar(@test_array) == 0) {
			printf(TRAINING_slm_fsm_nuance9 "<item>%s</item>\n", $elem1);
		  } else {
			$word_found = 0;
			foreach $elem2 (@test_array) {
			  if ($elem1 eq $elem2) {
				$word_found = 1;
			  }
			}

			if (!$word_found) {
			  printf(TRAINING_slm_fsm_nuance9 "<item>%s</item>\n", $elem1);
			}
		  }

		  @test_array = ();
		}

		print TRAINING_slm_fsm_nuance9 "<\!-- BEGIN STOP WORDS IN VOCABULARY -->\n";
		foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
		  printf(TRAINING_slm_fsm_nuance9 "<item>%s</item>\n", $elem1);
		}

		print TRAINING_slm_fsm_nuance9 "<\!-- END STOP WORDS IN VOCABULARY -->\n\n";

		$absolute_path = "./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_";
		foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}}) {
		  $modified_item = setClassGrammarVocabItem("fsm_nuance9", $elem1, $absolute_path);

		  print TRAINING_slm_fsm_nuance9 $modified_item;
		}

		print TRAINING_slm_fsm_nuance9 "</vocab>\n\n";

		print TRAINING_slm_fsm_nuance9 "<training>\n";

		foreach $elem1 ( sort { $a cmp $b } keys %nuance9_TAGGEDCORPUS_hash) {
			foreach $elem2 ( sort { $a cmp $b } keys %{$nuance9_TAGGEDCORPUS_hash{$elem1} }) {
				if ($nuance9_TAGGEDCORPUS_hash{$elem1}{$elem2} >= $$general_args{"min_freq"} ) {
					$elem3 = $elem2;
					$elem3 =~ s/<item>\n\t//g;
					$elem3 =~ s/\n<\/item>//g;
					$elem3 =~ s/<ruleref uri=\"\#(\w+)(\-(\w+))*\" \/>\n\t//g;
					$elem3 =~ s/<\/tag><tag>/:/g;
					$elem3 =~ s/<tag>//g;
					$elem3 =~ s/<\/tag>//g;

					$elem4 = $elem1;

					$elem3 =~ s/=/:/g;
					$elem3 =~ s/\'//g;
					$elem3 = ChopChar($elem3);

					foreach $elem5 ( sort { $a cmp $b } keys %{ $speakfreely_meaning_hash{$elem1} }) {
						$training_hash{$elem5}{$elem4} += $nuance9_TAGGEDCORPUS_hash{$elem1}{$elem2};
					}
				}
			}
		}

		foreach $elem1 ( sort { $a cmp $b } keys %training_hash) {
			foreach $elem2 ( sort { $a cmp $b } keys %{$training_hash{$elem1} }) {
				printf (TRAINING_slm_fsm_nuance9 "<sentence count=\"%s\">\n", $training_hash{$elem1}{$elem2}+$add_sentence_count);

				printf (TRAINING_slm_fsm_nuance9 "%s\n", $elem2);
				print TRAINING_slm_fsm_nuance9 "</sentence>\n";
			}
		}

		print TRAINING_slm_fsm_nuance9 "</training>\n\n";

		if ($$osr_args{"addtestfile"} ne "") {
			print TRAINING_slm_fsm_nuance9 "<test>\n";
			undef %test_hash;
			if ($$osr_args{"addtestfile"} !~ /createslm_applytags_test_input/) {
			  getAndCleanTestData($general_args, $cleaning_args, $osr_args, $cat_args, \%test_hash, $referencetag_hash);
			} else {
				open(ADDTEST,"<".$$osr_args{"addtestfile"}) or die "cant open ".$$osr_args{"addtestfile"};

				undef %test_hash;
				while(<ADDTEST>) {
					$line = $_;

					if (substr($line,0,1) eq "#") {
						next;
					}

					$line = ChopChar($line);

					($filename, $corrected_sentence, $item_category, $orig_sentence) = split "\t", $line;
					$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
					if ((lc($item_category) !~ /blank/)) {
						my($temp_elem) = $orig_sentence;

						$temp_elem =~ s/\-/ /g;
						$temp_elem =~ s/\_/ /g;
						$temp_elem = TrimChars($temp_elem);
						if (defined $$cat_args{"sentence_cat_assignments"}{$temp_elem}) {
							if (lc($item_category) ne lc($$cat_args{"sentence_cat_assignments"}{$temp_elem})) {
								DebugPrint ("BOTH", 2, "CreateMainGrammar", $debug, $err_no++, "$item_category changed to ".$$cat_args{"sentence_cat_assignments"}{$orig_sentence}." for trans=$orig_sentence");

								$item_category = $$cat_args{"sentence_cat_assignments"}{$temp_elem};
								$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
							}
						}

						if ($corrected_sentence ne "") {
							$test_hash{$corrected_sentence}{$item_category}++;
						}
					}
				}
			}

			foreach $elem1 ( sort { $a cmp $b } keys %test_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{ $test_hash{$elem1} }) {
					print TRAINING_slm_fsm_nuance9 "<sentence meaning=\"".$$osr_args{"test_slotname"}.":",uc($elem2),":".$$osr_args{"test_confirm_as"}.":",uc($elem2),"\" count=\"", $test_hash{$elem1}{$elem2},"\">\n";
					print TRAINING_slm_fsm_nuance9 "    $elem1\n";
					print TRAINING_slm_fsm_nuance9 "</sentence>\n";
				}
			}

			print TRAINING_slm_fsm_nuance9 "</test>\n\n";
		}

		print TRAINING_slm_fsm_nuance9 "</SLMTraining>\n";

		close(TRAINING_slm_fsm_nuance9);

# Nuance9 Stop Words

		if ((scalar (@{$$osr_args{"training_stop_items"}})) > 0) {
		  open(TRAINING_stop_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_stop_words.grxml") or die "cant write TRAINING_stop_nuance9";

		  print TRAINING_stop_nuance9 "<?xml version='1.0'?>\n";
		  print TRAINING_stop_nuance9 "<grammar xmlns=\"http://www.w3.org/2001/06/grammar\"\n";
		  print TRAINING_stop_nuance9 "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n";
		  print TRAINING_stop_nuance9 "xsi:schemaLocation=\"http://www.w3.org/2001/06/grammar http://www.w3.org/TR/speech-grammar/grammar.xsd\"\n";
		  print TRAINING_stop_nuance9 "xml:lang=\"".$$general_args{"main_language"}."\" version=\"1.0\" root=\"root\" mode=\"voice\">\n";
		  print TRAINING_stop_nuance9 "\t<meta name=\"swirec_normalize_to_probabilities\" content=\"1\"/>\n";
		  print TRAINING_stop_nuance9 "<rule id=\"root\" scope=\"public\">\n";
		  print TRAINING_stop_nuance9 "\t<item>\n";
		  print TRAINING_stop_nuance9 "\t<one-of>\n";
		  print TRAINING_stop_nuance9 "\t\t<item><ruleref uri=\"#garbage\"/><tag>RETVAL=&apos;GARBAGE&apos;</tag></item>\n";
		  print TRAINING_stop_nuance9 "\t</one-of>\n";
		  print TRAINING_stop_nuance9 "\t</item>\n";
		  print TRAINING_stop_nuance9 "</rule>\n\n";
		  print TRAINING_stop_nuance9 "<rule id=\"garbage\" scope=\"public\">\n";
		  print TRAINING_stop_nuance9 "\t<item>\n";
		  print TRAINING_stop_nuance9 "\t<one-of>\n";

		  foreach $elem1 (@{$$osr_args{"training_stop_items"}}) {
			printf(TRAINING_stop_nuance9 "\t\t<item>%s</item>\n", $elem1);
		  }

		  print TRAINING_stop_nuance9 "\t</one-of>\n";
		  print TRAINING_stop_nuance9 "\t</item>\n";
		  print TRAINING_stop_nuance9 "</rule>\n\n";
		  print TRAINING_stop_nuance9 "</grammar>\n";

		  close(TRAINING_stop_nuance9);
		}

# Nuance9 Fragment Words

		if ((scalar (@{$$osr_args{"training_fragment_items"}})) > 0) {
		  open(TRAINING_fragment_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_fragment_words.grxml") or die "cant write TRAINING_fragment_nuance9";

		  print TRAINING_fragment_nuance9 "<?xml version='1.0'?>\n";
		  print TRAINING_fragment_nuance9 "<grammar xmlns=\"http://www.w3.org/2001/06/grammar\"\n";
		  print TRAINING_fragment_nuance9 "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n";
		  print TRAINING_fragment_nuance9 "xsi:schemaLocation=\"http://www.w3.org/2001/06/grammar http://www.w3.org/TR/speech-grammar/grammar.xsd\"\n";
		  print TRAINING_fragment_nuance9 "xml:lang=\"".$$general_args{"main_language"}."\" version=\"1.0\" root=\"root\" mode=\"voice\">\n";
#		  print TRAINING_fragment_nuance9 "xml:lang=\"en\" version=\"1.0\" root=\"root\" mode=\"voice\">\n";
		  print TRAINING_fragment_nuance9 "\t<meta name=\"swirec_normalize_to_probabilities\" content=\"1\"/>\n";
		  print TRAINING_fragment_nuance9 "<rule id=\"root\" scope=\"public\">\n";
		  print TRAINING_fragment_nuance9 "\t<item>\n";
		  print TRAINING_fragment_nuance9 "\t<one-of>\n";
		  print TRAINING_fragment_nuance9 "\t\t<item><ruleref uri=\"#fragment\"/><tag>RETVAL=&apos;FRAGMENTS&apos;</tag></item>\n";
		  print TRAINING_fragment_nuance9 "\t</one-of>\n";
		  print TRAINING_fragment_nuance9 "\t</item>\n";
		  print TRAINING_fragment_nuance9 "</rule>\n\n";
		  print TRAINING_fragment_nuance9 "<rule id=\"fragment\" scope=\"public\">\n";
		  print TRAINING_fragment_nuance9 "\t<item>\n";
		  print TRAINING_fragment_nuance9 "\t<one-of>\n";

		  foreach $elem1 (@{$$osr_args{"training_fragment_items"}}) {
			printf(TRAINING_fragment_nuance9 "\t\t<item>%s</item>\n", $elem1);
		  }

		  print TRAINING_fragment_nuance9 "\t</one-of>\n";
		  print TRAINING_fragment_nuance9 "\t</item>\n";
		  print TRAINING_fragment_nuance9 "</rule>\n\n";
		  print TRAINING_fragment_nuance9 "</grammar>\n";

		  close(TRAINING_fragment_nuance9);
		}

# Nuance9 Stem Words

		if ((scalar (@{$$osr_args{"training_stem_items"}})) > 0) {
		  open(TRAINING_stem_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_stem_words.grxml") or die "cant write TRAINING_stem_nuance9";

		  print TRAINING_stem_nuance9 "<?xml version='1.0'?>\n";
		  print TRAINING_stem_nuance9 "<grammar xmlns=\"http://www.w3.org/2001/06/grammar\"\n";
		  print TRAINING_stem_nuance9 "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n";
		  print TRAINING_stem_nuance9 "xsi:schemaLocation=\"http://www.w3.org/2001/06/grammar http://www.w3.org/TR/speech-grammar/grammar.xsd\"\n";
		  print TRAINING_stem_nuance9 "xml:lang=\"".$$general_args{"main_language"}."\" version=\"1.0\" root=\"root\" mode=\"voice\">\n";
		  print TRAINING_stem_nuance9 "\t<meta name=\"swirec_normalize_to_probabilities\" content=\"1\"/>\n";
		  print TRAINING_stem_nuance9 "<rule id=\"root\" scope=\"public\">\n";
		  print TRAINING_stem_nuance9 "\t<item>\n";
		  print TRAINING_stem_nuance9 "\t<one-of>\n";
		  print TRAINING_stem_nuance9 "\t\t<item><ruleref uri=\"#stem\"/><tag>RETVAL=&apos;STEMS&apos;</tag></item>\n";
		  print TRAINING_stem_nuance9 "\t</one-of>\n";
		  print TRAINING_stem_nuance9 "\t</item>\n";
		  print TRAINING_stem_nuance9 "</rule>\n\n";
		  print TRAINING_stem_nuance9 "<rule id=\"stem\" scope=\"public\">\n";
		  print TRAINING_stem_nuance9 "\t<item>\n";
		  print TRAINING_stem_nuance9 "\t<one-of>\n";

		  foreach $elem1 (@{$$osr_args{"training_stem_items"}}) {
			printf(TRAINING_stem_nuance9 "\t\t<item>%s</item>\n", $elem1);
		  }

		  print TRAINING_stem_nuance9 "\t</one-of>\n";
		  print TRAINING_stem_nuance9 "\t</item>\n";
		  print TRAINING_stem_nuance9 "</rule>\n\n";
		  print TRAINING_stem_nuance9 "</grammar>\n";

		  close(TRAINING_stem_nuance9);
		}

# Nuance9 SSM

#hereqaz141414: indent candidate
		open(TRAINING_ssm_nuance9,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/".$$general_args{"grammarbase"}."_nuance9_training_ssm.xml") or die "cant write TRAINING_ssm_nuance9";

		print TRAINING_ssm_nuance9 "<\?xml version=\"1.0\" encoding=\"UTF-8\"\?>\n";
		print TRAINING_ssm_nuance9 "<\!DOCTYPE SSMTraining SYSTEM \"".$$nuance9_args{"swisrsdk_location"}."\/config\/SSMTraining.dtd\">\n";
		print TRAINING_ssm_nuance9 "<SSMTraining version=\"4.0.0\" xml:lang=\"".$$general_args{"main_language"}."\">\n";

		print TRAINING_ssm_nuance9 "<\!-- FEATURES INFORMATION -->\n";
		print TRAINING_ssm_nuance9 "<features>\n";
		if ((scalar (@{$$osr_args{"training_fragment_items"}})) > 0) {
		  print TRAINING_ssm_nuance9 "\t<ruleref uri=\"".$$general_args{"grammarbase"}."_nuance9_fragment_words.grxml"."#fragment\" feature_generation=\"fragment\"/>\n";
		}

		if ((scalar (@{$$osr_args{"training_stem_items"}})) > 0) {
		  print TRAINING_ssm_nuance9 "\t<ruleref uri=\"".$$general_args{"grammarbase"}."_nuance9_stem_words.grxml"."#stem\" feature_generation=\"stem\"/>\n";
		}

		if ((scalar (@{$$osr_args{"training_stop_items"}})) > 0) {
		  print TRAINING_ssm_nuance9 "\t<ruleref uri=\"".$$general_args{"grammarbase"}."_nuance9_stop_words.grxml"."#garbage\" feature_generation=\"remove\"/>\n";
		}

		foreach $elem1 ( sort { $a cmp $b } keys %{$$general_args{"full_vocab"}}) {
			printf(TRAINING_ssm_nuance9 "\t<word>%s</word>\n", $elem1);
		}

		$absolute_path = "./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_";
		foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}}) {
		  $modified_item = setClassGrammarVocabItem("ssm_nuance9", $elem1, $absolute_path);

		  print TRAINING_ssm_nuance9 $modified_item;
		}

		print TRAINING_ssm_nuance9 "</features>\n\n";


		print TRAINING_ssm_nuance9 "<semantic_models>\n";
		print TRAINING_ssm_nuance9 "\t<SSM>\n";
		print TRAINING_ssm_nuance9 "<!-- PARAMETER SETTINGS -->\n";

		$num_iterations_found = 0;
		$save_best_found = 0;
		$ssm_output_filename_found = 0;
		foreach $elem1 ( sort { $a cmp $b } keys %{ $$nuance9_args{"training_ssm_items"}{"param"} }) {
			if ($elem1 =~ /num_iterations/) {
				$num_iterations_found = 1;
			}

			if ($elem1 =~ /save_best/) {
				$save_best_found = 1;
			}

			if ($elem1 =~ /ssm_output_filename/) {
				$ssm_output_filename_found = 1;
			}
		}

		if (!$num_iterations_found) {
			print TRAINING_ssm_nuance9 "\t\t<param name=\"num_iterations\">\n\t\t\t<value>500<\/value>\n\t\t</param>\n";
		}

		if (!$save_best_found) {
			print TRAINING_ssm_nuance9 "\t\t<param name=\"save_best\">\n\t\t\t<value>true<\/value>\n\t\t</param>\n";
		}

		if (!$ssm_output_filename_found) {
			print TRAINING_ssm_nuance9 "\t\t<param name=\"ssm_output_filename\">\n\t\t\t<value>".$$general_args{"grammarbase"}."_nuance9_training_ssm<\/value>\n\t\t</param>\n";
		}

		foreach $elem1 ( sort { $a cmp $b } keys %{ $$nuance9_args{"training_ssm_items"}{"param"} }) {
			print TRAINING_ssm_nuance9 "<param name=\"$elem1\"><value>";
			print TRAINING_ssm_nuance9 $$nuance9_args{"training_ssm_items"}{"param"}{$elem1};
			print TRAINING_ssm_nuance9 "<\/value><\/param>\n\n";
		}


		foreach $elem1 ( sort { $a cmp $b } keys %training_hash) {
			($slot_name, $slot_val, $confirm_name, $confirm_val) = split ":", $elem1;
			printf (TRAINING_ssm_nuance9 "\t\t<meaning>\n\t\t\t<slot name=\"%s\">%s</slot>\n\t\t\t<slot name=\"%s\">%s</slot>\n\t\t</meaning>\n", $slot_name, $slot_val, $confirm_name, $confirm_val);
		}



#		print TRAINING_ssm_nuance9 "\t\t<meaning prior=\"1.0\">\n";
#		print TRAINING_ssm_nuance9 "\t\t\t<slot name=\"route\">tech_support</slot>\n";
#		print TRAINING_ssm_nuance9 "\t\t</meaning>\n";
#		print TRAINING_ssm_nuance9 "\t\t<meaning prior=\"0.8\">\n";
#		print TRAINING_ssm_nuance9 "\t\t\t<slot name=\"route\">sales</slot>\n";
#		print TRAINING_ssm_nuance9 "\t\t</meaning>\n";


		print TRAINING_ssm_nuance9 "\t</SSM>\n";
		print TRAINING_ssm_nuance9 "</semantic_models>\n\n";

		print TRAINING_ssm_nuance9 "<training>\n";

		foreach $elem1 ( sort { $a cmp $b } keys %training_hash) {
			foreach $elem2 ( sort { $a cmp $b } keys %{$training_hash{$elem1} }) {
				($slot_name, $slot_val, $confirm_name, $confirm_val) = split ":", $elem1;
#				if (($training_hash{$elem1}{$elem2} >= 2) || (defined $$general_args{"just_keywords"}{$elem2})) {
#				} else {
					printf (TRAINING_ssm_nuance9 "<sentence count=\'%s\'>\n\t<semantics>\n\t\t<slot name=\"%s\">%s</slot>\n\t\t<slot name=\"%s\">%s</slot>\n\t</semantics>\n", $training_hash{$elem1}{$elem2}+$add_sentence_count, $slot_name, $slot_val, $confirm_name, $confirm_val);
#				}

				printf (TRAINING_ssm_nuance9 "    %s\n", $elem2);
				print TRAINING_ssm_nuance9 "</sentence>\n";
			}
		}

		print TRAINING_ssm_nuance9 "</training>\n\n";


		if ($$osr_args{"addtestfile"} ne "") {
			if ($$osr_args{"addtestfile"} !~ /createslm_applytags_test_input/) {
				print TRAINING_ssm_nuance9 "<test>\n";

				foreach $elem1 ( sort { $a cmp $b } keys %test_hash) {
					foreach $elem2 ( sort { $a cmp $b } keys %{ $test_hash{$elem1} }) {
						printf (TRAINING_ssm_nuance9 "<sentence count=\'%s\'>\n\t<semantics>\n\t\t<slot name=\"%s\">%s</slot>\n\t\t<slot name=\"%s\">%s</slot>\n\t</semantics>\n", $test_hash{$elem1}{$elem2}, $$osr_args{"test_slotname"}, uc($elem2), $$osr_args{"test_confirm_as"}, uc($elem2));
#						print TRAINING_ssm_nuance9 "<sentence meaning=\"".$$osr_args{"test_slotname"}.":",uc($elem2),":".$$osr_args{"test_confirm_as"}.":",uc($elem2),"\" count=\"", $test_hash{$elem1}{$elem2},"\">\n";
						print TRAINING_ssm_nuance9 "    $elem1\n";
						print TRAINING_ssm_nuance9 "</sentence>\n";
					}
				}

				print TRAINING_ssm_nuance9 "</test>\n\n";
			}
		}

		print TRAINING_ssm_nuance9 "</SSMTraining>\n";

		close(TRAINING_ssm_nuance9);

		open(BATCHFILE,">"."slmdirect_results\/slmp_compile_nuance9.bat") or die "cant write BATCHFILE";

		print BATCHFILE "sgc -train ".$$general_args{"grammarbase"}."_nuance9_training_slm_fsm.xml"." -no_gram\n\n";
		if ($$nuance9_args{"do_normal_slm"}) {
			print BATCHFILE "ssm_train ".$$general_args{"grammarbase"}."_nuance9_training_ssm.xml"."\n";
			print BATCHFILE "sgc ".$$general_args{"grammarbase"}."_nuance9_wrapper.grxml"."\n";
#			print BATCHFILE "sgc ".$$general_args{"grammarbase"}."_nuance9_top.grxml"."\n";
		}

		close(BATCHFILE);

		if ($$general_args{"run_bats"}) {
			my($cmd);
			$cmd = "cmd /c slmp_compile_nuance9.bat>>"."slmdirect_results\/createslm_temp_bat_log";
			DebugPrint ("BOTH", 0.1, "CreateMainGrammar", $debug, $err_no++, "Running: slmp_compile_nuance9.bat ...");
			system($cmd);
		}
	}
}

sub Set_Elem_Format {

    my($changed_utt, $grammar_type, $ambig_active, $item_category, $confirmed_as, $test_slotname, $test_confirm_as, $rulename, $speakfreely_meaning_hash, $test_reject_name) = @_;

	my($elem);
	my($elem3);
	my($format_ambig);
	my($format_string);
	my($format_van);
	my($main_slotval);
	my($meaning_string) = "";
	my($my_slot1);
	my($my_slot2);
	my($retval) = "";
	my($scnt);
	my($slotname);
	my($slotval);
	my(@slot_pair_array);

	$my_slot1 = $item_category;
	$my_slot2 = $confirmed_as;

	if ($confirmed_as eq "") {
		$my_slot2 = $item_category;
	}

	if ($grammar_type eq "NUANCE_GSL") {
		if ($item_category eq "...external...") {
			$format_van = "{<ExternalSlot \"EXTERNAL\">}";
		} else {
			$format_van = "\{<$test_slotname \"%s\"> <$test_confirm_as \"%s\"> <Spokentext \$string>}";
			$format_ambig = "\{<ambig_key \"%s\"> <$test_confirm_as \"%s\"> <Spokentext \$string>}";
		}
	}

	if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
		if ($item_category eq "...external...") {
			$format_van = "<tag>ExternalSlot='EXTERNAL'</tag>";
		} else {
			$format_van = "<item>\n\t<ruleref uri=\"#$rulename\" \/>\n\t<tag>$test_slotname=\'%s\'</tag><tag>$test_confirm_as=\'%s\'</tag>\n<\/item>\n";
			$format_ambig = "<item>\n\t<ruleref uri=\"#$rulename\" \/>\n\t<tag>AMBIG_KEY=\'%s\'</tag><tag>$test_confirm_as=\'%s\'</tag>\n<\/item>\n";
		}
	}


	if ($ambig_active) {
		$format_string = $format_ambig;
	} else {
		$format_string = $format_van;
	}

	if ($my_slot1 =~ /\&/) {
		$rulename =~ s/(\&|\,)/_/g;
		$confirmed_as =~ s/(\&|\,)/_/g;
		if ($grammar_type eq "NUANCE_GSL") {
			$elem3 = "{";
		}

		if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
			$elem3 = "\t<item>\n\t<ruleref uri=\"#$rulename\" \/>\n\t";
		}

		@slot_pair_array = split ",", $my_slot1;
		$scnt = 0;
		foreach $elem (@slot_pair_array) {
			($slotname, $slotval) = split /\&/, $elem;
			if (!$scnt) {
				$main_slotval = $slotval;
			}

			$scnt++;

			if ($grammar_type eq "NUANCE_GSL") {
				if ($item_category eq "...external...") {
					$elem3 = $elem3." <ExternalSlot \"EXTERNAL\">";
				} else {
					$elem3 = $elem3." <$slotname \"$slotval\">";
				}
			}

			if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
				if ($item_category eq "...external...") {
					$elem3 = $elem3." <tag>ExternalSlot=\'EXTERNAL\'</tag>";
				} else {
					$elem3 = $elem3." <tag>$slotname=\'$slotval\'</tag>";
				}

				if ($meaning_string eq "") {
#					$meaning_string = uc($slotname).":".uc($slotval);
					$meaning_string = $slotname.":".$slotval;
				} else {
#					$meaning_string = $meaning_string.":".uc($slotname).":".uc($slotval);
					$meaning_string = $meaning_string.":".$slotname.":".$slotval;
				}
			}

		}

		if ($grammar_type eq "NUANCE_GSL") {
			if ($my_slot2 =~ /\&/) {
				if ($item_category eq "...external...") {
					$elem3 = $elem3." <Spokentext \$string>";
				} else {
					$elem3 = $elem3." <$test_confirm_as \"$main_slotval\"> <Spokentext \$string>";
				}
			}

			$elem3 = $elem3."}";

			$item_category =~ s/(\&|\,)/_/g;
		}

		if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
			if ($my_slot2 =~ /\&/) {
				if ($item_category ne "...external...") {
					$elem3 = $elem3."<tag>$test_confirm_as=\'$main_slotval\'</tag>";
				}

				if ($meaning_string eq "") {
#					$meaning_string = uc($test_confirm_as).":".uc($main_slotval);
					$meaning_string = $test_confirm_as.":".$main_slotval;
				} else {
#					$meaning_string = $meaning_string.":".uc($test_confirm_as).":".uc($main_slotval);
					$meaning_string = $meaning_string.":".$test_confirm_as.":".$main_slotval;
				}
			} else {
				if ($item_category ne "...external...") {
					$elem3 = $elem3."<tag>$test_confirm_as=\'$my_slot2\'</tag>";
				}

				if ($meaning_string eq "") {
#					$meaning_string = uc($test_confirm_as).":".uc($my_slot2);
					$meaning_string = $test_confirm_as.":".$my_slot2;
				} else {
#					$meaning_string = $meaning_string.":".uc($test_confirm_as).":".uc($my_slot2);
					$meaning_string = $meaning_string.":".$test_confirm_as.":".$my_slot2;
				}
			}

			$elem3 = $elem3."\n\t<\/item>";
		}
	} else {
		if (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
			$rulename = NormCat($rulename, $test_reject_name);
		}

		$elem3 = sprintf($format_string, $my_slot1, $my_slot2);

		if ($meaning_string eq "") {
#			$meaning_string = uc($test_slotname).":".uc($my_slot1).":".uc($test_confirm_as).":".uc($my_slot2);
			$meaning_string = $test_slotname.":".$my_slot1.":".$test_confirm_as.":".$my_slot2;
		} else {
#			$meaning_string = $meaning_string.":".$test_slotname.":".$my_slot1.":".$test_confirm_as.":".$my_slot2;
			$meaning_string = $meaning_string.":".uc($test_slotname).":".uc($my_slot1).":".uc($test_confirm_as).":".uc($my_slot2);
		}
	}

	if ($grammar_type eq "NUANCE_GSL") {
		$retval = $item_category;
	} elsif (($grammar_type eq "NUANCE_SPEAKFREELY") || ($grammar_type eq "NUANCE9")) {
		$retval = $rulename;
		$$speakfreely_meaning_hash{RemoveChar("_", $changed_utt)}{$meaning_string}++;
	}

	return($retval, $confirmed_as, $elem3);
}

sub FillGrammarElements
{
    my($general_args, $gen_grammar_elem_hash, $repeat_num, $changed_utt, $filtered_utt, $item_category, $ambig_active, $grammar_type, $utt_source) = @_;

	my($grammarPrefix);

	if (lc($changed_utt) =~ /\*blank\*/) {
		return;
	}

	$item_category = NormCat($item_category, $$general_args{"test_reject_name"});
	$filtered_utt = alignUtts($changed_utt, $filtered_utt);
	if ($grammar_type eq "NUANCE_GSL_FILLER") {
	  $grammarPrefix = "N_G_F";
	}

	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
	  $grammarPrefix = "N_G";
	}

	if ($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") {
	  $grammarPrefix = "N_S";
	}

	if ($$general_args{"grammar_type"} eq "NUANCE9") {
	  $grammarPrefix = "N9";
	}

	$$gen_grammar_elem_hash{"$grammarPrefix:$changed_utt:$filtered_utt:$item_category:$ambig_active:$utt_source:$repeat_num"}++;
}

sub retrieveGrammarElements
{
    my($general_args, $cleaning_args, $gen_grammar_elem_hash, $gen_grammar_type, $changed_utt, $filtered_utt, $item_category, $ambig_active) = @_;

	my($confirmed_as) = "";
	my($rulename) = "";
	my($temp_changed_utt) = "";
	my($temp_elem) = "";
	my($temp_filtered_utt) = "";
	my($temp_word_list);

	($item_category, $confirmed_as) = SetConfirm_As($item_category);
	$filtered_utt = retrieveUtts($changed_utt, $filtered_utt);

	PutInVocab("retrieveGrammarElements", $$general_args{"make_vocab"}, $$general_args{"full_vocab"}, $changed_utt);

	$temp_changed_utt = $changed_utt;
	$temp_elem = $filtered_utt;
	if ($gen_grammar_type eq "N_G_F") {

	  $gen_grammar_type = "NUANCE_GSL_FILLER";
	  $temp_filtered_utt = $filtered_utt;

	  if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
		$temp_elem =~ s/\bmy\b/?MY/g;
		$temp_elem =~ s/\ba\b/?MY/g;
		$temp_elem =~ s/\ban\b/?MY/g;
		$temp_elem =~ s/\bthe\b/?MY/g;
		$temp_elem =~ s/\bhis\b/?MY/g;
		$temp_elem =~ s/\bher\b/?MY/g;
		$temp_elem =~ s/\bour\b/?MY/g;
		$temp_elem =~ s/\byour\b/?MY/g;
	  } elsif ($$general_args{"main_language"} eq "es-us") {
		$temp_elem =~ s/\bmis\b/?MI/g;
		$temp_elem =~ s/\bmi\b/?MI/g;
		$temp_elem =~ s/\btus\b/?MI/g;
		$temp_elem =~ s/\btu\b/?MI/g;
		$temp_elem =~ s/\buna\b/?MI/g;
		$temp_elem =~ s/\bun\b/?MI/g;
		$temp_elem =~ s/\bla\b/?MI/g;
		$temp_elem =~ s/\bel\b/?MI/g;
		$temp_elem =~ s/\blas\b/?MI/g;
		$temp_elem =~ s/\blos\b/?MI/g;
		$temp_elem =~ s/\bsu\b/?MI/g;
		$temp_elem =~ s/\bsus\b/?MI/g;
		$temp_elem =~ s/\bnuestra\b/?MI/g;
		$temp_elem =~ s/\bnuestro\b/?MI/g;
		$temp_elem =~ s/\bnuestras\b/?MI/g;
		$temp_elem =~ s/\bnuestros\b/?MI/g;
		$temp_elem =~ s/\bvuestra\b/?MI/g;
		$temp_elem =~ s/\bvuestro\b/?MI/g;
		$temp_elem =~ s/\bvuestras\b/?MI/g;
		$temp_elem =~ s/\bvuestros\b/?MI/g;
	  }
	}

	if ($gen_grammar_type eq "N_G") {
	  $gen_grammar_type = "NUANCE_GSL";
	  $temp_filtered_utt = $temp_changed_utt;
	  if ($filtered_utt ne "") {
		$temp_filtered_utt = $filtered_utt;
	  }

	  $temp_elem = FilterAmbigWords($general_args, $cleaning_args, $temp_filtered_utt);

	  if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
		$temp_elem =~ s/\bmy\b/?MY/g;
		$temp_elem =~ s/\ba\b/?MY/g;
		$temp_elem =~ s/\ban\b/?MY/g;
		$temp_elem =~ s/\bthe\b/?MY/g;
		$temp_elem =~ s/\bhis\b/?MY/g;
		$temp_elem =~ s/\bher\b/?MY/g;
		$temp_elem =~ s/\bour\b/?MY/g;
		$temp_elem =~ s/\byour\b/?MY/g;
	  } elsif ($$general_args{"main_language"} eq "es-us") {
		$temp_elem =~ s/\bmis\b/?MI/g;
		$temp_elem =~ s/\bmi\b/?MI/g;
		$temp_elem =~ s/\btus\b/?MI/g;
		$temp_elem =~ s/\btu\b/?MI/g;
		$temp_elem =~ s/\buna\b/?MI/g;
		$temp_elem =~ s/\bun\b/?MI/g;
		$temp_elem =~ s/\bla\b/?MI/g;
		$temp_elem =~ s/\bel\b/?MI/g;
		$temp_elem =~ s/\blas\b/?MI/g;
		$temp_elem =~ s/\blos\b/?MI/g;
		$temp_elem =~ s/\bsu\b/?MI/g;
		$temp_elem =~ s/\bsus\b/?MI/g;
		$temp_elem =~ s/\bnuestra\b/?MI/g;
		$temp_elem =~ s/\bnuestro\b/?MI/g;
		$temp_elem =~ s/\bnuestras\b/?MI/g;
		$temp_elem =~ s/\bnuestros\b/?MI/g;
		$temp_elem =~ s/\bvuestra\b/?MI/g;
		$temp_elem =~ s/\bvuestro\b/?MI/g;
		$temp_elem =~ s/\bvuestras\b/?MI/g;
		$temp_elem =~ s/\bvuestros\b/?MI/g;
	  }

#		$temp_word_list = GenWordList($$general_args{"main_language"}, $temp_elem, $wordlist_already_hash);
	}

	if ($gen_grammar_type eq "N_S") {
	  $gen_grammar_type = "NUANCE_SPEAKFREELY";
	  $temp_changed_utt = ApplyClassGrammars ($general_args, $cleaning_args, $item_category, $changed_utt);

	  if ($confirmed_as eq "") {
		$rulename = "a-".$item_category."-".$item_category;
	  } else {
		$rulename = "a-".$item_category."-".$confirmed_as;
	  }

	  if ($item_category eq "") {
		$rulename = "***UNKNOWN***";
	  }

	  $temp_filtered_utt = $temp_changed_utt;
	  if ($filtered_utt ne "") {
		$temp_filtered_utt = ApplyClassGrammars ($general_args, $cleaning_args, $item_category, $filtered_utt);
	  }

	  $temp_elem = FilterAmbigWords($general_args, $cleaning_args, $temp_filtered_utt);
	}

	if ($gen_grammar_type eq "N9") {
	  $gen_grammar_type = "NUANCE9";
	  $temp_changed_utt = ApplyClassGrammars ($general_args, $cleaning_args, $item_category, $changed_utt);

	  if ($confirmed_as eq "") {
		$rulename = "a-".$item_category."-".$item_category;
	  } else {
		$rulename = "a-".$item_category."-".$confirmed_as;
	  }

	  if ($item_category eq "") {
		$rulename = "***UNKNOWN***";
	  }

	  $temp_filtered_utt = $temp_changed_utt;
	  if ($filtered_utt ne "") {
		$temp_filtered_utt = ApplyClassGrammars ($general_args, $cleaning_args, $item_category, $filtered_utt);
	  }

	  $temp_elem = FilterAmbigWords($general_args, $cleaning_args, $temp_filtered_utt);
	}

	return ($gen_grammar_type, $temp_changed_utt, $temp_filtered_utt, $confirmed_as, $temp_elem, $rulename)
}

############# END Grammar Creation SUBROUTINES #######################

######################################################################
######################################################################
############# Merge Processing SUBROUTINES ###########################
######################################################################
######################################################################

sub CleanAddMergedElements
{
   my($use_original_wavfiles, $corrected_sentence, $filename_pre_search_string, $category_pre_search_string, $main_language, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $product_prefix_num, $contains_categories) = @_;

   my($lastchar);
   my($pre_search_string_count);
   my($filename_pre_search_string_count);
   my($category_pre_search_string_count);
   my($compression_ready);
   my($temp_category_pre_search_string);
   my($temp_filename_pre_search_string);
   my($temp_pre_search_string);

   if (($merge_nouns ne "") || ($merge_verbs ne "")) {
	 DebugPrint ("BOTH", 0.1, "CleanAddMergedElements", $debug, $err_no++, "Creating and Merging Additional Sentences ...");
	 $temp_pre_search_string = "";
	 ($temp_pre_search_string, $compression_ready) = AddMergedElements(0, $temp_pre_search_string, $main_language, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $product_prefix_num);

	 $temp_filename_pre_search_string = $temp_pre_search_string;
	 $lastchar = substr($temp_filename_pre_search_string,length($temp_filename_pre_search_string)-1,1);
	 if ($lastchar ne "º") {
	   $temp_filename_pre_search_string = $temp_filename_pre_search_string."º";
	 }

	 $temp_pre_search_string =~ s/^(.*?)\t//g;
	 $temp_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
	 $temp_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
	 $temp_pre_search_string =~ s/ \º/\º/g;

	 $temp_filename_pre_search_string =~ s/\t(.*?)\º/\º/g;
	 chop($temp_filename_pre_search_string);

	 $pre_search_string_count = scalar(split /\º/, $temp_pre_search_string);

	 if ($use_original_wavfiles) {
	   $filename_pre_search_string_count = scalar(split /\º/, $temp_filename_pre_search_string) - 1;
	 } else {
	   $filename_pre_search_string_count = 0;
	 }

	 if ($contains_categories) {
	   DebugPrint ("BOTH", 0.1, "CleanAddMergedElements", $debug, $err_no++, "Collecting merged sentences and categories ...");

	   $temp_category_pre_search_string = $temp_pre_search_string;
	   $temp_pre_search_string = $temp_pre_search_string."º";
	   $temp_pre_search_string =~ s/\t(.*?)\º/\º/g;
	   chop ($temp_pre_search_string);

	   $temp_category_pre_search_string =~ s/^(.*?)\t//g;
	   $temp_category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
	   $temp_category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
	   $temp_category_pre_search_string =~ s/ \º/\º/g;
	   $temp_category_pre_search_string =~ s/^(\t)//g;
	   $temp_category_pre_search_string =~ s/\º\t/\º/g;

	   $category_pre_search_string_count = scalar(split /\º/, $temp_category_pre_search_string);

	   $category_pre_search_string = $category_pre_search_string."º".$temp_category_pre_search_string;

	   $lastchar = substr($category_pre_search_string,length($category_pre_search_string)-1,1);
	   if ($lastchar ne "º") {
		 $category_pre_search_string = $category_pre_search_string."º";
	   }

	   $category_pre_search_string =~ s/\º/\n/g;
	 }

	 $corrected_sentence = $corrected_sentence."º".$temp_pre_search_string;
	 if ($use_original_wavfiles) {
	   $filename_pre_search_string = $filename_pre_search_string.$temp_filename_pre_search_string."º";
	 }
   }

   $lastchar = substr($corrected_sentence,length($corrected_sentence)-1,1);
   if ($lastchar ne "º") {
	 $corrected_sentence = $corrected_sentence."º";
   }

   if ($use_original_wavfiles) {
	 $lastchar = substr($filename_pre_search_string,length($filename_pre_search_string)-1,1);
	 if ($lastchar ne "º") {
	   $filename_pre_search_string = $filename_pre_search_string."º";
	 }
   }

   if (($merge_nouns ne "") || ($merge_verbs ne "")) {
	 DebugPrint ("BOTH", -1, "CleanAddMergedElements", $debug, $err_no++, " done\n");
   }

   return($corrected_sentence, $filename_pre_search_string, $category_pre_search_string);

}

sub AddMergedElements
{
    my($do_compression, $pre_search_string, $main_language, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $product_prefix_num) = @_;

	my($merge_noun_template_found) = 1;
	my($merge_verb_template_found) = 1;

	my($temp_sentence);
	my(%temp_sentence_hash);

	my($changed_utt);
	my($compression_ready) = "";
	my($item_category);

	my($noun_count) = 0;
	my($verb_count) = 0;

	my($elem);
	my($debug) = 0;
	my($line);
	my($i);
	my(@do_temp_array);
	my(@do_temp_array_2);

	unless (open(MERGENOUN,"<$merge_nouns")) {
		$merge_noun_template_found = 0;
	}

	unless (open(MERGEVERB,"<$merge_verbs")) {
		$merge_verb_template_found = 0;
	}

	if ($merge_noun_template_found) {
		while(<MERGENOUN>) {
			$line = $_;

			if (substr($line,0,1) eq "#") {
				next;
			}

			$line = ChopChar($line);

			($temp_sentence, $item_category) = split "\t", $line;

			undef %temp_sentence_hash;
			@do_temp_array = ();
			if ($temp_sentence =~ /[\||\?|\(|\)]/) {
				push @do_temp_array, "(".$temp_sentence.")";
				ProcessNounVerbSentences($main_language, \@do_temp_array, $debug, $merge_noun_verb_alias_hash, \%temp_sentence_hash);
			} else {
				$temp_sentence_hash{$temp_sentence}++;
			}

			foreach $temp_sentence ( sort { $a cmp $b } keys %temp_sentence_hash) {
				if ($temp_sentence eq "") {
					next;
				}

				$changed_utt = "$temp_sentence";

				@do_temp_array_2 = ();
				if ((scalar keys %{$merge_noun_prefix_hash} > 0)) {
					@do_temp_array_2 = sort { $a cmp $b } keys %{$merge_noun_prefix_hash};

					push @do_temp_array_2, "__NULL__";
				} else {
					push @do_temp_array_2, "__NULL__";
				}

				foreach $elem ( @do_temp_array_2 ) {
					if (($elem ne "__NULL__") && ($elem ne "<NULL>")) {
						$changed_utt = "$elem $temp_sentence";
					} else {
					  $changed_utt = "$temp_sentence";
					}

					for ($i = 0; $i < $product_prefix_num; $i++) {
					  if ($pre_search_string eq "") {
						$pre_search_string = "MERGE_NOUN\t$changed_utt\t$item_category";
					  } else {
						$pre_search_string = $pre_search_string."º"."MERGE_NOUN\t$changed_utt\t$item_category";
					  }

					  if ($do_compression) {
						$compression_ready = stringBuilder($compression_ready, $temp_sentence, "º");
					  }
					}

					$noun_count += $product_prefix_num;
				}
			}
		}

		DebugPrint ("BOTH", 1, "AddMergedElements", $debug, $err_no++, "Noun Sentences Generated: $noun_count");

		close(MERGENOUN);
	}

	if ($merge_verb_template_found) {
		while(<MERGEVERB>) {
			$line = $_;

			if (substr($line,0,1) eq "#") {
				next;
			}

			$line = ChopChar($line);

			($temp_sentence, $item_category) = split "\t", $line;

			undef %temp_sentence_hash;
			@do_temp_array = ();
			if ($temp_sentence =~ /[\||\?|\(|\)]/) {
				push @do_temp_array, "(".$temp_sentence.")";
				ProcessNounVerbSentences($main_language, \@do_temp_array, $debug, $merge_noun_verb_alias_hash, \%temp_sentence_hash);
			} else {
				$temp_sentence_hash{$temp_sentence}++;
			}

			foreach $temp_sentence ( sort { $a cmp $b } keys %temp_sentence_hash) {
				if ($temp_sentence eq "") {
					next;
				}

				$changed_utt = "$temp_sentence";

				@do_temp_array_2 = ();
				if ((scalar keys %{$merge_verb_prefix_hash} > 0)) {
					@do_temp_array_2 = sort { $a cmp $b } keys %{$merge_verb_prefix_hash};

					push @do_temp_array_2, "__NULL__";
				} else {
					push @do_temp_array_2, "__NULL__";
				}

				foreach $elem ( @do_temp_array_2 ) {
					if (($elem ne "__NULL__") && ($elem ne "<NULL>")) {
						$changed_utt = "$elem $temp_sentence";
					} else {
					  $changed_utt = "$temp_sentence";
					}

					for ($i = 0; $i < $product_prefix_num; $i++) {
					  $pre_search_string = stringBuilder($pre_search_string, "MERGE_VERB\t$changed_utt\t$item_category", "º");

					  if ($do_compression) {
						$compression_ready = stringBuilder($compression_ready, $temp_sentence, "º");
					  }
					}

					$verb_count += $product_prefix_num;
				}
			}
		}

		DebugPrint ("BOTH", 1, "AddMergedElements", $debug, $err_no++, "Verb Sentences Generated: $verb_count");

		close(MERGEVERB);
	}

	return ($pre_search_string, $compression_ready);
}

sub ManageAddMergedElements
{
   my($use_original_wavfiles, $corrected_sentence, $original_wavfile_array, $original_transcription_array, $original_cat_array, $main_language, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $product_prefix_num, $contains_categories) = @_;

   my($category_pre_search_string);
   my($category_pre_search_string_count);
   my($compression_ready);
   my($filename_pre_search_string);
   my($filename_pre_search_string_count);
   my($lastchar);
   my($pre_search_string);
   my($pre_search_string_count);
   my($temp_category_pre_search_string);
   my($temp_filename_pre_search_string);
   my($temp_pre_search_string);

   DebugPrint ("BOTH", 0.1, "ManageAddMergedElements", $debug, $err_no++, "Creating and Merging Additional Sentences ...");
   $temp_pre_search_string = "";
   ($temp_pre_search_string, $compression_ready) = AddMergedElements(1, $temp_pre_search_string, $main_language, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $product_prefix_num);

   $temp_filename_pre_search_string = $temp_pre_search_string;
   $lastchar = substr($temp_filename_pre_search_string,length($temp_filename_pre_search_string)-1,1);
   if ($lastchar ne "º") {
	 $temp_filename_pre_search_string = $temp_filename_pre_search_string."º";
   }

   $temp_pre_search_string =~ s/^(.*?)\t//g;
   $temp_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
   $temp_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
   $temp_pre_search_string =~ s/ \º/\º/g;

   $temp_filename_pre_search_string =~ s/\t(.*?)\º/\º/g;
   chop($temp_filename_pre_search_string);

   $pre_search_string_count = scalar(split /\º/, $temp_pre_search_string);

   if ($use_original_wavfiles) {
       $filename_pre_search_string_count = scalar(split /\º/, $temp_filename_pre_search_string) - 1;
   } else {
       $filename_pre_search_string_count = 0;
   }

   if ($contains_categories) {
	 DebugPrint ("BOTH", 0.1, "Sub::ManageAddMergedElements", $debug, $err_no++, "Collecting merged sentences and categories ...");

	 $temp_category_pre_search_string = $temp_pre_search_string;
	 $temp_pre_search_string = $temp_pre_search_string."º";
	 $temp_pre_search_string =~ s/\t(.*?)\º/\º/g;
	 chop ($temp_pre_search_string);

	 $temp_category_pre_search_string =~ s/^(.*?)\t//g;
	 $temp_category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t\º)/\º\º/g;
	 $temp_category_pre_search_string =~ s/(\º((\w| |\d|\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\<|\>|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\t)/\º/g;
	 $temp_category_pre_search_string =~ s/ \º/\º/g;
	 $temp_category_pre_search_string =~ s/^(\t)//g;
	 $temp_category_pre_search_string =~ s/\º\t/\º/g;

	 $category_pre_search_string_count = scalar(split /\º/, $temp_category_pre_search_string);

	 $category_pre_search_string = join "º", @$original_cat_array;
	 $category_pre_search_string = $category_pre_search_string."º".$temp_category_pre_search_string;
	 DebugPrint ("BOTH", -1, "ManageAddMergedElements", $debug, $err_no++, " done\n");
   }

#  print "pre_search_string_count=$pre_search_string_count, filename_pre_search_string_count=$filename_pre_search_string_count, category_pre_search_string_count=$category_pre_search_string_count\n";

   $corrected_sentence = $corrected_sentence."º".$temp_pre_search_string;

   $pre_search_string = join "º", @$original_transcription_array;
   $pre_search_string = $pre_search_string."º".$temp_pre_search_string;

   if ($use_original_wavfiles) {
       $filename_pre_search_string = join "º", @$original_wavfile_array;
       $filename_pre_search_string = $filename_pre_search_string."º".$temp_filename_pre_search_string."º";
       $filename_pre_search_string = substr($filename_pre_search_string,0, length($filename_pre_search_string)-1);
       @$original_wavfile_array = split /\º/, $filename_pre_search_string;
   }

   @$original_transcription_array = split /\º/, $pre_search_string;
   @$original_cat_array = split /\º/, $category_pre_search_string;

   $pre_search_string = "";
   $filename_pre_search_string = "";
   $category_pre_search_string = "";

   DebugPrint ("BOTH", -1, "ManageAddMergedElements", $debug, $err_no++, " done\n");

   return($corrected_sentence);

}

############# END Merge Processing SUBROUTINES #######################

######################################################################
######################################################################
############# Central Function SUBROUTINES ###########################
######################################################################
######################################################################

sub FillHashes
{
   my($general_args, $wordnet_args, $pos_corrected_array, $default_pos_hash, $wordnet_pointer_hash, $wordnet_hash, $replacement_frequency_hash, $pos_only_hash, $compressed_alias_sentence_array, $wordbag_compressed_sentence_array, $wordbag_compressed_alias_sentence_array, $do_filtercorpus_direct, $filtercorpus_direct_in, $contains_categories, $corrected_array, $compressed_sentence_array, $line_hash, $orig_2_line_hash, $filename_2_line_hash, $sentence_cat_assignments_hash, $original_wavfile_array, $original_transcription_array, $original_cat_array, $test_slotname, $test_confirm_as, $test_slotname_nuance_speakfreely, $test_confirm_as_nuance_speakfreely, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash, $osr_args) = @_;

   my($autotag_sentence);
   my($compressed_sentence);
   my($compressed_alias_sentence);
   my($corrected_sentence);
   my($elem1);
   my($elem2);
   my($filename);
   my($i);
   my($item_category);
   my($line);
   my($new_compressed_alias_sentence);
   my($orig_line);
   my($original_trans);
   my($pseudo_corrected_sentence);
   my($sent_begin);
   my($sent_end);
   my($sentence_order);
   my($wordbag_compressed_sentence);
   my($wordbag_compressed_alias_sentence);
   my(%autotag_repeat_hash);
   my(%sent_hash);

   if ($contains_categories) {
	   open(SENTOUT,">"."slmdirect_results\/createslm_init_sentences".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslm_init_sentences".$$general_args{"language_suffix"};

	   if ($do_filtercorpus_direct) {
		   open(SENTOUTFULL,">$filtercorpus_direct_in".$$general_args{"language_suffix"}) or die "cant write $filtercorpus_direct_in".$$general_args{"language_suffix"};
	   }

# ATTENTION - is sent_hash info needed?
#	   open(SENTCATOUT,">"."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment".$$general_args{"language_suffix"}) or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment".$$general_args{"language_suffix"};

   }

   if ($$wordnet_args{"do_autotag"}) {
	   open(ALIASSENTOUT,">"."slmdirect_results\/createslmDIR_wordnet_files\/autotag_synonym_replacement_assignment".$$general_args{"language_suffix"}) or die "cant write "."slmdirect_results\/createslmDIR_wordnet_files\/autotag_synonym_replacement_assignment".$$general_args{"language_suffix"};
	   print ALIASSENTOUT "Compressed Alias Sentence\t\[Ordered Synonym Replacement Sentence\]\n";
   }

   $sentence_order = 0;
   $autotag_sentence = "";

   open(WRITETRUTH, ">"."slmdirect_results/createslmDIR_truth_files/temp_truth_file") or die "Can't write "."slmdirect_results/createslmDIR_truth_files/temp_truth_file\n";

   foreach $original_trans (@$original_transcription_array) {
	 $filename = @$original_wavfile_array[$sentence_order];
	 $filename =~ s/\:/\!/g;
	 $corrected_sentence = @$corrected_array[$sentence_order];
#	 $pseudo_corrected_sentence = @$corrected_array[$sentence_order];
	 $pseudo_corrected_sentence = $corrected_sentence;

	 if ($contains_categories) {
	   $item_category = @$original_cat_array[$sentence_order];
	   $orig_line = $item_category."\t".$original_trans;
	   $line = NormCat($item_category, $$general_args{"test_reject_name"})."\t$corrected_sentence";

	   if ($$general_args{"create_regexp"}) {
	       $$filename_2_line_hash{$corrected_sentence}{$sentence_order} = $filename;
	   }

# ATTENTION - is sent_hash info needed?
#	   $sent_hash{$corrected_sentence}{$item_category}++;
	 } else {
	   $line = $corrected_sentence;
	   $orig_line = $original_trans;
	 }

	 print SENTOUT "$filename\t$corrected_sentence\n";

	 $line = TrimChars($line);

	 $$line_hash{$line}++;

	 if ($line eq $orig_line) {
	     $$orig_2_line_hash{$line}{"ç"}++;
	 } else {
	     $$orig_2_line_hash{$line}{$orig_line}++;
	 }

	 if ($$wordnet_args{"do_autotag"}) {
	   if (!$contains_categories) {
		 $compressed_sentence = @$compressed_sentence_array[$sentence_order];
		 $wordbag_compressed_sentence = @$wordbag_compressed_sentence_array[$sentence_order];
		 $wordbag_compressed_alias_sentence = @$wordbag_compressed_alias_sentence_array[$sentence_order];
		 $compressed_alias_sentence = @$compressed_alias_sentence_array[$sentence_order];

		 if ($compressed_sentence eq "Ç") {
		   $compressed_sentence = $corrected_sentence;
		 }

		 if ($wordbag_compressed_sentence eq "Ç") {
		   $wordbag_compressed_sentence = $compressed_sentence;
		 }

		 if ($compressed_alias_sentence eq "Ç") {
		   $compressed_alias_sentence = $compressed_sentence;
		 }

		 if ($wordbag_compressed_alias_sentence eq "Ç") {
		   $wordbag_compressed_alias_sentence = $compressed_alias_sentence;
		 } elsif ($wordbag_compressed_alias_sentence eq "ç") {
		   $wordbag_compressed_alias_sentence = $wordbag_compressed_sentence;
		 }

		 if (lc($compressed_sentence) =~ /___twm___/) {
		   $compressed_sentence = "";
		   $compressed_alias_sentence = "";
		   @$compressed_sentence_array[$sentence_order] = "";
		   @$compressed_alias_sentence_array[$sentence_order] = "";
		   @$wordbag_compressed_sentence_array[$sentence_order] = "";
		   @$wordbag_compressed_alias_sentence_array[$sentence_order] = "";
		 }

		 $new_compressed_alias_sentence = $autotag_repeat_hash{$compressed_alias_sentence};
		 if (not defined $new_compressed_alias_sentence) {

		   $new_compressed_alias_sentence = AutoTag($wordnet_args, $sentence_order, $wordbag_compressed_alias_sentence, $wordnet_pointer_hash, $wordnet_hash, $pos_only_hash, $default_pos_hash, $pos_corrected_array, $replacement_frequency_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash);

		   print ALIASSENTOUT "$compressed_alias_sentence\t\[$new_compressed_alias_sentence\]\n";

		   $autotag_repeat_hash{$compressed_alias_sentence} = $new_compressed_alias_sentence;
		 }

		 ($autotag_sentence, $sent_begin, $sent_end) = storeLocationInfoOrdered($new_compressed_alias_sentence, $autotag_sentence, $sentence_order);
	   }
	 } else {
	   if (lc($corrected_sentence) =~ /\*blank\*/) {
		 print WRITETRUTH "\"$filename\":$original_trans:__Blank__:$corrected_sentence\n";
	   } else {
		 print WRITETRUTH "\"$filename\":$original_trans:$pseudo_corrected_sentence:$corrected_sentence\n";
	   }
	 }

	 $sentence_order++;
   }

   close(WRITETRUTH);

   if (!$contains_categories) {
#	   if ($$wordnet_args{"do_autotag"}) {
#		   foreach $elem ( sort { $a cmp $b } keys %{$replacement_frequency_hash}) {
#			   ($pos, @temp_word_array) = split ":", $elem;
#			   $elem = join ":", @temp_word_array;
#			   foreach $elem1 (@temp_word_array) {
#				   $dup_hash{$pos}{$elem1}{$elem}++;
#			   }
#		   }
#
##		   $$wordnet_hash{$pos}{$temp_word_count} = [@sorted_final_array];
##		   $pointer = $$wordnet_pointer_hash{$pos}{$elem};
##		   if (defined $pointer) {
##			   $replacement = join ":", @{$$wordnet_hash{$pos}{$pointer}};
##
##		   foreach $elem ( sort { $a cmp $b } keys %dup_hash) {
##			   foreach $elem1 ( sort { $a cmp $b } keys %{$dup_hash{$elem}}) {
##				   if (scalar (keys %{$dup_hash{$elem}{$elem1}}) > 1) {
##					   print "\therezzz1: elem1=$elem1: \n";
##					   foreach $elem2 ( sort { $a cmp $b } keys %{$dup_hash{$elem}{$elem1}}) {
##						   print "\t\therezzz2: elem2=$elem2\n";
##					   }
##
##					   print "\n";
##				   }
##			   }
##		   }
#
#		   undef %dup_hash;

#		   DebugPrint ("BOTH", 1, "FillHashes", $debug, $err_no++, "WordNet Synonym Replacement Assignment File created: "."slmdirect_results\/createslmDIR_wordnet_files/autotag_synonym_replacement_assignment".$$general_args{"language_suffix"});
#	   }
   } else {
	   foreach $corrected_sentence ( sort { $a cmp $b } keys %sent_hash) {
		   if ($corrected_sentence eq "") {
			   next;
		   }

		   if ($do_filtercorpus_direct) {
			   foreach $elem1 ( sort { $a cmp $b } keys %{$sent_hash{$corrected_sentence}}) {
				   $item_category = NormCat($elem1, $$general_args{"test_reject_name"});
				   for ($i = 1; $i <= $sent_hash{$corrected_sentence}{$elem1}; $i++) {
					   print SENTOUTFULL "$item_category:$test_slotname:$test_confirm_as:$test_slotname_nuance_speakfreely:$test_confirm_as_nuance_speakfreely\t$corrected_sentence\n";
				   }
			   }
		   }

		   foreach $elem1 ( sort { $a cmp $b } keys %{ $sent_hash{$corrected_sentence} }) {
			   $elem2 = $corrected_sentence;
			   $elem2 =~ s/\-/ /g;
			   $elem2 =~ s/\_/ /g;
			   $elem2 = TrimChars($elem2);
			   $elem2 = ChopChar($elem2);
			   if ($$osr_args{"addtestfile"} ne "") {
				 $$sentence_cat_assignments_hash{$elem2} = $elem1;
			   }
			   print SENTCATOUT "$elem2\t$elem1\n";
		   }
	   }

	   undef %sent_hash;
   }

   close(ALIASSENTOUT);
   close(SENTOUT);
   close(SENTOUTFULL);
   close(SENTCATOUT);

   return ($autotag_sentence);
}

sub interpretCommand
{
    my($general_args, $wordnet_args, $pre_search_string, $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array) = @_;

	my($default_max_wordnet_count) = $$wordnet_args{"max_wordnet_count"};
	my($default_max_wordnet_sentence_length) = $$wordnet_args{"max_wordnet_sentence_length"};
	my($default_min_wordnet_frequency_adjective) = $$wordnet_args{"min_wordnet_frequency_adjective"};
	my($default_min_wordnet_frequency_noun) = $$wordnet_args{"min_wordnet_frequency_noun"};
	my($default_min_wordnet_frequency_verb) = $$wordnet_args{"min_wordnet_frequency_verb"};
	my($default_synonym_option) = $$wordnet_args{"synonym_option"};
	my($elem1);
	my($elem2);
	my($pos);
	my($s_counter);
	my($temp);
	my($temp_string);
	my($text);
	my($val);
	my($var);
	my(@syn_array);

	if (lc($pre_search_string) =~ /\+h/) {
		print "Available commands are:\n";
		print "\t+h [Displays this command information]\n\n";
		print "\t+cl [Change Language - changes main language between en-us (US English) and es-us (US Spanish)]\n\n";
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			print "\t+cs [Change Synonym - changes synonym options between 'loose' and 'strict']\n\n";
		}

		print "\t+ct [Change Type - changes grammar types between NUANCE_GSL, NUANCE_SPEAKFREELY and NUANCE9]\n\n";
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			print "\t+mss [Maximize Synonym Search - sets wordnet synonym variables to widest search values]\n\n";
		}

		print "\t+pa [Print All - prints information, and commands and sentences in the order entered]\n\n";
		print "\t+pc [Print Commands - prints commands in the order entered]\n\n";
		print "\t+pi [Print Information - prints information about all active variables]\n\n";
		print "\t+ps [Print Sentences - prints sentences in the order entered]\n\n";
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			print "\t+py [Print Synonyms - prints a list of currently specified synonyms]\n\n";
		}

		print "\t+rd [Restore Defaults - restores default values to all variables]\n\n";
		print "\t+sy [Synonyms - turns synonyms on and off]\n\n";

		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			print "\t+was noun|n|verb|v|adjective|a <word1>:<word2>[:<word3> ...] [Add Word Synonyms - associates words as synonyms.]\n\n";
			print "\t-was noun|n|verb|v|adjective|a <word> [Remove Word Synonyms - Removes any synonym association(s) for the word in the specified part of speech.]\n\n";
			print "\t+wcc|+wfn|+wfv|+wfa|+wsl <number> [Change WordNet Variables - change the value of WordNet variables]\n";
			print "\t\tWCC=WordNet Candidate Count [Maximum number of candidate words in a list of Synonyms, Hypernyms or Hyponyms]\n\t\tWFN=WordNet Frequency:Noun [Minimum Noun Frequency]\n\t\tWFV=WordNet Frequency:Verb [Minimum Verb Frequency]\n\t\tWFA=WordNet Frequency:Adjective [Minimum Adjective Frequency]\n\t\tWSL=WordNet Sentence Length [Maximum length for an original sentence to be considered for a synonym search]\n\n";
			print "\t+wdp noun|n|verb|v|adjective|a <word1>[:<word2>:<word3> ...] [Add Part of Speech - Add words with associated parts of speech that are missing from the WordNet database.]\n\n";
			print "\t+wff <word> noun|n|verb|v|adjective|a <number|-> [Set False Frequency - sets an artificial word frequency so that the word is included in or removed from the synonym search.  A '-' in place of a number removes the artificial frequency.]\n\n";
		}
	} elsif (lc($pre_search_string) =~ /\+ct/) {
		if ($grammar_type eq "NUANCE_SPEAKFREELY") {
			$grammar_type = "NUANCE_GSL";

		} elsif ($grammar_type eq "NUANCE_GSL") {
			$grammar_type = "NUANCE9";
		} elsif ($grammar_type eq "NUANCE9") {
			$grammar_type = "NUANCE_SPEAKFREELY";
		}

		push @$command_entered_array,  $pre_search_string;
		print "Grammar Type changed to $grammar_type\n\n";
	} elsif (lc($pre_search_string) =~ /\+cl/) {
		if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
			$main_language = "es-us";

		} elsif ($main_language eq "es-us") {
			$main_language = "en-us";
		}

		push @$command_entered_array,  $pre_search_string;
		print "Main Language changed to $main_language\n";
	} elsif (lc($pre_search_string) =~ /\+pa/) {
		interpretCommand($general_args, $wordnet_args, "+pi", $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array);
		interpretCommand($general_args, $wordnet_args, "+pc", $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array);
		interpretCommand($general_args, $wordnet_args, "+ps", $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array);
	} elsif (lc($pre_search_string) =~ /\+pc/) {
		$s_counter = 1;
		print "Commands entered:\n\n";
		foreach $elem1 (@$command_entered_array) {
			print "\t$s_counter: $elem1\n";
			$s_counter++;
		}

		print "\n";
	} elsif (lc($pre_search_string) =~ /\+ps/) {
		$s_counter = 1;
		print "Sentences entered:\n\n";
		foreach $elem1 (@$sentence_entered_array) {
			print "\t$s_counter: $elem1\n";
			$s_counter++;
		}

		print "\n";
	} elsif (lc($pre_search_string) =~ /\+((\d)+)/) {
		$s_counter = $1 - 1;
		$pre_search_string = @$sentence_entered_array[$s_counter];
		print "Re-running: $pre_search_string\n\n";
	} elsif (lc($pre_search_string) =~ /\+pi/) {
		print "\nCommon Variables:\n\tMain Language:\t\t$main_language\n\tGrammar Type:\t\t$grammar_type\n\n";
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			print "\nWordNet Variables:\n\tMaximum Wordnet Candidate Count(WCC):\t\t".$$wordnet_args{"max_wordnet_count"}."\n\tMinimum Wordnet Noun Frequency(WFN):\t\t".$$wordnet_args{"min_wordnet_frequency_noun"}."\n\tMinimum Wordnet Verb Frequency(WFV):\t\t".$$wordnet_args{"min_wordnet_frequency_verb"}."\n\tMinimum Wordnet Adjective Frequency(WFA):\t".$$wordnet_args{"min_wordnet_frequency_adjective"}."\n\tMaximum Wordnet Synonym Sentence Length(WSL):\t".$$wordnet_args{"max_wordnet_sentence_length"}."\n\tWordnet Synonym Search Type:\t\t\t".$$wordnet_args{"synonym_option"}."\n\n";
		}
	} elsif (lc($pre_search_string) =~ /\+rd/) {
		$main_language = $$general_args{"main_language"};
		$grammar_type = $$general_args{"grammar_type"};

		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			$$wordnet_args{"max_wordnet_count"} = $default_max_wordnet_count;
			$$wordnet_args{"min_wordnet_frequency_noun"} = $default_min_wordnet_frequency_noun;
			$$wordnet_args{"min_wordnet_frequency_verb"} = $default_min_wordnet_frequency_verb;
			$$wordnet_args{"min_wordnet_frequency_adjective"} = $default_min_wordnet_frequency_adjective;
			$$wordnet_args{"max_wordnet_sentence_length"} = $default_max_wordnet_sentence_length;
			$$wordnet_args{"synonym_option"} = $default_synonym_option;
		}

		print "All variables restored to default values\n\n";
		interpretCommand($general_args, $wordnet_args, "+pi", $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array);
	} elsif (lc($pre_search_string) =~ /\+sy/) {
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			$$wordnet_args{"do_synonyms"} = 0;
			print "Synonyms OFF\n\n";
		} elsif ((!$$wordnet_args{"do_synonyms"}) && $$wordnet_args{"wordnet_available"}) {
			$$wordnet_args{"do_synonyms"} = 1;
			print "Synonyms ON\n\n";
		} else {
			print "*** Wordnet not available ***\n\n";
		}
	} else {
		if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"}) {
			if (lc($pre_search_string) =~ /\+cs/) {
				if ($$wordnet_args{"synonym_option"} eq "loose") {
					$$wordnet_args{"synonym_option"} = "strict";
				} elsif ($$wordnet_args{"synonym_option"} eq "strict") {
					$$wordnet_args{"synonym_option"} = "loose";
				}

				push @$command_entered_array,  $pre_search_string;
				print "Synonym Option changed to ", $$wordnet_args{"synonym_option"}, "\n\n";
			} elsif (lc($pre_search_string) =~ /\+mss/) {
				$$wordnet_args{"max_wordnet_count"} = 100;
				$$wordnet_args{"min_wordnet_frequency_noun"} = 1;
				$$wordnet_args{"min_wordnet_frequency_verb"} = 1;
				$$wordnet_args{"min_wordnet_frequency_adjective"} = 1;
				$$wordnet_args{"max_wordnet_sentence_length"} = 1000;
				$$wordnet_args{"synonym_option"} = "loose";

				push @$command_entered_array,  $pre_search_string;
				print "Wordnet Synonym variables changed to widest search\n\n";
				interpretCommand($general_args, $wordnet_args, "+pi", $main_language, $scan_language, $grammar_type, $sentence_entered_array, $command_entered_array);
			} elsif (lc($pre_search_string) =~ /\+(wcc|wfn|wfv|wfa|wsl)\s+((\d)+)/) {
				$var = lc($1);
				$val = $2;

				if ($var eq "wcc") {
					$temp = $$wordnet_args{"max_wordnet_count"};
					$$wordnet_args{"max_wordnet_count"} = $val;
					$text = "WordNet Candidate Count";
				} elsif ($var eq "wfn") {
					$temp = $$wordnet_args{"min_wordnet_frequency_noun"};
					$$wordnet_args{"min_wordnet_frequency_noun"} = $val;
					$text = "WordNet Minimum Noun Frequency";
				} elsif ($var eq "wfv") {
					$temp = $$wordnet_args{"min_wordnet_frequency_verb"};
					$$wordnet_args{"min_wordnet_frequency_verb"} = $val;
					$text = "WordNet Minimum Verb Frequency";
				} elsif ($var eq "wfa") {
					$temp = $$wordnet_args{"min_wordnet_frequency_adjective"};
					$$wordnet_args{"min_wordnet_frequency_adjective"} = $val;
					$text = "WordNet Minimum Adjective Frequency";
				} elsif ($var eq "wsl") {
					$temp = $$wordnet_args{"max_wordnet_sentence_length"};
					$$wordnet_args{"max_wordnet_sentence_length"} = $val;
					$text = "WordNet Maximum Synonym Sentence Length";
				}

				push @$command_entered_array,  $pre_search_string;
				print "$text changed from $temp to $val\n";
			} elsif (lc $pre_search_string =~ /\+cg\s+(wcc|wfn|wfv|wfa|wsl)/) {
				$var = lc($1);

				if ($var eq "wcc") {
					$temp = $$wordnet_args{"max_wordnet_count"};
					$text = "WordNet Candidate Count";
				} elsif ($var eq "wfn") {
					$temp = $$wordnet_args{"min_wordnet_frequency_noun"};
					$text = "WordNet Minimum Noun Frequency";
				} elsif ($var eq "wfv") {
					$temp = $$wordnet_args{"min_wordnet_frequency_verb"};
					$text = "WordNet Minimum Verb Frequency";
				} elsif ($var eq "wfa") {
					$temp = $$wordnet_args{"min_wordnet_frequency_adjective"};
					$text = "WordNet Minimum Adjective Frequency";
				} elsif ($var eq "wsl") {
					$temp = $$wordnet_args{"max_wordnet_sentence_length"};
					$text = "WordNet Maximum Synonym Sentence Length";
				}

				push @$command_entered_array,  $pre_search_string;
				print "$text NOT changed from $temp\n";
			} elsif (lc($pre_search_string) =~ /\+py/) {
				print "Current Synonyms:\n\n";
				foreach $pos ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}}) {
					print "\tPart of Speech: $pos \n\n";
					foreach $elem1 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}}) {
						print "\t\tKeyword [$elem1]: ";
						foreach $elem2 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1}}) {
							print " $elem2";
						}

						print "\n";
					}

					print "\n\n";
				}

				print "\n";
			} elsif (lc($pre_search_string) =~ /\+wdp\s+(noun|n|verb|v|adjective|a)\s+((\w|\'|\:)+)/) {
				$pos = $1;
				$val = $2;

				if ($val =~ /\:/) {
					(@syn_array) = split ":", $val;
					if (scalar(@syn_array) > 1) {
						$temp_string = "wdp,$pos:$val";

						makePOSHashfromString($temp_string, $$wordnet_args{"add_wordnet_pos"});

						if ($pos eq "n") {
							$pos = "noun";
						} elsif ($pos eq "v") {
							$pos = "verb";
						} elsif ($pos eq "a") {
							$pos = "adjective";
						}

						$val =~ s/\:/, /g;
						push @$command_entered_array,  $pre_search_string;
						print "Word Parts of Speech associated as ", uc($pos), " for: $val\n";
					}
				}
			} elsif (lc($pre_search_string) =~ /\+wff\s+((\w|\')+)\s+(noun|n|verb|v|adjective|a)\s+((\d)+)/) {
				$var = lc($1);
				$pos = $3;
				$val = $4;

				if ($pos eq "n") {
					$pos = "noun";
				} elsif ($pos eq "v") {
					$pos = "verb";
				} elsif ($pos eq "a") {
					$pos = "adjective";
				}

				$$wordnet_args{"wordnet_false_frequency"}{$pos}{$var} = $val;

				push @$command_entered_array,  $pre_search_string;
				print "False Word Frequency for \"$var\" as ", uc($pos), " set to $val\n";
			} elsif (lc($pre_search_string) =~ /\+wff\s+((\w|\')+)\s+(noun|n|verb|v|adjective|a)\s+\-/) {
				$var = lc($1);
				$pos = $3;

				if ($pos eq "n") {
					$pos = "noun";
				} elsif ($pos eq "v") {
					$pos = "verb";
				} elsif ($pos eq "a") {
					$pos = "adjective";
				}

				undef $$wordnet_args{"wordnet_false_frequency"}{$pos}{$var};

				push @$command_entered_array,  $pre_search_string;
				print "False Word Frequency for \"$var\" as ", uc($pos), " removed\n";
			} elsif (lc($pre_search_string) =~ /\+was\s+(noun|n|verb|v|adjective|a)\s+((\w|\'|\:)+)/) {
				$pos = $1;
				$val = $2;

				if ($val =~ /\:/) {
					(@syn_array) = split ":", $val;
					if (scalar(@syn_array) > 1) {
						$temp_string = "was,$pos:$val";
						makeSynonymHashfromString($temp_string, $$wordnet_args{"alt_syn_default_pos"}, $$wordnet_args{"add_wordnet_synonym"});

						if ($pos eq "n") {
							$pos = "noun";
						} elsif ($pos eq "v") {
							$pos = "verb";
						} elsif ($pos eq "a") {
							$pos = "adjective";
						}

						$val =~ s/\:/, /g;
						push @$command_entered_array,  $pre_search_string;
						print "Word Synonyms associated as ", uc($pos), " for: $val\n";
					}
				}
			} elsif (lc($pre_search_string) =~ /\-was\s+(noun|n|verb|v|adjective|a)\s+((\w|\')+)/) {
				$pos = $1;
				$val = $2;

				if ($pos eq "n") {
					$pos = "noun";
				} elsif ($pos eq "v") {
					$pos = "verb";
				} elsif ($pos eq "a") {
					$pos = "adjective";
				}

				foreach $elem1 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}}) {
					if ($elem1 eq $val) {
						foreach $elem2 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1}}) {
							delete $$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1}{$elem2};
						}

						delete $$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1};
					}
				}

				foreach $elem1 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}}) {
					foreach $elem2 ( sort { $a cmp $b } keys %{$$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1}}) {
						if ($elem2 eq $val) {
							delete $$wordnet_args{"add_wordnet_synonym"}{$pos}{$elem1}{$elem2};
						}
					}
				}

				push @$command_entered_array,  $pre_search_string;
				print "Word Synonyms association(s) removed as ", uc($pos), " for: $val\n";
			}
		}
	}

	if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
		$scan_language = "";
	} elsif ($main_language eq "es-us") {
		$scan_language = "esus";
	}

	return ($main_language, $scan_language, $grammar_type, $$wordnet_args{"max_wordnet_count"}, $$wordnet_args{"min_wordnet_frequency_noun"}, $$wordnet_args{"min_wordnet_frequency_verb"}, $$wordnet_args{"min_wordnet_frequency_adjective"}, $$wordnet_args{"max_wordnet_sentence_length"}, $$wordnet_args{"synonym_option"}, $$wordnet_args{"do_synonyms"}, $pre_search_string);
}

sub writeTask
{
  if (opendir("INFODIR", "slmdirect_results")) {
	open(TASKS,">"."slmdirect_results\/createslmDIR_temp_files\/temp_tasks") or die "cant write "."slmdirect_results\/createslmDIR_temp_files\/temp_tasks";
	print TASKS "$task_no\t$sub_task_no\t$err_msg_no\t$warning_msg_no\t$num_errors\t$num_warnings\n";
	close(TASKS);
	closedir("INFODIR");
  }
}

sub writeErrors
{
    my($err_msg_in) = @_;
    if (opendir("INFODIR", "slmdirect_results")) {
	open(ERRORS,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_errors") or die "cant write "."slmdirect_results\/createslmDIR_temp_files\/temp_errors";
	print ERRORS "$err_msg_in\n";
	close(ERRORS);
	closedir("INFODIR");
    }
}

sub writeWarnings
{
    my($warning_msg_in) = @_;
    if (opendir("INFODIR", "slmdirect_results")) {
	open(WARNINGS,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_warnings") or die "cant write "."slmdirect_results\/createslmDIR_temp_files\/temp_warnings";
	print WARNINGS "$warning_msg_in\n";
	close(WARNINGS);
	closedir("INFODIR");
    }
}

sub setTask
{
  my($task_no_in, $sub_task_no_in, $err_msg_no_in, $warning_msg_no_in, $num_errors_in, $num_warnings_in, $called_from_gui_in) = @_;

  $task_no = $task_no_in;
  $sub_task_no = $sub_task_no_in;
  $err_msg_no = $err_msg_no_in;
  $warning_msg_no = $warning_msg_no_in;
  $num_errors = $num_errors_in;
  $num_warnings = $num_warnings_in;
  $called_from_gui = $called_from_gui_in;
}

sub resetErrorsWarnings
{
  $err_msg_no = 0;
  $warning_msg_no = 0;
}

sub CALL_SLMDirect
{
    my($do_split_train_test, $create_regexp, $callingProg, $main_language, $target_language, $grammarbase, $grammar_type, $container_file_in, $my_nl_control, $testparsefileout, $downcase_utt, $remove_repeats, $sentencelist, $mode, $repository, $called_from_gui, $reftags, $use_trad_trans, $classify_out_file, $autotag_option) = @_;

	my($cmd);
	my($mycallingProg);
	my($nlslmscript);
	my($result_val) = 0;
	my($tasks_found) = 1;
	my(@tasks_array);

	my(@mycallingProg_array);

	$mycallingProg = $callingProg;
	$mycallingProg =~ s/\\/\//g;
	@mycallingProg_array = split "/", $mycallingProg;

	$mycallingProg = $mycallingProg_array[-1];

	if ($webSwitch) {
	  $mycallingProg = "/usr/bin/perl -I $focusInputDir $focusInputDir".$mycallingProg;
	}

	$nlslmscript = "$mycallingProg -SetTask \"$task_no:$sub_task_no:$err_msg_no:$warning_msg_no:$num_errors:$num_warnings\" -DontCheckRules -DontDoAdditionalCommandVars ";

	if ($main_language ne "") {
	  $nlslmscript = $nlslmscript." -Language $main_language";
	}

	if ($target_language ne "") {
		$nlslmscript = $nlslmscript." -TargetLanguage $target_language";
	}

	if ($create_regexp) {
	  $nlslmscript = $nlslmscript." -CreateRegExp";
	}

	if ($do_split_train_test ne "") {
	  $nlslmscript = $nlslmscript." -SplitTrainTest $do_split_train_test";
	}

	if ($use_trad_trans) {
		$nlslmscript = $nlslmscript." -UseTraditionalTranscriptions";
	}

	if (($grammarbase ne "") && ($mode ne "WRITEDATAFILES")) {
		$nlslmscript = $nlslmscript." -GrammarBasename $grammarbase";
	}

	if ($grammar_type ne "") {
		$nlslmscript = $nlslmscript." -GrammarType $grammar_type";
	}

	if ($reftags ne "") {
		$nlslmscript = $nlslmscript." -ReferenceTags $reftags";
	}

	if (($container_file_in ne "") && ($mode ne "WRITEDATAFILES")) {
		if (-e $container_file_in) {
			$nlslmscript = $nlslmscript." -CreateRulesFrom $container_file_in";
		} else {
			die "cant find $container_file_in";
		}
	}

	if ($my_nl_control ne "") {
		if (-e $my_nl_control) {
			$nlslmscript = $nlslmscript." -Rules $my_nl_control";
		} else {
			die "cant find $my_nl_control";
		}
	}

	if ($testparsefileout ne "") {
		$nlslmscript = $nlslmscript." -TestParseFileOut $testparsefileout";
	}

	if ($downcase_utt) {
		$nlslmscript = $nlslmscript." -DowncaseUtt";
	}

	if (!$remove_repeats) {
		$nlslmscript = $nlslmscript." -DontRemoveRepeats";
	}

	if ($mode eq "TAG_UNTAGGED") {
		$nlslmscript = $nlslmscript." -SuppressGrammar -WithRetag -ApplyTags createslm_applytag_class_out";
	} elsif ($mode eq "USE_BASECATS") {
		$nlslmscript = $nlslmscript." -NO_TAG_UNKNOWN -ReferenceTags createslmDIR_temp_files/temp_basecats_reftags -ApplyTags temp_basecats_sentences";
	} else {
	  if ($classify_out_file ne "") {
		$nlslmscript = $nlslmscript." -ApplyTags $classify_out_file";
	  }
	}

	if ($repository ne ".") {
		$nlslmscript = $nlslmscript." -Repository $repository";
	}

	if ($autotag_option ne "") {
		$nlslmscript = $nlslmscript." -UseOrigTranscriptions";
	}

	if ($called_from_gui) {
	  $nlslmscript = $nlslmscript." -CalledFromGUI";
	}

	if ($mode =~ /WRITEDATAFILES/) {
	  if ($mode =~ /WITHRETAG/) {
		$nlslmscript = $nlslmscript." -WriteDataFiles -WithRetag";
	  } else {
		$nlslmscript = $nlslmscript." -WriteDataFiles";
	  }
	}

	if ($mode eq "GET_PARTIAL_TAGS") {
#	  $nlslmscript =~ s/\-DontDoAdditionalCommandVars //g;
	  $nlslmscript = $nlslmscript." -SuppressGrammar -PutDefaults -TagsDirect";
	}

	if ($mode eq "GET_PARTIAL_TAGS_MINUS") {
	  $nlslmscript = $nlslmscript." -SuppressGrammar -TagsDirect";
	}

	if ($mode eq "USE_BASECATS_PRELIM") {
	  $nlslmscript = $nlslmscript." -SuppressGrammar -GenReferenceTags createslmDIR_temp_files/temp_basecats_reftags -TagsDirect";
	}

	if ($sentencelist ne "") {
		if (-e $sentencelist) {
			$nlslmscript = $nlslmscript." $sentencelist";
		} else {
			die "cant find $sentencelist";
		}
	}

	$cmd = "$nlslmscript\n";

	$result_val = 0xfff & system ($cmd);

	if (($result_val & 0xff) == 0) {
		$result_val >>= 8;
	}
    
    unless (open(TASKS,"<"."slmdirect_results\/createslmDIR_temp_files\/temp_tasks")) {
	$tasks_found = 0;
    }

    if ($tasks_found) {
	(@tasks_array) = (<TASKS>);
	close(TASKS);
	
	($task_no, $sub_task_no, $err_msg_no, $warning_msg_no, $num_errors, $num_warnings) = split "\t", $tasks_array[0];
	unlink "slmdirect_results\/createslmDIR_temp_files\/temp_tasks";
    }
}

sub	ApplyClassGrammars {
    my($general_args, $cleaning_args, $test_category, $current_item) = @_;

	my($absolute_path) = "./".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_";
	my($elem);
	my($elem1);
	my($elem2);
	my($modified_item);
	my($temp_elem);
	my($temp_elem1);
	my($temp_elem2);
	my(@cat_array);
	my($cat_found);

	if ($test_category ne "") {
		if (scalar (keys %{$$cleaning_args{"class_grammar"}}) > 0) {
			$test_category = lc($test_category);
			foreach $elem ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}}) {
				if (index ($elem, "=") != -1) {
					(@cat_array) = split "=", $elem;
					$temp_elem = $cat_array[0];
					shift @cat_array;

					if ($test_category eq "apply_class_grammars_to_all_categories") {
						$cat_found = 1;
					} else {
						$cat_found = 0;
						foreach $elem2 (@cat_array) {
							$temp_elem2 = lc($elem2);

							if ($temp_elem2 eq $test_category) {
								$cat_found = 1;

								last;
							}
						}
					}

					if ($cat_found) {
						foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}{$elem}}) {
							if (($$general_args{"grammar_type"} eq "NUANCE_GSL") || ($$general_args{"grammar_type"} eq "")) {
								$current_item =~ s/\b($elem1)\b/$temp_elem /g;
							} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
							  $modified_item = setClassGrammarSentenceItem($temp_elem, $absolute_path);
							  if ($temp_elem =~ /\ª/) {
#								  $temp_elem =~ s/\ª//g;
#								  $temp_elem1 = "<item repeat=\"0\-1\"> <ruleref uri=\"\.\/".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_".$temp_elem."\.grxml\"\/><\/item>";
#								$temp_elem1 = "<item repeat=\"0\-1\"> ".$modified_item."<\/item>";
# ATTENTION
								$temp_elem1 = $modified_item;
							  } else {
#								$temp_elem1 = "<ruleref uri=\"\.\/".$$general_args{"grammarbase"}."_".lc($$general_args{"grammar_type"})."_".$temp_elem."\.grxml\"\/>";
								$temp_elem1 = $modified_item;
							  }

							  $current_item =~ s/\b($elem1)\b/$temp_elem1 /g;
							}
						}
					}
				} else {
					if (($$general_args{"grammar_type"} eq "NUANCE_GSL") || ($$general_args{"grammar_type"} eq "")) {
						foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}{$elem}}) {
							$current_item =~ s/\b($elem1)\b/$elem /g;
						}
					} elsif (($$general_args{"grammar_type"} eq "NUANCE_SPEAKFREELY") || ($$general_args{"grammar_type"} eq "NUANCE9")) {
					  $modified_item = setClassGrammarSentenceItem($elem, $absolute_path);
# ATTENTION
					  if ($elem =~ /\ª/) {
#						$temp_elem1 = "<item repeat=\"0\-1\"> ".$modified_item."<\/item>";
						$temp_elem1 = $modified_item;
					  } else {
						$temp_elem1 = $modified_item;
					  }

					  foreach $elem1 ( sort { $a cmp $b } keys %{$$cleaning_args{"class_grammar"}{$elem}}) {
						$current_item =~ s/\b($elem1)\b/$temp_elem1 /g;
					  }
					}
				}
			}
		}
	}

	$current_item = TrimChars($current_item);

	return ($current_item);
}

sub CheckForTranscriptions
{
  my($general_args, $wordnet_args, $cleaning_args, $meaning_args, $osr_args, $findReference_args, $do_tagsdirect, $do_split_train_test, $do_read_catlist, $do_classify, $parsefile, $clean_only, $debug, $do_filtercorpus_direct, $do_flatfile_transcriptions, $do_tagging, $do_testsentence, $do_transcat, $dont_clean, $err_no, $filter_corpus, $filtercorpus_direct_in, $myfiltercorpusfileout, $gen_referencetagfile, $grammar_pointer, $keep_fragment_length, $knowncatsfile, $max_filter_sentence_length, $merge_nouns, $merge_verbs, $nl_blank_utts, $nl_total_records, $test_confirm_as, $test_confirm_as_nuance_speakfreely, $multiplier, $test_slotname, $test_slotname_nuance_speakfreely, $app_hash, $ending_adjective_hash, $ending_noun_hash, $ending_verb_hash, $gram_elem_cat_hash, $keyword_2_filtered_utt_hash, $merge_noun_prefix_hash, $merge_noun_verb_alias_hash, $merge_verb_prefix_hash, $pre_hash, $reclass_hash, $sentence_cat_assignments_hash, $sentence_cat_hash, $trans_hash, $truth_knowncats_hash, $wordbag_keyword_2_filtered_utt_hash, $compressed_alias_sentence_array, $compressed_sentence_array, $original_cat_array, $original_transcription_array, $original_wavfile_array, $compressed_already_hash, $wordlist_already_hash, $gen_grammar_elem_hash, $allow_general_hash, $changed_utt_repeat_hash, $disallow_general_hash, $do_addmainrules_only, $do_include_garbagereject, $gsl_filler_hash, $rule_multiplier, $utt_source, $vocabfile, $corrected_array) = @_;

  my($afound);
  my($auto_class_grammar_build_string);
  my($autotag_sentence);
  my($blank_test_counter) = 0;
  my($blank_test_percent) = 3;
  my($category_pre_search_string) = "";
  my($category_pre_search_string_count);
  my($clean_file);
  my($cmd)= "paste createslm_clean_filename createslm_clean_sentences";
  my($combo_sentences) = "";
  my($contains_categories) = 0;
  my($currcat);
  my($currcorrected);
  my($current_percent);
  my($current_percent);
  my($currtrans);
  my($currwavfile);
  my($elem);
  my($elem1);
  my($elem2);
  my($elem3);
  my($filename_pre_search_string) = "";
  my($filename_pre_search_string_len) = 0;
  my($filter_file_written);
  my($found);
  my($freq) = 0;
  my($grammar_pointer_default) = "G2";
  my($i) = 0;
  my($input_is_transcription) = 0;
  my($int_part);
  my($item_category);
  my($keyword_weight) = 4000000;
  my($max_blank_test_counter) = 0;
  my($max_tag_sentence_length) = 2000;
  my($pos_corrected_sentence);
  my($pre_search_string) = "";
  my($pre_search_string_count);
  my($pre_search_string_count_2);
  my($pre_search_string_len);
  my($put_in_full_pre_phrases) = 1;
  my($real_part);
  my($response_exclusion_tag_string);
  my($retval_name);
  my($search_token);
  my($sentence_length);
  my($sentence_order) = 0;
  my($sitem);
  my($split_counter) = 0;
  my($split_gate) = 1;
  my($split_line);
  my($split_test_sequence);
  my($split_total);
  my($split_training_percent) = 90;
  my($synonym_corrected_sentence);
  my($synonym_sentence_order) = -1;
  my($synonym_sentence_order_start) = 0;
  my($temp_add_string);
  my($temp_blank_test_percent);
  my($temp_corrected_sentence);
  my($temp_item_category);
  my($temp_pre_search_string);
  my($temp_removerepeats);
  my($temp_replace1);
  my($temp_replace2);
  my($temp_search_string);
  my($temp_sentence_order);
  my($temp_test_percent);
  my($temp_token_string);
  my($test_category);
  my($test_counter);
  my($use_original_wavfiles) = 0;
  my($use_previous_split_sequence);
  my($write_filter_grammars) = 0;
  my(%auto_mod_hash);
  my(%default_pos_hash);
  my(%filename_2_line_hash);
  my(%grammar_elems);
  my(%grammar_elems_esus);
  my(%grammar_elems_other);
  my(%grammar_elems_other_esus);
  my(%line_hash);
  my(%orig_2_line_hash);
  my(%pos_only_hash);
  my(%replacement_frequency_hash);
  my(%seen_hash);
  my(%synfile_hash);
  my(%wordnet_hash);
  my(%wordnet_pointer_hash);
  my(@auto_class_grammar_array);
  my(@mod_array);
  my(@pos_corrected_array);
  my(@split_sort_array);
  my(@synonym_corrected_array);
  my(@temp_add_array);
  my(@temp_auto_array);
  my(@temp_corrected_array);
  my(@temp_split_sort_array);
  my(@unique_original_wavfile_array);
  my(@wordbag_compressed_alias_sentence_array);
  my(@wordbag_compressed_sentence_array);

  if ($grammar_pointer eq "") {
	$grammar_pointer = $grammar_pointer_default;
  }

  ($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription, $use_original_wavfiles) = ReadDataStrings($general_args, $wordnet_args, $use_original_wavfiles, $input_is_transcription, $do_classify);

  @$original_transcription_array = split /\º/, $pre_search_string;

  $pre_search_string =~ s/\<partial\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/partial\>/ /g;
  $pre_search_string =~ s/\<sidespeech\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/sidespeech\>/ /g;

  if ($$cleaning_args{"auto_class_grammar_search"} ne "") {
	$auto_class_grammar_build_string = "CG";
	(@auto_class_grammar_array) = split ",", $$cleaning_args{"auto_class_grammar_search"};
	foreach $elem (@auto_class_grammar_array) {
	  ($search_token, $retval_name) = split ":", $elem;
	  @mod_array =();
	  if ($search_token =~ /\=/) {
		($search_token, @mod_array) = split /\=/, $search_token;
	  }

	  $temp_token_string = "_".lc($retval_name)."_".lc($search_token)."_";

	  $temp_pre_search_string = $pre_search_string;
	  $pre_search_string =~ s/\<($search_token)\/\>/$temp_token_string/g;
	  if ($pre_search_string ne $temp_pre_search_string) {
		$auto_class_grammar_build_string = $auto_class_grammar_build_string.",".$retval_name.":".$temp_token_string;
	  }

	  $temp_pre_search_string = "";

	  undef %auto_mod_hash;
	  if (scalar(@mod_array) == 0) {
		$mod_array[0] = "_NONE_";
	  }

	  while ($pre_search_string =~ /\<$search_token\>((\w|\d| |\/|\@|\\|\.|\:|\#|\*|\~|\||\!|\"|\$|\%|\^|\&|\,|\?|\'|\-|\_|\+|\(|\)|\[|\]|\{|\}|í|á|ñ|ú|é|ó|ú)+)\<\/$search_token\>/g) {
		$temp_search_string = $1;
		if (($temp_search_string ne "") && ($temp_search_string ne " ")) {
		  $afound = "";
		  foreach $elem1 (sort { length($b) <=> length($a) } @mod_array) {
			if ($temp_search_string =~ /\b($elem1)\b/) {
			  $afound = $elem1;
			  last;
			}
		  }

		  if ($afound ne "") {
			$auto_mod_hash{$afound}{$temp_search_string}++;
		  } else {
			$auto_mod_hash{"_NONE_"}{$temp_search_string}++;
		  }
		}
	  }

	  $temp_add_string = "";
	  foreach $elem2 ( sort { length($b) <=> length($a) } keys %auto_mod_hash) {
		$temp_add_string = $retval_name;
		if ($elem2 ne "_NONE_") {
		  @temp_add_array = split " ", $elem2;
		  foreach $elem3 (@temp_add_array) {
			$temp_add_string = $temp_add_string.ucfirst($elem3);
		  }
		}

		foreach $temp_search_string ( sort { length($b) <=> length($a) } keys %{$auto_mod_hash{$elem2}}) {
		  $temp_search_string = TrimChars($temp_search_string);
		  $temp_add_string = $temp_add_string.":".$temp_search_string;
		}

		$auto_class_grammar_build_string = $auto_class_grammar_build_string.",$temp_add_string";
	  }
	}
  }

  $pre_search_string =~ s/\<\//\[/g;
  $pre_search_string =~ s/\</\[/g;
  $pre_search_string =~ s/\/\>/\]/g;
  $pre_search_string =~ s/\>/\]/g;

  if ($auto_class_grammar_build_string ne "") {
	makeClassGrammars($$general_args{"main_language"}, $$general_args{"grammar_type"}, $$general_args{"grammarbase"}, $auto_class_grammar_build_string, $$cleaning_args{"class_grammar"}, 0);
  }

   if ($input_is_transcription) {
	   if ($$wordnet_args{"do_autotag"}) {
		   $contains_categories = 0;
	   }

	   $pre_search_string_len = length($pre_search_string);
	   if (($$general_args{"create_regexp"}) || ($do_split_train_test ne "") || ($use_original_wavfiles) ) {
		 $filename_pre_search_string_len = length($filename_pre_search_string);
	   } else {
		 $filename_pre_search_string_len = 0;
	   }

	   if ($dont_clean) {
		   DebugPrint ("BOTH", 2, "CheckForTranscriptions", $debug, $err_no++, "Skipping Cleaning Sentences");
	   } else {
		   $test_category = "";
		   if (!$contains_categories) {
			   $test_category = "APPLY_CLASS_GRAMMARS_TO_ALL_CATEGORIES";
		   }

		   if ($$cleaning_args{"ramble_exclusion"} ne "") {
			 if ( $pre_search_string =~ /\[($$cleaning_args{"ramble_exclusion"})\]/ )           {
			   DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Doing Ramble Exclusions ... done");
			   $pre_search_string = ApplyRambleExclusion($pre_search_string, $$cleaning_args{"ramble_exclusion"});
			 }
		   }

		   FillGoodFragmentHash($pre_search_string, $$cleaning_args{"good_fragment_list"}, $keep_fragment_length);
		   DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Applying Spelling and Other Corrections ... done");

		   $temp_removerepeats = $$cleaning_args{"removerepeats"};
		   $$cleaning_args{"removerepeats"} = 0;
		   $pre_search_string = MakeCleanTrans($general_args, $cleaning_args, 0, 0, 1, 0, $test_category, $pre_search_string);
		   $$cleaning_args{"removerepeats"} = $temp_removerepeats;

		   $pre_search_string = MoreClean($pre_search_string);

#		   $pre_search_string =~ s/\./ /g;
#		   $pre_search_string =~ s/\,/ /g;
#		   $pre_search_string =~ s/\?//g;
#		   $pre_search_string =~ s/\'\'/\'/g;
#		   $pre_search_string =~ s/ \//\//g;
#		   $pre_search_string =~ s/\/ /\//g;
#		   $pre_search_string =~ s/(\º )|( \º)/\º/g;

		   undef $$cleaning_args{"clean_trans"};

# ATTENTION
#		   if ($$general_args{"main_language"} eq "es-us") {
##			   $pre_search_string =~ s/á/a/g;
#			   $pre_search_string =~ s/é/e/g;
#			   $pre_search_string =~ s/í/i/g;
##			   $pre_search_string =~ s/ó/o/g;
#			   $pre_search_string =~ s/ú/u/g;
#			   $pre_search_string =~ s/ñ/n/g;
#		   }
	   }

	   if ($clean_only) {
		   DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Cleaning Sentences");
		   $pre_search_string = DoFirstCorrections($cleaning_args, $meaning_args, $pre_search_string, $pre_search_string_len, $filename_pre_search_string_len, $parsefile);

		   ($pre_search_string, $filename_pre_search_string, $category_pre_search_string) = CleanAddMergedElements($use_original_wavfiles, $pre_search_string, $filename_pre_search_string, $category_pre_search_string, $$general_args{"main_language"}, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $$general_args{"product_prefix_num"}, $contains_categories);

		   open(CLEAN,">"."slmdirect_results\/createslm_clean_sentences") or die "cant open "."slmdirect_results\/createslm_clean_sentences";
		   print CLEAN "$pre_search_string";
		   close(CLEAN);

		   if ($use_original_wavfiles) {
			 open(CLEAN,">"."slmdirect_results\/createslm_clean_filename") or die "cant open "."slmdirect_results\/createslm_clean_filename";
			 print CLEAN "$filename_pre_search_string";
			 close(CLEAN);
		   }

		   if ($contains_categories) {
			   $cmd = $cmd." createslm_clean_categories";
			   $category_pre_search_string =~ s/\º/\n/g;

			   open(CLEAN,">"."slmdirect_results\/createslm_clean_categories") or die "cant open "."slmdirect_results\/createslm_clean_categories";
			   print CLEAN "$category_pre_search_string";
			   close(CLEAN);
		   }

		   if ($do_flatfile_transcriptions) {
			 $clean_file = "$parsefile"."_"."clean";
		   } else {
			 $clean_file = "createslm_clean_corpus";
		   }

		   unlink "$clean_file";
		   $cmd = $cmd."> $clean_file";

		   system ($cmd);

		   DebugPrint ("BOTH", 1, "CheckForTranscriptions", $debug, $err_no++, "Clean file created: $clean_file");

		   exit(0);
	   } else {
		 unlink "$clean_file";
		 unlink "createslm_clean_*";
	   }

	   if ($do_tagging ne "") {
		   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Tagging Sentences");
		   $pre_search_string = CALL_Nuance_Tagging($do_tagging, $pre_search_string, $max_tag_sentence_length);
	   }

	   if (($$general_args{"create_regexp"}) || ($do_split_train_test ne "") || $use_original_wavfiles) {
		 if (($filename_pre_search_string ne "") && index($filename_pre_search_string, "º") != -1) {
		   @$original_wavfile_array = split /\º/, $filename_pre_search_string;
		   @unique_original_wavfile_array = grep {! $seen_hash{$_} ++ } @$original_wavfile_array;
		   undef %seen_hash;

		   if (scalar(@$original_wavfile_array) != scalar(@unique_original_wavfile_array)) {
			 DebugPrint ("BOTH", 2, "CheckForTranscriptions", $debug, $err_no++, "Filenames or labels are NOT unique in input file: $parsefile");
		   } else {
			 DebugPrint ("BOTH", 1, "CheckForTranscriptions", $debug, $err_no++, "Filenames or labels ARE unique in input file: $parsefile");
			 $$general_args{"filenames_are_unique"} = 1;
		   }
		 }
	   }

	   @unique_original_wavfile_array = ();

## ATTENTION	   @$original_transcription_array = split /\º/, $pre_search_string;

	   $category_pre_search_string_count = $pre_search_string_count;
	   if ($contains_categories) {
		 @$original_cat_array = split /\º/, $category_pre_search_string;
		 $category_pre_search_string_count = scalar(@$original_cat_array);
		 $pre_search_string_count_2 = scalar(@$original_transcription_array);

		 if ($gen_referencetagfile ne "") {
		   WriteGenRefFile($general_args, $category_pre_search_string, $gen_referencetagfile);
		 }
	   }

	   if ($pre_search_string_count_2 != $category_pre_search_string_count) {
	       DebugPrint ("BOTH", 3, "CheckForTranscriptions", $debug, $err_no++, "*** Inconsistent Counts caused by template file ***:\tTranscription Count=$pre_search_string_count_2\t\tTag Count=$category_pre_search_string_count");
	   }

	   $sentence_order = scalar(@$original_transcription_array);

	   undef $filename_pre_search_string;
	   undef $category_pre_search_string;

	   $synonym_sentence_order_start = scalar(split /\º/, $pre_search_string);
	   if ($$wordnet_args{"wordnet_available"}) {
		   if ($$wordnet_args{"do_autotag"} || $$wordnet_args{"do_synonyms"}) {
			 DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Performing WordNet Correlations");

			 FillWordNetHash($general_args, $meaning_args, $wordnet_args, $keyword_weight, $pre_search_string, \%wordnet_pointer_hash, \%wordnet_hash, \%pos_only_hash, \%default_pos_hash, \%seen_hash, 1);
			 $pos_corrected_sentence = FindPreWordsInSentence($pre_search_string, $meaning_args, $wordnet_args);
			 @pos_corrected_array = split /\º/, $pos_corrected_sentence;

			 undef $pos_corrected_sentence;
		   }

		   if ($$wordnet_args{"do_synonyms"}) {
			   $sentence_order = 0;
			   $temp_sentence_order = 0;
			   $synonym_sentence_order = $synonym_sentence_order_start;
			   $item_category = "";

			   @$corrected_array = split /\º/, $pre_search_string;
			   foreach $synonym_corrected_sentence (@$corrected_array) {
				   $temp_corrected_sentence = $synonym_corrected_sentence;
				   $temp_corrected_sentence =~ s/ //g;
				   $sentence_length = length($synonym_corrected_sentence) - length($temp_corrected_sentence) + 1;
				   if ($sentence_length <= $$wordnet_args{"max_wordnet_sentence_length"}) {
					   if ($contains_categories) {
						   $item_category = @$original_cat_array[$sentence_order];
					   }

					   $seen_hash{$synonym_corrected_sentence}++;
					   ($synonym_sentence_order, $temp_sentence_order) = autoSynonym($wordnet_args, $use_original_wavfiles, $do_testsentence, $contains_categories, $item_category, $sentence_order, $synonym_sentence_order, $temp_sentence_order, $synonym_corrected_sentence, \%seen_hash, \%wordnet_pointer_hash, \%wordnet_hash, \%pos_only_hash, \%default_pos_hash, \@pos_corrected_array, $original_wavfile_array, $original_transcription_array, $corrected_array, \@synonym_corrected_array, $original_cat_array, \%synfile_hash, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash);

					   $sentence_order++;
				   }
			   }

			   if (scalar keys %synfile_hash > 0) {
				   open(SYNONYMSOUT,">"."slmdirect_results\/createslmDIR_wordnet_files\/info_synonym_sentences".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_wordnet_files\/info_synonym_sentences".$$general_args{"language_suffix"};
				   foreach $elem ( sort { $a cmp $b } keys %synfile_hash) {
					   print SYNONYMSOUT "synonym\t$elem\n";
				   }

				   DebugPrint ("BOTH", 1, "CheckForTranscriptions", $debug, $err_no++, "Synonym File created: "."slmdirect_results\/createslmDIR_wordnet_files\/info_synonym_sentences".$$general_args{"language_suffix"});
				   close(SYNONYMSOUT);
			   }

			   foreach $synonym_corrected_sentence (@synonym_corrected_array) {
				   $pre_search_string = $pre_search_string."º".$synonym_corrected_sentence;
			   }
		   }

		   undef %seen_hash;

		   if ($$wordnet_args{"do_autotag"} || $$wordnet_args{"do_synonyms"}) {
			   DebugPrint ("BOTH", 1, "CheckForTranscriptions", $debug, $err_no++, "WordNet Correlations Completed");
		   }
	   }

	   if ($filter_corpus || $do_filtercorpus_direct) {
		   @temp_corrected_array = split /\º/, $pre_search_string;

		   $write_filter_grammars = 1;

		   if (($$general_args{"main_language"} eq "en-us") || ($$general_args{"main_language"} eq "en-gb")) {
			 ($filter_file_written, $combo_sentences) = MakeFilterCorpus($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $combo_sentences, $filter_file_written, $write_filter_grammars, "", "", $debug, $app_hash, $freq, $do_filtercorpus_direct, $put_in_full_pre_phrases, $gram_elem_cat_hash, $multiplier, $myfiltercorpusfileout, \%grammar_elems, \%grammar_elems_other, $original_cat_array, $original_transcription_array, $original_wavfile_array, \@temp_corrected_array, $contains_categories, $max_filter_sentence_length, $compressed_already_hash);
		   }

		   if ($$general_args{"main_language"} eq "es-us") {
			   $filter_file_written = 0;
			   ($filter_file_written, $combo_sentences) = MakeFilterCorpus($general_args, $cleaning_args, $meaning_args, $wordnet_args, $findReference_args, $combo_sentences, $filter_file_written, $write_filter_grammars, "", "", $debug, $app_hash, $freq, $do_filtercorpus_direct, $put_in_full_pre_phrases, $gram_elem_cat_hash, $multiplier, $myfiltercorpusfileout, \%grammar_elems_esus, \%grammar_elems_other_esus, $original_cat_array, $original_transcription_array, $original_wavfile_array, \@temp_corrected_array, $contains_categories, $max_filter_sentence_length, $compressed_already_hash);
		   }

		   @temp_corrected_array = ();

		   if ($combo_sentences ne "") {
			   $combo_sentences = substr($combo_sentences, 0, length($combo_sentences)-1);
			   $pre_search_string = $pre_search_string."º".$combo_sentences;
		   }
	   }

	   if ($$wordnet_args{"do_autotag"}) {
		   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Collecting Autotag Sentences");
	   } else {
		   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Processing $pre_search_string_count Sentence(s)");
	   }

	   if (!$dont_clean) {
		 $pre_search_string = DoFirstCorrections($cleaning_args, $meaning_args, $pre_search_string, $pre_search_string_len, $filename_pre_search_string_len, $parsefile);
	   }

	   if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		   $pre_search_string = ApplyClassGrammars ($general_args, $cleaning_args, "APPLY_CLASS_GRAMMARS_TO_ALL_CATEGORIES", $pre_search_string);
	   }

	   if ((($merge_nouns ne "") && (-e $merge_nouns)) || (($merge_verbs ne "") && (-e $merge_verbs))) {
		 ($pre_search_string) = ManageAddMergedElements($use_original_wavfiles, $pre_search_string, $original_wavfile_array, $original_transcription_array, $original_cat_array, $$general_args{"main_language"}, $merge_nouns, $merge_verbs, $merge_noun_verb_alias_hash, $merge_noun_prefix_hash, $merge_verb_prefix_hash, $$general_args{"product_prefix_num"}, $contains_categories);
	   }

	   DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Compressing Sentences ... done");

	   Special_ApplyChooseCompressedSentence($general_args, $meaning_args, $wordnet_args, $pre_search_string, $compressed_sentence_array, \@wordbag_compressed_sentence_array, $compressed_alias_sentence_array, \@wordbag_compressed_alias_sentence_array, $compressed_already_hash, $wordlist_already_hash);

	   if (substr($pre_search_string, length($pre_search_string)-1) eq "º") {
		 chop($pre_search_string);
	   }

	   $pre_search_string = ApplyBlanks($pre_search_string);

	   @$corrected_array = split /\º/, $pre_search_string;

#	   @$pseudo_corrected_array = split /\º/, $pre_search_string;
#	   @$compressed_sentence_array = split /\º/, $compressed_sentence;
#	   @$compressed_alias_sentence_array = split /\º/, $compressed_alias_sentence;
#	   @$wordbag_compressed_sentence_array = split /\º/, $wordbag_compressed_sentence;
#	   @$wordbag_compressed_alias_sentence_array = split /\º/, $wordbag_compressed_alias_sentence;
#	   @$squeezed_sentence_array = split /\º/, $squeezed_sentence;

	   if ($contains_categories) {
		   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Creating ".$$general_args{"main_language"}." Known Categories File: ".NormalizeFilename($knowncatsfile));

		   WriteOutNewKnownCats($general_args, $knowncatsfile, $do_filtercorpus_direct, $original_transcription_array, $original_cat_array, $reclass_hash, $keyword_2_filtered_utt_hash, $wordbag_keyword_2_filtered_utt_hash, $sentence_cat_hash, $corrected_array, $compressed_sentence_array, $compressed_alias_sentence_array, \@wordbag_compressed_sentence_array, \@wordbag_compressed_alias_sentence_array, $truth_knowncats_hash, $parsefile);

		   undef %{$$general_args{"just_keywords"}};
	   }

	   if ($do_split_train_test ne "") {
		 my($mode) = "train";

		 DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Splitting $parsefile ...");

		 $response_exclusion_tag_string = "";
		 if ($$cleaning_args{"response_exclusion_tags"} ne "") {

		   DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Actively removing TAG Response Exclusion lines from TEST file ...");
		   $response_exclusion_tag_string = $$cleaning_args{"response_exclusion_tags"};
		   $response_exclusion_tag_string =~ s/\|/ /g;
		   $response_exclusion_tag_string = " ".$response_exclusion_tag_string." ";
		 }

		 ($split_test_sequence, $temp_test_percent, $temp_blank_test_percent, $use_previous_split_sequence) = split ":", $do_split_train_test;

		 open(SPLITFILEOUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), $parsefile."_TRAINING") or die "cant write ".$parsefile."_TRAINING";

		 if (!$use_previous_split_sequence || ($use_previous_split_sequence && (not (-e "slmdirect_results\/createslmDIR_info_files\/info_split_sequence")))) {
		   open(SAVESPLITSEQUENCE,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), "slmdirect_results\/createslmDIR_info_files\/info_split_sequence") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_split_sequence";

		   if ($temp_test_percent ne "") {
			 $split_training_percent = 100 - $temp_test_percent;
		   }

		   if ($temp_blank_test_percent ne "") {
			 $blank_test_percent = $temp_blank_test_percent;
		   }

		   for ($i = 0; $i < $sentence_order; $i++) {
			 $temp_split_sort_array[$i] = $i;
		   }

		   if ($split_test_sequence eq "random") {
			 @split_sort_array = @temp_split_sort_array;
			 fisher_yates_shuffle(\@split_sort_array);
		   } elsif ($split_test_sequence eq "fileorder") {
			 @split_sort_array = sort { $a <=> $b } @temp_split_sort_array;
		   } elsif ($split_test_sequence eq "reversefileorder") {
			 @split_sort_array = sort { $b <=> $a } @temp_split_sort_array;
		   }

		   $split_total = $sentence_order;
		 } else {
		   open(SAVESPLITSEQUENCE,"<"."slmdirect_results\/createslmDIR_info_files\/info_split_sequence") or die "cant open "."slmdirect_results\/createslmDIR_info_files\/info_split_sequence";

		   while (<SAVESPLITSEQUENCE>) {
			 $split_line = ChopChar($_);
			 push (@split_sort_array, $split_line);
		   }

		   $split_total = scalar (@split_sort_array);
		 }

		 foreach $sitem (@split_sort_array) {
		   $currcat = @$original_cat_array[$sitem];
		   $currtrans = @$original_transcription_array[$sitem];
		   $currwavfile = @$original_wavfile_array[$sitem];
		   $currcorrected = @$corrected_array[$sitem];

		   if (!$use_previous_split_sequence) {
			 print SAVESPLITSEQUENCE "$sitem\n";
		   }

		   if ($split_gate) {
			 $current_percent = (($split_counter/$split_total) * 100);
			 $int_part = int($current_percent);
			 $real_part = $current_percent - $int_part;

			 if ($real_part > 0) {
			   if ($real_part >= 0.5) {
				 $current_percent = $int_part + 1;
			   } else {
				 $current_percent = $int_part;
			   }
			 }

			 if ($current_percent > $split_training_percent) {
#		   print "hereqqq0: mode=$mode, currwavfile=$currwavfile, currtrans=$currtrans, currcorrected=$currcorrected, item_category=$currcat\n";
			   close (SPLITFILEOUT);
			   open(SPLITFILEOUT,">".getOutEncoding($$general_args{"main_language"}, $$general_args{"grammar_type"}), $parsefile."_TEST") or die "cant write ".$parsefile."_TEST";
			   $mode = "test";

			   $test_counter = $split_total - $split_counter;
			   $max_blank_test_counter = $test_counter * $blank_test_percent/100;

			   if ($max_blank_test_counter < 1) {
				 $max_blank_test_counter = 0;
			   }

			   $split_gate = 0;
			 }
		   }

		   if ($mode eq "train") {
			 if (($currcorrected eq "") || ($currcorrected eq " ") || (lc($currcorrected) =~ /\*blank\*/) || (lc($currcorrected) =~ /__blank__/)) {
			   next;
					}
		   } elsif ($mode eq "test") {
#					$blank_test_counter++;
			 if ((($currcorrected eq "") || ($currcorrected eq " ") || (lc($currcorrected) =~ /\*blank\*/) || (lc($currcorrected) =~ /__blank__/)) && ($blank_test_counter > $max_blank_test_counter)) {
			   next;
			 }

			 if (($currcorrected eq "") || ($currcorrected eq " ") || (lc($currcorrected) =~ /\*blank\*/) || (lc($currcorrected) =~ /__blank__/)) {
			   $blank_test_counter++;
			 }
		   }

		   if ($response_exclusion_tag_string ne "") {
			 if ($mode eq "test") {
			   $temp_item_category = lc($currcat);
			   if (lc($response_exclusion_tag_string) =~ /\b($temp_item_category)\b/) {
#					print "hereaaa2: changed_utt=$currtrans, item_category=$temp_item_category\n";

				 next;
			   }
			 }
		   }

		   print SPLITFILEOUT "$currwavfile\t$currtrans\t$currcat\n";

		   $split_counter++;
		 }

		 close (SPLITFILEOUT);

		 DebugPrint ("BOTH", 0.1, "CheckForTranscriptions", $debug, $err_no++, "Creating ".$parsefile."_TRAINING ($split_training_percent%)"." and ".$parsefile."_TEST (".(100 - $split_training_percent)."%)"." with a maximum of $blank_test_percent% BLANK sentences.\n");

		 exit;
	   }

	   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Performing Sentence Analysis");

	   ($autotag_sentence) = FillHashes($general_args, $wordnet_args, \@pos_corrected_array, \%default_pos_hash, \%wordnet_pointer_hash, \%wordnet_hash, \%replacement_frequency_hash, \%pos_only_hash, $compressed_alias_sentence_array, \@wordbag_compressed_sentence_array, \@wordbag_compressed_alias_sentence_array, $do_filtercorpus_direct, $filtercorpus_direct_in, $contains_categories, $corrected_array, $compressed_sentence_array, \%line_hash, \%orig_2_line_hash, \%filename_2_line_hash, $sentence_cat_assignments_hash, $original_wavfile_array, $original_transcription_array, $original_cat_array, $test_slotname, $test_confirm_as, $test_slotname_nuance_speakfreely, $test_confirm_as_nuance_speakfreely, $ending_noun_hash, $ending_verb_hash, $ending_adjective_hash, $osr_args);

	   @$compressed_alias_sentence_array = ();
	   @wordbag_compressed_sentence_array = ();
	   @wordbag_compressed_alias_sentence_array = ();

	   if ($do_transcat) {
		   my($compressed_alias_sentence_esus);
		   my($compressed_sentence_esus);
		   my($wordbag_compressed_alias_sentence_esus);
		   my($wordbag_compressed_sentence_esus);

		   $pre_search_string = ApplyTransSentence($pre_search_string, $trans_hash, $original_cat_array);

		   ($compressed_sentence_esus, $compressed_alias_sentence_esus, $wordbag_compressed_sentence_esus, $wordbag_compressed_alias_sentence_esus) = ApplyCompression($general_args, $meaning_args, $wordnet_args, $pre_search_string, $compressed_already_hash, $wordlist_already_hash);

#		   @$corrected_esus_array = split /\º/, $corrected_sentence_esus;
#		   @$pseudo_corrected_esus_array = split /\º/, $corrected_sentence_esus;
#		   @$compressed_sentence_esus_array = split /\º/, $compressed_sentence_esus;
#		   @$compressed_alias_sentence_esus_array = split /\º/, $compressed_alias_sentence_esus;
#		   @$wordbag_compressed_sentence_esus_array = split /\º/, $wordbag_compressed_sentence_esus;
#		   @$wordbag_compressed_alias_sentence_esus_array = split /\º/, $wordbag_compressed_alias_sentence_esus;

#		   if ($contains_categories) {
#			   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Creating es-us Known Categories File");
#			   WriteOutNewKnownCats($general_args, "_esus", $knowncatsfile, $do_filtercorpus_direct, $corrected_esus_array, \@original_cat_esus_array, $reclass_hash, $keyword_2_filtered_utt_hash, $wordbag_keyword_2_filtered_utt_hash, $sentence_cat_esus_hash, $corrected_esus_array, $compressed_sentence_esus_array, $compressed_alias_sentence_esus_array, $wordbag_compressed_sentence_esus_array, $wordbag_compressed_alias_sentence_esus_array, $truth_knowncats_esus_hash, $parsefile);
#
#		   }
	   }

	   if (($$general_args{"create_regexp"}) || ($use_original_wavfiles) ) {
		 open(NEWPARSEFILEORIG,">"."slmdirect_results\/createslmDIR_info_files\/info_original_label_total") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_original_label_total";
		 print NEWPARSEFILEORIG join "\n", @$original_wavfile_array, "\n";
		 close(NEWPARSEFILEORIG);
	   }

	   open(NEWPARSEFILEORIG,">"."slmdirect_results\/createslmDIR_info_files\/info_original_transcription_total") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_original_transcription_total";
	   print NEWPARSEFILEORIG join "\n", @$original_transcription_array, "\n";
	   close(NEWPARSEFILEORIG);

	   $sentence_order = scalar (@$corrected_array);

	   if (($$wordnet_args{"do_autotag"} || $$wordnet_args{"do_synonyms"}) && $$wordnet_args{"wordnet_available"}) {
		   $sentence_order = scalar (@$corrected_array) + 1;

		   open(DEFAULTPOS,">"."slmdirect_results\/createslmDIR_wordnet_files\/info_default_pos".$$general_args{"language_suffix"}) or die "cant open "."slmdirect_results\/createslmDIR_wordnet_files\/info_default_pos".$$general_args{"language_suffix"};

		   $found = 0;
		   foreach $elem ( sort { $a cmp $b } keys %default_pos_hash) {
			   $found = 1;
			   print DEFAULTPOS "$elem\t", $default_pos_hash{$elem}, "\n";
		   }

		   close(DEFAULTPOS);

		   if (!$found) {
			   unlink "slmdirect_results\/createslmDIR_wordnet_files\/info_default_pos".$$general_args{"language_suffix"};
		   } else {
			   DebugPrint ("BOTH", 1, "FillWordNetHash_1", $debug, $err_no++, "WordNet Default Part of Speech File created: "."slmdirect_results\/createslmDIR_wordnet_files\/info_default_pos".$$general_args{"language_suffix"});
		   }

		   undef %wordnet_pointer_hash;
		   undef %wordnet_hash;
		   undef %pos_only_hash;
		   undef %default_pos_hash;
		   undef %{$pre_hash};
		   @pos_corrected_array = ();
	   }

	   if ($$wordnet_args{"do_autotag"}) {
		   DebugPrint ("BOTH", 0, "CheckForTranscriptions", $debug, $err_no++, "Processing Autotag Sentences");
		   AutoTagFinal($meaning_args, $wordnet_args, $$general_args{"language_suffix"}, $autotag_sentence, \%replacement_frequency_hash, $corrected_array, $compressed_sentence_array, $original_wavfile_array, $original_transcription_array);

		   $autotag_sentence = "";
	   }

	   $parsefile = "slmdirect_results\/createslmDIR_info_files\/info_clean_transcription_total";
	 } # end if (input_is_transcription) 

   if ($$wordnet_args{"do_synonyms"} && $$wordnet_args{"wordnet_available"} && !$contains_categories) {
	   $sentence_order = $synonym_sentence_order_start;
   }

  ApplyFindBadChars($pre_search_string, $$general_args{"language_suffix"});

  StoreInitialWords($general_args, $pre_search_string);
  SaveCleanSentence($pre_search_string);

############################################################################
# Read the Category List (Central to TagsDirect)
############################################################################
#
  if ($do_read_catlist) {
	my($real_corpus) = 1;

	WriteAssignmentFile($$general_args{"main_language"}, $sentence_cat_hash);

	MakeCatList1($general_args, $meaning_args, $wordnet_args, $cleaning_args, $gen_grammar_elem_hash, $allow_general_hash, $changed_utt_repeat_hash, $disallow_general_hash, $do_addmainrules_only, $do_tagsdirect, $do_include_garbagereject, $gsl_filler_hash, $parsefile, \%line_hash, \%orig_2_line_hash, \%filename_2_line_hash, $real_corpus, $rule_multiplier, $utt_source, $vocabfile, $wordlist_already_hash);

# Attention herexxx
	if ($$general_args{"grammar_type"} eq "NUANCE_GSL") {
		foreach $elem ( sort { $a cmp $b } keys %{$gsl_filler_hash}) {
			foreach $elem1 ( sort { $a cmp $b } keys %{$$gsl_filler_hash{$elem}}) {
				if ($elem1 ne "") {
					FillGrammarElements($general_args, $gen_grammar_elem_hash, $rule_multiplier, $elem1, $elem1, $elem, 0, "NUANCE_GSL_FILLER", $utt_source);
				}
			}
		}
	}
#	undef %line_hash;
#	undef %orig_2_line_hash;
	undef $pre_search_string;

  } else {
	$pre_search_string = ApplyBuildMainString($pre_search_string);
  }

   return ($pre_search_string, $sentence_order, $synonym_sentence_order, $parsefile, $input_is_transcription, $err_no, $nl_total_records, $nl_blank_utts);
}

sub checkRules
{
  my($nl_control, $nlrc_template_name, $do_read_catlist, $do_make_nlrule_init, $rule_varname_hash, $varname_hash, $neg_rule_varname_hash, $rule_error_nullor_hash, $rule_error_double_dollar_hash, $rule_now_correction_error_hash, $rule_error_badalias_hash, $rule_error_missingalias_hash, $rule_error_countparens_hash, $rule_error_emptyparens_hash, $unknown_nl_types_hash) = @_;

  my($elem) = 0;
  my($elem1) = 0;
  my($fail_found) = 0;
  my($fail_string) = "";

  DebugPrint ("BOTH", 0, "checkRules", $debug, $err_no++, "Checking Rules in ".NormalizeFilename($nl_control));
  foreach $elem1 ( sort { $a cmp $b } keys %{$rule_varname_hash}) {
	if (not defined $$varname_hash{$elem1}) {
	  $fail_string = stringBuilder($fail_string, "Missing Variable: [ $elem1 ]", "\n");
	  $fail_found = 1;
	}
  }

  foreach $elem1 ( sort { $a cmp $b } keys %{$neg_rule_varname_hash}) {
	if (not defined $$varname_hash{$elem1}) {
	  $fail_string = stringBuilder($fail_string, "Negative Rules Missing Variable: [ $elem1 ]", "\n");
	  $fail_found = 1;
	}
  }

  if ((scalar keys %{$rule_error_nullor_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_nullor_hash}) {
	  $fail_string = stringBuilder($fail_string, "Null \'OR\' Condition in: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_error_double_dollar_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_double_dollar_hash}) {
	  $fail_string = stringBuilder($fail_string, "Too many characters: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_now_correction_error_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_now_correction_error_hash}) {
	  $fail_string = stringBuilder($fail_string, "Spelling Pair Error: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_error_badalias_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_badalias_hash}) {
	  $fail_string = stringBuilder($fail_string, "Bad Alias Construction in: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_error_missingalias_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_missingalias_hash}) {
	  $fail_string = stringBuilder($fail_string, "Alias Not Defined in: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_error_countparens_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_countparens_hash}) {
	  $fail_string = stringBuilder($fail_string, "Parentheses don't match in: [ $elem1 ]", "\n");
	}
  }

  if ((scalar keys %{$rule_error_emptyparens_hash}) != 0) {
	$fail_found = 1;
	foreach $elem1 ( sort { $a cmp $b } keys %{$rule_error_emptyparens_hash}) {
	  $fail_string = stringBuilder($fail_string, "Parentheses enclose empty string in: [ $elem1 ]", "\n");
	}
  }

  if ($fail_found) {
	if ($do_read_catlist || $do_make_nlrule_init) {
	  print DebugPrint ("BOTH", 1, "checkRules", $debug, $err_no++, "Rules Check Failed in $nlrc_template_name: $fail_string\n\n");
	} else {
	  print DebugPrint ("BOTH", 1, "checkRules", $debug, $err_no++, "Rules Check Failed in ".NormalizeFilename($nl_control).": $fail_string\n\n");
	}

	exit(1);
  }

  unlink "slmdirect_results\/createslmDIR_info_files\/info_unknown_command_variables";
  if ((scalar keys %{$unknown_nl_types_hash}) > 0) {
	open(UNKWARN,">"."slmdirect_results\/createslmDIR_info_files\/info_unknown_command_variables") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_unknown_command_variables";
	DebugPrint ("BOTH", 2, "checkRules", $debug, $err_no++, "Unknown Command Variables in ".NormalizeFilename($nl_control)."!");
	foreach $elem ( sort { $a cmp $b} keys %{$unknown_nl_types_hash}) {
	  foreach $elem1 ( sort { $a cmp $b } keys %{$$unknown_nl_types_hash{$elem}}) {
		DebugPrint ("BOTH", 1, "checkRules", $debug, $err_no++, "$elem in line $elem1");
		print UNKWARN "$elem\t$elem1\n";
	  }
	}

	close(UNKWARN);
  }
}

sub alignUtts
{
   my($changed_utt, $filtered_utt) = @_;

   if ($filtered_utt eq $changed_utt) {
	 $filtered_utt = "ç";
   }

   return ($filtered_utt);
 }

sub retrieveUtts
{
  my($changed_utt, $filtered_utt) = @_;

  if ($filtered_utt eq "ç") {
	$filtered_utt = $changed_utt;
  }

  return ($filtered_utt);
}

sub stringBuilder
{
  my($build_string, $elem, $separator) = @_;

  if ($build_string eq "") {
	$build_string = $elem;
  } else {
	$build_string = $build_string.$separator.$elem;
  }

  return ($build_string);
}

sub SeparateTaggedSentences
{
  my($source, $parsefile, $tagged_sentence_file, $untagged_sentence_file, $retagged_categories_file) = @_;

  my($elem);
  my($filename);
  my($line);
  my($lastchar);
  my($tagged_found) = 0;
  my($total_lines);
  my($transcription);
  my($untagged_found) = 0;
  my(@rest);
  my(%retagged_cat_hash);

#  print "source=$source, tagged_sentence_file=$tagged_sentence_file, untagged_sentence_file=$untagged_sentence_file\n";

  open(CORPUS,"<$parsefile") or die "cant open $parsefile";
  open(TAGGED,">$tagged_sentence_file") or die "cant write $tagged_sentence_file";
  open(UNTAGGED,">$untagged_sentence_file") or die "cant write $untagged_sentence_file";

  while (<CORPUS>) {
	$line = ChopChar($_);

	if ($line eq "") {
	  next;
	}

	if (substr($line,0,1) eq "#") {
	  next;
	}

	($filename, $transcription, @rest) = split "\t", $line;
	if ($line =~ /Ramble Exclusion/) {
	  next;
	}

	$lastchar = substr($line,length($line)-1,1);
	if (($rest[0] ne "") && ($rest[0] ne " ")) {
	  $tagged_found = 1;
	  while ($lastchar eq "\t") {
		chop($line);
		$lastchar = substr($line,length($line)-1,1);
	  }

	  print TAGGED "$line\n";

	  $retagged_cat_hash{$rest[0]}++;
	} else {
	  $untagged_found = 1;
	  while ($lastchar eq "\t") {
		chop($line);
		$lastchar = substr($line,length($line)-1,1);
	  }

	  print UNTAGGED "$line\n";
	}

	$total_lines++;
  }

  if (scalar(keys %retagged_cat_hash) > 0) {
	open(RECAT,">$retagged_categories_file") or die "cant write $retagged_categories_file";
	foreach $elem ( sort { $a cmp $b } keys %retagged_cat_hash) {
	  print RECAT "$elem\n";
	}
  }

  close (RECAT);
  close (CORPUS);
  close (TAGGED);
  close (UNTAGGED);

  return ($tagged_found, $untagged_found, $total_lines);
}

sub setClassGrammarVocabItem
{
  my($type, $full_path_item, $absolute_path) = @_;

  my($elem);
  my($elem1);
  my($elem2);
  my($root_name);
  my($item);
  my($sub_item);
  my($use_specific_data) = 0;
  my(@cat_array);
  my(@temp_array);
  my(@specific_data_array);

  if (index ($full_path_item, "=") != -1) {
	(@cat_array) = split "=", $full_path_item;
	$full_path_item = $cat_array[0];
  }

  $full_path_item =~ s/\ª//g;
  if ($full_path_item =~ /\+/) {
	$full_path_item =~ s/\+//g;
	$full_path_item =~ s/\\/\//g;

	if ($full_path_item =~ /\;/) {
	  $use_specific_data = 1;
	  (@specific_data_array) = split /\;/, $full_path_item;
	  $full_path_item = shift @specific_data_array;
	  $root_name = shift @specific_data_array;
	}

	if ($full_path_item =~ /\//) {
	  (@temp_array) = split "\/", $full_path_item;
	  $full_path_item = pop @temp_array;

	  $absolute_path = join "/", @temp_array;
	  $full_path_item = "$absolute_path"."/"."$full_path_item";
	  $full_path_item =~ s/\º/\:/g;
	}

	$elem1 = $full_path_item;
	$elem1 =~ s/\.grxml//g;
  } else {
	$elem1 = uc($full_path_item);
	$elem2 = lc($full_path_item);

	$elem1 =~ s/\ª//g;
	$elem2 =~ s/\ª//g;

	$full_path_item = "$absolute_path"."$elem2\.grxml";
  }

  if ($use_specific_data) {
	if ($type eq "fsm_nuance9") {
	  $item = "<ruleref uri=\"$full_path_item\"/>\n";
	} else {
	  $item = "<ruleref uri=\"$full_path_item\#$root_name\">\n\t<tag>\n\t\tif (typeof(SWI_meaning) == 'undefined')\n\t\t\tSWI_meaning = ";

	  $sub_item = "";
	  foreach $elem (@specific_data_array) {
		if ($sub_item eq "") {
		  $sub_item = "'$elem=' + $root_name\.$elem";
		} else {
		  $sub_item = $sub_item." + "."' $elem=' + $root_name\.$elem";
		}
	  }

	  $item = $item.$sub_item."\n\t\telse\n\t\t\tSWI_meaning += ' ' + ".$sub_item."\n\t</tag>\n</ruleref>\n";
	}
  } else {
	if ($type eq "fsm_nuance9") {
	  $item = "<ruleref uri=\"$full_path_item\"/>\n";
	} else {
	  $item = "<ruleref uri=\"$full_path_item\#ROOT\">\n\t<tag>\n\t\tif (typeof(SWI_meaning) == 'undefined')\n\t\t\tSWI_meaning = '$elem1=' + ROOT.$elem1\n\t\telse\n\t\t\tSWI_meaning += ' ' + '$elem1=' + ROOT.$elem1\n\t</tag>\n</ruleref>\n";
	}
  }

  return ($item);
}

sub setClassGrammarSentenceItem
{
  my($full_path_item, $absolute_path) = @_;

  my($elem1);
  my($item);
  my(@cat_array);
  my(@specific_data_array);
  my(@temp_array);

  $full_path_item =~ s/\ª//g;
  if ($full_path_item =~ /\+/) {
	$full_path_item =~ s/\+//g;
	$full_path_item =~ s/\\/\//g;

	if ($full_path_item =~ /\;/) {
	  (@specific_data_array) = split /\;/, $full_path_item;
	  $full_path_item = shift @specific_data_array;
	}

	if ($full_path_item =~ /\//) {
	  (@temp_array) = split "\/", $full_path_item;
	  $full_path_item = pop @temp_array;

	  $absolute_path = join "/", @temp_array;
	  $full_path_item = "$absolute_path"."/"."$full_path_item";
	  $full_path_item =~ s/\º/\:/g;
	}
  } else {
	$elem1 = $full_path_item;
	$elem1 =~ s/\.grxml//g;
	$elem1 = lc($full_path_item);
	$elem1 =~ s/\ª//g;

	$full_path_item = "$absolute_path"."$elem1\.grxml";
  }

  $item = "<ruleref uri=\"$full_path_item\"/>";

  return ($item);
}

sub ParseGrammar
{
    my($in_test) = @_;

	my(@out_test);
	my(@words_array);
	my($base);
	my($endpos) = -1;
	my($loop_test);
	my($newstr);
	my($paren_found);
	my($remaining_string);
	my($startpos) = -1;
	my($sub_test);
	my($temp_test);
	my($words_elem);

	$temp_test = $in_test;
	$paren_found = index($temp_test, "(");
	while ($paren_found != -1) {
		$startpos = $paren_found;
		$endpos = GetClosure_SLMDirect($startpos, "(", ")", $temp_test);
		$loop_test = substr($temp_test, $startpos+1,$endpos-$startpos-2);
		$loop_test = TrimChars($loop_test);

		if (index($loop_test, "(") != -1) {
			$loop_test = ParseGrammar($loop_test);
		}

		$loop_test =~ s/ (?!\[|\])/\=/g;

		if ($startpos == 0) {
			$temp_test = $loop_test." ".substr($temp_test, $endpos+1);
		} else {
			$sub_test = substr($temp_test, 0, $startpos);
			$sub_test = TrimChars($sub_test);

			$temp_test = $sub_test." ".$loop_test." ".substr($temp_test, $endpos);
		}

		$temp_test = TrimChars($temp_test);
		$paren_found = index($temp_test, "(");
	}

	$temp_test =~ s/\[ /\[/g;
	$temp_test =~ s/ \]/\]/g;

	$paren_found = index($temp_test, "[");
	if ($paren_found != -1) {

		$startpos = $paren_found;
		$endpos = GetClosure_SLMDirect($startpos, "[", "]", $temp_test);

		$newstr = substr($temp_test, $startpos+1,$endpos-$startpos-2);

		@words_array = split " ", $newstr;

		$remaining_string = substr($temp_test, $endpos);

		$base = "";
		if ($startpos > 0) {
			$base = substr($temp_test, 0, $startpos);
			$base = TrimChars($base);
		}

		if ($remaining_string ne "") {
			$paren_found = index($remaining_string, "[");
			if ($paren_found != -1) {
				my(@pg_array);
				my($pg_elem);
				@pg_array = ParseGrammar($remaining_string);
				foreach $words_elem (@words_array) {
					$words_elem =~ s/\=/ /g;
					$words_elem = TrimChars($words_elem);
					foreach $pg_elem (@pg_array) {
						$pg_elem =~ s/\=/ /g;
						$pg_elem = TrimChars($pg_elem);

						if ($base ne "") {
							push @out_test, $base." ".$words_elem." ".$pg_elem;
						} else {
							push @out_test, $words_elem." ".$pg_elem;
						}
					}
				}
			} else {
				foreach $words_elem (@words_array) {
					$words_elem =~ s/\=/ /g;
					$words_elem = TrimChars($words_elem);

					$remaining_string =~ s/\=/ /g;
					$remaining_string = TrimChars($remaining_string);

					if ($base ne "") {
						push @out_test, $base." ".$words_elem." ".$remaining_string;
					} else {
						push @out_test, $words_elem." ".$remaining_string;
					}
				}
			}
		} else {
			foreach $words_elem (@words_array) {
				$words_elem =~ s/\=/ /g;
				$words_elem = TrimChars($words_elem);

				if ($base ne "") {
					push @out_test, $base." ".$words_elem;
				} else {
					push @out_test, $words_elem;
				}
			}
		}
	} elsif ($temp_test ne "") {
		push @out_test, $temp_test;
	}

	return @out_test;
}

############# END Central Function SUBROUTINES #######################

################# END SLMDIRECT-SPECIFIC SUBROUTINES ##################

######################################################################
######################################################################
################# SLMDIRECT-WEB SUBROUTINES ######################
######################################################################
######################################################################

# Subroutine ReadParse
#
# Reads in GET or POST data, converts it to unescaped text, and puts
# key/value pairs in %in, using "\0" to separate multiple selections
# Returns >0 if there was input, 0 if there was no input 
# undef indicates some failure.
#
# If no parameters are given (i.e., ReadParse returns FALSE), then a
# form could be output. If no method is given, the script will process
# both command-line arguments of the form: name=value and any text that
# is in the query string. This is intended to aid debugging and may be
# changed in future releases

sub ReadParse
{
    my($raw_data) = @_;

	my(@raw_input) = () ;
	my($errflag) = '' ;
	my($cmdflag) = '' ;

	# Disable warnings as this code deliberately uses myand environment
	# variables which are preset to undef (i.e., not explicitly initialized)

	my($perlwarn) = $^W;
	$^W = 0;

	# Get several useful environment variables
	my($type) = &GetServerVariable ('CONTENT_TYPE') ;
	my($len)  = &GetServerVariable ('CONTENT_LENGTH') ;
	my($meth) = &GetServerVariable ('REQUEST_METHOD') ;

	if (!defined $meth || $meth eq '' || $meth eq 'GET' || $type eq 'application/x-www-form-urlencoded')
	{
		my($key, $val, $iii);

		# Read in text
		if (!defined $meth || $meth eq '')
		{
			$raw_input = &GetQueryString () ;
			$cmdflag = 1;  # also use command-line options
		}
		elsif ($meth eq 'GET' || $meth eq 'HEAD')
		{
			$raw_input = &GetQueryString () ;
		}
		elsif ($meth eq 'POST')
		{
			$errflag = &GetFormData ($len) ;
		}
		else
		{
			&DieMsg ("Fatal Error", "The script cannot continue because ".
						"it does not recognize the request method " . &HTMLEncodeText ($meth) . ".",
						"Please contact this site's webmaster") ;
		}

		# Save the unparsed raw input for logging
		$unparsed_raw_data = $raw_input ;

		@raw_input = split (/[&;]/, $raw_input);
		push (@raw_input, @ARGV) if $cmdflag; # add command-line parameters

		foreach $iii (0 .. $#raw_input)
		{
			# Convert plus to space
			$raw_input[$iii] =~ s/\+/ /g;

			# Split into key and value.  
			($key, $val) = split (/=/,$raw_input[$iii],2); # splits on the first =.
			# Convert %XX from hex numbers to alphanumeric
			$key =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;
			$val =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;

			if (substr ($key, 0, 2) eq 'M_')
         {
				# Get keys and values from value
				my(@mKeyVals) = split(/,/,$val); # splits on all , (commmas).
				if ($#mKeyVals >= 0)
				{
					for (my($jjj) = 0 ; $jjj <= $#mKeyVals ; $jjj += 2)
					{
						my($mKey) = $mKeyVals[$jjj] ;
						my($mVal) = $mKeyVals[$jjj + 1] ;

						$mKey =~ s/^\s+//;			# Remove beginning white space
						$mKey =~ s/\s+$//;			# Remove ending white space

						$mVal =~ s/^\s+//;			# Remove beginning white space
						$mVal =~ s/\s+$//;			# Remove ending white space

						# Associate key and value
						if (defined ($$raw_data{$mKey}))
						{
							&DieMsg ("Fatal Error", "The script cannot continue because ".
							         "the call contains multiple references to the name " . &HTMLEncodeText ($key) . ". ".
									   "Remove or rename one of the references or contact this site's webmaster.") ;
						}
						$$raw_data{$mKey} .= $mVal;
					}
				}
			}
			else
			{
				# Associate key and value
				if (defined ($$raw_data{$key}))
				{
					&DieMsg ("Fatal Error", "The script cannot continue because ".
					         "the call contains multiple references to the name " . &HTMLEncodeText ($key) . ". ".
								"Remove or rename one of the references or contact this site's webmaster.") ;
				}
				$$raw_data{$key} .= $val;
			}
		}
	}
	else
	{
		my($contentType) = &GetServerVariable ('CONTENT_TYPE') ;
		&DieMsg ("Fatal Error", "The script cannot continue because ".
					"it does not recognize the content-type " . &HTMLEncodeText ($contentType) . ". ",
					"Please contact this site's webmaster.") ;
	}
	$^W = $perlwarn;
	return ($errflag ? undef :  scalar(@raw_input));
}

# Subroutine DieMsg
#
# Prints out an error message which contains appropriate headers and
# titles, then quits with the error message. 
#
# Parameters:
#	 If no parameters, gives a generic error message
#   Otherwise, the first parameter will be the title and the rest will 
#   be given as different paragraphs of the body

sub DieMsg
{
	my(@msg) = @_;
	my($iii) ;
	my($name) = '';
	my($kVersion) = "1.0";

	if (!@msg)
	{
		$name = &ScriptUrl ();
		@msg = ("Fatal Error", "The script " . &HTMLEncodeText ($name) . " encountered the error $!.",
				  "Please contact this site's webmaster.") ;
	}
	&SendToOutput (&GetContentTypeHTML ());
	&SendToOutput ("<html>\n<head>\n<title>$msg[0]</title>\n</head>\n<body>\n") ;
	&SendToOutput ("<h1>$msg[0]</h1>\n") ;
	foreach $iii (1 .. $#msg)
	{
		&SendToOutput ("<p>$msg[$iii]</p>\n") ;
	}
	&SendToOutput ("<p><h6>v$kVersion - ".$]."</h6></p>\n") ;
	&SendToOutput ("</body>\n</html>\n") ;
	exit 1 ;
}

# Subroutine HTMLEncodeText
#
# Returns an HTML encoded version of the given text.

sub HTMLEncodeText
{
	my($enc) = $_[0] ;

	# Encode the named entities
	$enc =~ s/\&/&amp;/g ;					# Replace & with &amp;
#	$enc =~ s/ /&nbsp;/g ;					# Replace space with &nbsp;
	$enc =~ s/"/&quot;/g ;					# Replace " with &quot;
	$enc =~ s/</&lt;/g ;						# Replace < with &lt;
	$enc =~ s/>/&gt;/g ;						# Replace > with &gt;

	return $enc ;
}

# ------------------------------
# Platform dependent subroutines
# ------------------------------

# --- CGI ---

# Subroutine GetServerVariable
#
#

sub GetServerVariable
{
	return $ENV{$_[0]} ;
}

# Subroutine GetQueryString
#
#

sub GetQueryString
{
	return $ENV{'QUERY_STRING'} ;
}

# Subroutine GetFormData
#
#

sub GetFormData
{
	my($len) = $_[0] ;
	my($errflag) = '' ;
	my($got) = read (STDIN, $raw_input, $len) ;
	
	if ($got != $len)
	{
		$errflag = "Short Read: wanted $len, got $got\n";
	}
	return $errflag ;
}

# Subroutine GetContentTypeHTML
#
#

sub GetContentTypeHTML
{
	return "Content-Type: text/html\n\n" ;
}

# Subroutine SendToOutput
#
#

sub SendToOutput
{
	print $_[0] ;
}

# Subroutine GetLocationRedirect
#
#

sub GetLocationRedirect
{
	return "Location: ".$_[0]."\n\n" ;
}

################# END SLMDIRECT-WEB SUBROUTINES ##################

# ********************************************************************
# End of file
# ********************************************************************
