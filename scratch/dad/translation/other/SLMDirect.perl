#!/usr/bin/perl
# SLMDirect
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
# Generate an SLM grammar from sentence data
#
# Modified: Mon Apr 16 10:41:02 2012
#
# Created: August 12, 2011 v1.0 Larry Piano
#

$webSwitch = 0;
my($repository) = ".";
if ($webSwitch) {
  use lib "/usr/lib/perl5/5.10";
} else {
  use lib "c:/cygwin/lib/perl5/5.10/i686-cygwin";
}

BEGIN {
  local($lib);
  if ($webSwitch) {
	push(@INC,"/usr/lib/perl5/5.10","/home/abaciivo/public_html/scripts");
  } else {
	$lib = $ENV{SLMPERL};
	push(@INC,"c:/cygwin/lib/perl5/5.10/i686-cygwin","c:/Program Files/SLMDirect");
  }
}

############################################################################
# Set Special Variable or Options
############################################################################
#

#use strict 'vars';
my($wordnet_available) = 0;
if (!$webSwitch) {
  if (defined $ENV{WNHOME}) {
	$wordnet_available = 1;
	require WordNet::QueryData;
  }
}

use Getopt::Long;
use File::Copy;
use DirectSLM;

select((select(STDOUT),$| = 1)[0]);  #flush each print

############################################################################
# Define Program Variables
############################################################################
#

my($add_varname);
my($add_word);
my($addtestfile) = "";
my($alias_def);
my($alias_name);
my($ambig_active);
my($appendtestfile) = "";
my($assignment_source) = "";
my($assoc_name);
my($assoc_val);
my($auto_max);
my($autocat);
my($auto_class_grammar_search_string) = "";
my($autotag_option) = "";
my($called_from_gui) = 0;
my($cat_file_init) = "";
my($cat_text);
my($catdef_file) = "";
my($category_pre_search_string);
my($changed_utt);
my($checkcats_files);
my($classify_string);
my($classifyfileout) = "";
my($classify_sentence_file) = "slmdirect_results\/createslmDIR_temp_files\/temp_classify_sentences";
my($classify_unknown_sentence_file) = "slmdirect_results\/createslmDIR_temp_files\/temp_classify_unknown_sentences";
my($clean_only) = 0;
my($combo);
my($command_line_options);
my($company_filter) = "blotisimo";
my($company_name);
my($connector);
my($container_file_in) = "";
my($contains_categories);
my($correct_spelling_test_string) = "";
my($corrected_sentence);
my($correction);
my($counta);
my($counter);
my($debug) = 0;
my($do_add_grammar) = 0;
my($do_add_vocab) = 0;
my($do_add_wordnet_pos) = 0;
my($do_add_wordnet_synonym) = 0;
my($do_addallrules) = 0;
my($do_addmainrules_only) = 0;
my($do_alias_exclusion) = 0;
my($do_allow_general) = 0;
my($do_ambig_gen_rule) = 0;
my($do_ambig_only) = 0;
my($do_ambig_rule) = 0;
my($do_assoc_array) = 0;
my($do_autotag) = 0;
my($do_char_omit) = 0;
my($do_check_nlrules) = 0;
my($do_checkcats) = 0;
my($do_automatic_class_grammars) = 0;
my($do_class_grammars) = 0;
my($do_classify) = 0;
my($do_conditional_replace) = 0;
my($do_correct_spelling) = 0;
my($do_create_regexp) = 0;
my($do_delete_char) = 0;
my($do_exclude_numbers) = 0;
my($do_exclude_words);
my($do_expand_grammar) = 0;
my($do_explicit_categories) = 0;
my($do_external_rule) = 0;
my($do_filtercorpus_direct) = 0;
my($do_filtertestline) = 0;
my($do_flatfile_transcriptions) = 1;
my($do_generic_rule) = 0;
my($do_grammar) = 0;
my($do_grammar_gen) = 0;
my($do_heavy_categories) = 0;
my($do_include_garbagereject) = 0;
my($do_join) = 0;
my($do_label_omit) = 0;
my($do_label_replace) = 0;
my($do_main_rule) = 0;
my($do_make_nlrule_init) = 0;
my($do_make_nlrule_init_test) = 0;
my($do_max_filter_sentence_length) = 0;
my($do_max_wordnet_count) = 0;
my($do_max_wordnet_sentence_length) = 0;
my($do_merge_noun_prefix) = 0;
my($do_merge_noun_verb_alias) = 0;
my($do_merge_verb_prefix) = 0;
my($do_min_wordnet_frequency_adjective) = 0;
my($do_min_wordnet_frequency_noun) = 0;
my($do_min_wordnet_frequency_verb) = 0;
my($do_no_tag_unknown) = 0;
my($do_normal_slm_nuance9) = 0;
my($do_normal_slm_speakfreely);
my($do_precision_recall) = 0;
my($do_product_prefix) = 0;
my($do_put_defaults) = 0;
my($do_read_catlist) = 0;
my($do_read_newcats) = 0;
my($do_replace) = 0;
my($do_response_exclusion) = 0;
my($do_response_exclusion_tags) = 0;
my($do_restore) = 0;
my($do_retag) = 0;
my($do_robust_parsing_nuance9) = 0;
my($do_robust_parsing_speakfreely);
my($do_search) = 0;
my($do_sentence_length) = 0;
my($do_set_false_frequency) = 0;
my($do_specify_dictionary) = 0;
my($do_split_train_test) = "";
my($do_suppress_grammar) = 0;
my($do_synonyms) = 0;
my($do_tagging) = "";
my($do_tagsdirect) = 0;
my($do_test_variable) = 0;
my($do_testparsefile) = 0;
my($do_testsentence);
my($do_trainfile_meta) = 0;
my($do_trainfile_param) = 0;
my($do_trainfile_ssm_param) = 0;
my($do_trainfile_stop) = 0;
my($do_transcat) = 0;
my($do_use_product_prefix) = 0;
my($do_use_rule_multiplier) = 0;
my($do_valid_restricted_end) = 0;
my($do_valid_restricted_general) = 0;
my($do_variable) = 0;
my($do_verify_rules) = 0;
my($do_word_groups) = 0;
my($do_write_data_files) = 0;
my($done_reapply_parsingrules);
my($dont_check_nlrules) = 0;
my($dont_clean) = 0;
my($dont_do_additional_command_vars) = 0;
my($downcase_utt) = 0;
my($elem) = "";
my($elem1) = "";
my($elem2) = "";
my($err);
my($err_no) = 0;
my($expand_vanilla) = 1;
my($external_Rule_count) = 0;
my($failparsefile);
my($failparsefile_write_out) = "FAILPARSEFILE";
my($failparsefile_write_out_catonly) = "TESTPARSEFILEOUT_CATONLY";
my($file);
my($filename);
my($filename_pre_search_string);
my($filenames_are_unique) = 0;
my($filesize);
my($filter_corpus) = 0;
my($filtercorpus_direct_in) = "createslm_init_sentences_with_categories";
my($filtercorpusfileout);
my($filtered_utt);
my($first);
my($found);
my($founda);
my($gen_referencetagfile) = "";
my($general_Rule_count) = 3;
my($generic_scale_factor) = 0.001;
my($genref_string);
my($grammar_pointer) = "";
my($grammar_type);
my($grammarbase);
my($i);
my($indentXML_file) = "";
my($infile) = "";
my($input_is_transcription) = 0;
my($item_category);
my($item_id);
my($j);
my($keep_fragment_length) = 0;
my($knowncatsfile_change) = "";
my($language_suffix) = "";
my($level_count);
my($line);
my($line_num);
my($loop_count);
my($main_Ambig_Rule_count) = 0;
my($main_Rule_count) = 0;
my($main_language) = "en-us";
my($main_search_string);
my($make_failparse) = 0;
my($make_maingrammar) = 0;
my($make_truth_files) = 0;
my($make_vocab) = 0;
my($max_filter_sentence_length) = 10;
my($max_wordnet_count) = 5;
my($max_wordnet_sentence_length) = 10;
my($merge_nouns) = "";
my($merge_real) = "";
my($merge_shallow) = "";
my($merge_verbs) = "";
my($min_freq) = 1;
my($min_wordnet_frequency_adjective) = 2;
my($min_wordnet_frequency_noun) = 10;
my($min_wordnet_frequency_verb) = 5;
my($new_counta);
my($new_varname);
my($next);
my($nl_blank_utts) = 0;
my($nl_control);
my($nl_counter);
my($nl_counter_rules);
my($nl_not_handled) = 0;
my($nl_total_records) = 0;
my($nl_type);
my($normalization_level) = "";
my($now);
my($nuance9_swisrsdk_location);
my($old_rules_file);
my($perl_path) = "";
my($pre_search_string);
my($pre_search_string_count);
my($prev_level_count);
my($prev_parsefile);
my($ramble_exclusion_string) = "ramble";
my($readlen);
my($reclassfile_in) = "";
my($reclassification_file) = "";
my($referencetagfile) = "";
my($removerepeats) = 1;
my($response_exclusion_string) = "";
my($response_exclusion_string_tags) = "";
my($retagged_categories_file) = "slmdirect_results\/createslm_applytags_categories";
my($retagged_sentence_file) = "slmdirect_results\/createslm_applytags_sentences";
my($rule_multiplier);
my($runbats) = 0;
my($scan_language) = "";
my($second);
my($sentence_length_for_scan) = 25;
my($sentence_order);
my($set_normal_varvalue);
my($shallow_parse_real_corpus_grammarfileout);
my($statsfile) = "";
my($sub_type);
my($err_msg_no_in);
my($warning_msg_no_in);
my($sub_task_no_in);
my($swisrsdk_location_nuance9) = "C:\/Program Files/Nuance\/Recognizer";
my($swisrsdk_location_speakfreely) = "C:\/Program Files\/SpeechWorks\/OpenSpeech Recognizer";
my($syn_found);
my($syn_wordfreq_sentence);
my($synonym_option) = "";
my($synonym_sentence_order);
my($synonym_threshold);
my($tagged_sentence_file) = "slmdirect_results\/createslmDIR_temp_files\/temp_tagged_sentences";
my($taggedcorpusfile) = "";
my($target_language) = "";
my($task_no_in);
my($num_errors_in);
my($num_warnings_in);
my($temp_alias_name);
my($temp_qaz);
my($temp_sentence);
my($temp_sentence1);
my($temp_sentence2);
my($temp_string);
my($temp_test_reject_name);
my($test_sequence) = "random";
my($testparsefileout);
my($total_adjective_count) = 0;
my($total_auto_cats_assigned);
my($total_noun_count) = 0;
my($total_verb_count) = 0;
my($trainingtestfile);
my($trainingwithtestfile);
my($transcat_file);
my($transition1);
my($transition2);
my($transition3);
my($transition4);
my($tuning_version) = "";
my($untagged_sentence_file) = "slmdirect_results\/createslmDIR_temp_files\/temp_untagged_sentences";
my($use_basecats) = "";
my($use_orig_trans) = 0;
my($use_previous_test_sequence) = 0;
my($use_reclassifications) = 0;
my($use_trad_trans);
my($utt_source) = "nil";
my($vanilla_callingProg) = $0;
my($varname);
my($varvalue);
my($version) = "";
my($vocabfile) = "";
my($w_mode) = "WRITEDATAFILES";
my($wavfilename);
my($with_retag) = 0;
my($wn);
my($words);
my($write_out) = "STDOUT";
my($write_out_catonly) = "STDOUT";
my(%BR_rule_assignment_hash);
my(%BR_rule_nofire_hash);
my(%ER_rule_assignment_hash);
my(%ER_rule_nofire_hash);
my(%GR_rule_assignment_hash);
my(%GR_rule_nofire_hash);
my(%MR_rule_assignment_hash);
my(%MR_rule_nofire_hash);
my(%add_dictionaries_hash);
my(%add_dictionaries_nuance9_hash);
my(%add_wordnet_pos_hash);
my(%add_wordnet_synonym_hash);
my(%alias_exclusion_hash);
my(%alias_search_esus_hash);
my(%alias_search_hash);
my(%allow_general_hash);
my(%alt_default_pos_hash);
my(%alt_syn_default_pos_hash);
my(%app_hash);
my(%apply_ambig_rules_hash);
my(%apply_rules_hash);
my(%assignment_hash);
my(%auto_catdef_found_hash);
my(%auto_catdef_hash);
my(%auto_cats_total_hash);
my(%auto_single_used_hash);
my(%cat_args);
my(%cat_seen_hash);
my(%changed_utt_repeat_hash);
my(%check_expand_hash);
my(%check_skip_hash);
my(%class_grammar_hash);
my(%classify_result_hash);
my(%classify_truth_hash);
my(%clean_trans_hash);
my(%cleaning_args);
my(%cmdopt);
my(%compressed_already_hash);
my(%defaultcmdopt);
my(%disallow_general_additional_hash);
my(%disallow_general_hash);
my(%ending_adjective_hash);
my(%ending_noun_hash);
my(%ending_verb_hash);
my(%explicit_categories_hash);
my(%external_rules_hash);
my(%full_vocab_hash);
my(%gen_grammar_elem_hash);
my(%general_args);
my(%generic_rules_hash);
my(%good_fragment_list_hash);
my(%gram_elem_cat_hash);
my(%grammar_elems_hash);
my(%grammar_elems_other_hash);
my(%grammar_rules_additional);
my(%grammar_rules_additional_nuance9);
my(%grammar_rules_additional_nuance_class_full_xml);
my(%grammar_rules_additional_nuance_speakfreely);
my(%gsl_filler_hash);
my(%heavy_categories_hash);
my(%input_catdef_used_hash);
my(%just_keywords_hash);
my(%keyword_2_filtered_utt_hash);
my(%level_counter_external_hash);
my(%level_counter_generic_hash);
my(%level_counter_hash);
my(%level_counter_mainambig_hash);
my(%message_hash);
my(%meaning_args);
my(%merge_noun_prefix_hash);
my(%merge_noun_verb_alias_hash);
my(%merge_verb_prefix_hash);
my(%neg_rule_varname_hash);
my(%new_cats_hash);
my(%nl_product);
my(%nl_product_utt);
my(%nl_rules_counter_hash);
my(%nl_rules_hash);
my(%nl_template_hash);
my(%nuance9_args);
my(%nuance_gsl_args);
my(%osr_args);
my(%pre_hash);
my(%pre_phrases_hash);
my(%reclass_hash);
my(%referencetag_hash);
my(%reverse_synonym_corrected_hash);
my(%rule_error_badalias_hash);
my(%rule_error_countparens_hash);
my(%rule_error_double_dollar_hash);
my(%rule_error_emptyparens_hash);
my(%rule_error_missingalias_hash);
my(%rule_error_nullor_hash);
my(%rule_now_correction_error_hash);
my(%rule_sentence_actual_hash);
my(%rule_sentence_hash);
my(%rule_varname_hash);
my(%rule_word_hash);
my(%seen_hash);
my(%sentence_cat_assignments_hash);
my(%sentence_cat_hash);
my(%skip_esus_hash);
my(%skip_hash);
my(%speakfreely_args);
my(%spell_checker_hash);
my(%stop_word_hash);
my(%store_FindReference_BR);
my(%store_FindReference_ER);
my(%store_FindReference_GR);
my(%store_FindReference_KWN);
my(%store_FindReference_KWN_wordbag);
my(%store_FindReference_MR);
my(%store_FindReference_MR_reclassifications);
my(%store_FindReference_MR_wordbag);
my(%store_FindReference_MR_wordbag_reclassifications);
my(%store_FindReference_focus_BR);
my(%store_FindReference_focus_ER);
my(%store_FindReference_focus_GR);
my(%store_FindReference_focus_KWN);
my(%store_FindReference_focus_KWN_wordbag);
my(%store_FindReference_focus_MR);
my(%store_FindReference_focus_MR_reclassifications);
my(%store_FindReference_focus_MR_wordbag);
my(%store_FindReference_focus_MR_wordbag_reclassifications);
my(%synfile_hash);
my(%synonym_corrected_hash);
my(%temp_merge_noun_verb_alias_hash);
my(%temp_total_truth_hash);
my(%test_hash);
my(%top_skip_hash);
my(%total_auto_cats_assigned_hash);
my(%training_items_hash);
my(%training_ssm_items_hash);
my(%trans_hash);
my(%truth_knowncats_hash);
my(%unknown_nl_types_hash);
my(%valid_restricted_end_hash);
my(%valid_restricted_general_hash);
my(%varname_hash);
my(%wordbag_keyword_2_filtered_utt_hash);
my(%wordlist_already_hash);
my(%wordnet_2_letter_words);
my(%wordnet_args);
my(%wordnet_false_frequency_hash);
my(%wordnet_min_hash);
my(@all_gram_elems);
my(@all_gram_elems_array);
my(@all_gram_elems_nuance_class_full_xml_array);
my(@all_gram_elems_nuance_speakfreely);
my(@all_gram_elems_nuance_speakfreely_array);
my(@ambig_markers_array);
my(@array_elems);
my(@auto_ordered_array);
my(@auto_ordered_catdef_array);
my(@auto_ordered_minus_max_array);
my(@char_omit_array);
my(@command_entered_array);
my(@compressed_alias_sentence_array);
my(@compressed_sentence_array);
my(@conditional_replace_array);
my(@correct_spelling_list);
my(@corrected_array);
my(@delete_char_array);
my(@do_temp_array);
my(@exclude_nums_array);
my(@exclude_words_array);
my(@expand_grammar_array);
my(@file_list);
my(@focus_item_id_array);
my(@grammar_array);
my(@grammar_gen_array);
my(@input_catdef_array);
my(@nl_key_array);
my(@nl_overall_array);
my(@nl_rules_array);
my(@nl_sub_types_array);
my(@omit_array);
my(@original_cat_array);
my(@original_transcription_array);
my(@original_wavfile_array);
my(@parsefile_array);
my(@product_prefix_array);
my(@replacement_array);
my(@rest);
my(@search_array);
my(@sentence_entered_array);
my(@skip_array);
my(@syn_wordfreq_array);
my(@synonym_modified_corrected_array);
my(@temp_cat_array);
my(@temp_cat_array_uniq);
my(@training_contents_array);
my(@training_fragment_items_array) = ();
my(@training_stem_items_array) = ();
my(@training_stop_items_array) = ();
my(@unique_array);

my($default_merge_real) = "$repository\/slmdirect_merge_real";
my($default_merge_shallow) = "$repository\/slmdirect_merge_shallow";
my($default_merge_nouns) = "$repository\/slmdirect_merge_nouns";
my($default_merge_verbs) = "$repository\/slmdirect_merge_verbs";

if ($webSwitch) {
  $nl_control = "slmdirect_nlrc";
  $do_addallrules = 0;
  $do_addmainrules_only = 0;
  $main_language = "en-us";
  $target_language = "en-us";
  $grammar_type = "NUANCE9";
  $perl_path = "/usr/bin";
  $version = "";
  $do_shallow_parse_real_corpus = 0;
  $do_use_product_prefix = 0;
  $do_use_rule_multiplier = 0;
  $taggedcorpusfile = "slmdirect_results\/createslm_tagged_corpus";
  $do_flatfile_transcriptions = 1;
  $grammarbase = "SLMDIRECT_TESTGRAMMAR";
  $vocabfile = "slmdirect_results\/createslm_vocab_uniq.sorted";
  $failparsefile = "createslm_fail.txt";
  $statsfile = "none";
  $use_only_alphanumeric_mods = 0;
  $swisrsdk_location = $swisrsdk_location_nuance9;
  $merge_shallow = $default_merge_shallow;
  $merge_real = $default_merge_real;
  $merge_nouns = $default_merge_nouns;
  $merge_verbs = $default_merge_verbs;
} else {
#
############################################################################
#### Environment Variables
############################################################################
#

  if (not defined $ENV{SLMDIRECT_NLRULES}) {
	$nl_control = "slmdirect_nlrc";
  } else {
	$nl_control = $ENV{SLMDIRECT_NLRULES};
  }

  if (not defined $ENV{SLMDIRECT_ADDALLRULES}) {
	$do_addallrules = 0;
  } else {
	$do_addallrules = 1;
  }

  if (not defined $ENV{SLMDIRECT_ADDMAINRULES_ONLY}) {
	$do_addmainrules_only = 0;
  } else {
	$do_addmainrules_only = 1;
  }

  if (not defined $ENV{SLMDIRECT_LANGUAGE}) {
	$main_language = "en-us";
  } else {
	$main_language = $ENV{SLMDIRECT_LANGUAGE};
  }

  if (not defined $ENV{SLMDIRECT_TARGET_LANGUAGE}) {
	$target_language = "en-us";
  } else {
	$target_language = $ENV{SLMDIRECT_TARGET_LANGUAGE};
  }

  if (not defined $ENV{SLMDIRECT_GRAMMAR_TYPE}) {
	$grammar_type = "NUANCE9";
  } else {
	$grammar_type = $ENV{SLMDIRECT_GRAMMAR_TYPE};
  }

  if (not defined $ENV{SLMDIRECT_PERL_PATH}) {
	$perl_path = "c:/cygwin/bin";
  } else {
	$perl_path = $ENV{SLMDIRECT_PERL_PATH};
  }

  if (not defined $ENV{SLMDIRECT_VERSION}) {
	$version = "";
  } else {
	$version = $ENV{SLMDIRECT_VERSION};
  }

  if (not defined $ENV{SLMDIRECT_SHALLOW_PARSE_REAL_CORPUS}) {
	$do_shallow_parse_real_corpus = 0;
  } else {
	$do_shallow_parse_real_corpus = 1;
  }

  if (not defined $ENV{SLMDIRECT_USE_PRODUCT_PREFIX}) {
	$do_use_product_prefix = 0;
  } else {
	$do_use_product_prefix = 1;
  }

  if (not defined $ENV{SLMDIRECT_USE_RULE_MULTIPLIER}) {
	$do_use_rule_multiplier = 0;
  } else {
	$do_use_rule_multiplier = 1;
  }

  if (not defined $ENV{SLMDIRECT_TAGGEDCORPUS}) {
	$taggedcorpusfile = "slmdirect_results\/createslm_tagged_corpus";
  } else {
	$taggedcorpusfile = $ENV{SLMDIRECT_TAGGEDCORPUS};
  }

  if (not defined $ENV{SLMDIRECT_USE_TRADITIONAL_TRANSCRIPTIONS}) {
	$do_flatfile_transcriptions = 1;
  } else {
	$do_flatfile_transcriptions = 0;
  }

  if (not defined $ENV{SLMDIRECT_GRAMMARBASENAME}) {
	$grammarbase = "SLMDIRECT_TESTGRAMMAR";
  } else {
	$grammarbase = $ENV{SLMDIRECT_GRAMMARBASENAME};
  }

  if (not defined $ENV{SLMDIRECT_VOCAB}) {
	$vocabfile = "slmdirect_results\/createslm_vocab_uniq.sorted";
  } else {
	$vocabfile = $ENV{SLMDIRECT_VOCAB};
  }

  if (not defined $ENV{SLMDIRECT_FAIL}) {
	$failparsefile = "createslm_fail.txt";
  } else {
	$failparsefile = $ENV{SLMDIRECT_FAIL};
  }

  if (not defined $ENV{SLMDIRECT_STATS}) {
	$statsfile = "none";
  } else {
	$statsfile = $ENV{SLMDIRECT_STATS};
  }

  if (defined $ENV{SLMDIRECT_ALLOWALPHAONLYMODS}) {
	$use_only_alphanumeric_mods = 0;
  }

  if (defined $ENV{SLMDIRECT_CREATEDYNAGRAM}) {
	$make_moddynagram = 1;
  }

  if (defined $ENV{SLMDIRECT_DOWNCASE_UTT}) {
	$downcase_utt = 1;
  }

  if (defined $ENV{SLMDIRECT_FILTER_CORPUS}) {
	$filter_corpus = 1;
  }

  if (defined $ENV{SLMDIRECT_FILTER_CORPUS_ONLY}) {
	$filter_corpus_only = 1;
  }

  if (defined $ENV{SLMDIRECT_TESTPARSELINE}) {
	$do_testparseline = 1;
  }

  if (defined $ENV{SLMDIRECT_USEONLYMODSINFILE}) {
	$use_only_mods_in_file = 1;
  }

  if (defined $ENV{SLMDIRECT_TESTPARSEFILEOUT}) {
	$testparsefileout = $ENV{SLMDIRECT_TESTPARSEFILEOUT};
	$do_testparsefile = 1;
  }

  if (defined $ENV{SLMDIRECT_MINFREQ}) {
	$min_freq = $ENV{SLMDIRECT_MINFREQ};
  }

  if (defined $ENV{SLMDIRECT_RUNBATS}) {
	$runbats = 1;
  }

  $swisrsdk_location = $swisrsdk_location_nuance9;
  if (defined $ENV{SWISRSDK}) {
	$swisrsdk_location = $ENV{SWISRSDK};
  }

  if (not defined $ENV{SLMDIRECT_MERGE_SHALLOW}) {
	$merge_shallow = $default_merge_shallow;
  } else {
	$merge_shallow = $ENV{SLMDIRECT_MERGE_SHALLOW};
  }

  if (not defined $ENV{SLMDIRECT_MERGE_REAL}) {
	$merge_real = $default_merge_real;
  } else {
	$merge_real = $ENV{SLMDIRECT_MERGE_REAL};
  }

  if (not defined $ENV{SLMDIRECT_MERGE_NOUNS}) {
	$merge_nouns = $default_merge_nouns;
  } else {
	$merge_nouns = $ENV{SLMDIRECT_MERGE_NOUNS};
  }

  if (not defined $ENV{SLMDIRECT_MERGE_VERBS}) {
	$merge_verbs = $default_merge_verbs;
  } else {
	$merge_verbs = $ENV{SLMDIRECT_MERGE_VERBS};
  }
}
############################################################################
# Default command line variables. If you change these, be sure to update the
# usage text.
############################################################################
#
%cmdopt = (
	AddTest => "$addtestfile",
	AppendTest => "$appendtestfile",
	Fail => "$failparsefile",
	GrammarBasename => "$grammarbase",
	GrammarType => "$grammar_type",
	KnownCatsFile => "$knowncatsfile_change",
    Language => "$main_language",
	MergeReal => "$merge_real",
	MergeShallow => "$merge_shallow",
	MergeNouns => "$merge_nouns",
	MergeVerbs => "$merge_verbs",
	MinFrequency => "$min_freq",
    Rules => "$nl_control",
	ReclassFile => "$reclassfile_in",
	Repository => "$repository",
	RunBats => "$runbats",
	Stats => "$statsfile",
	TaggedCorpus => "$taggedcorpusfile",
    TargetLanguage => "$target_language",
	TestCreate => "$test_sequence",
    TuningVersion => "$tuning_version",
    Version => "$version",
	Vocab => "$vocabfile",

);

foreach $elem ( sort { $a cmp $b } keys %cmdopt) {
	$defaultcmdopt{$elem} = $cmdopt{$elem};
}

############################################################################
# Parse the command line for switches
############################################################################
#
my($result) = GetOptions(\%cmdopt, "AddAllRules", "AddMainRulesOnly", "AddTest=s", "AppendTest=s", "ApplyTags=s", "AutoTag=s", "BaseCats=s", "CalledFromGUI", "CheckCats=s", "CleanOnly", "Clear", "CreateRulesFrom=s", "CreateRegExp", "DoTagging=s", "DontCheckRules", "DontClean", "DontDoAdditionalCommandVars", "DontDowncaseUtt", "DontIncludeGarbageReject", "DontRemoveRepeats", "DowncaseUtt", "Fail=s", "GenReferenceTags=s", "GrammarBasename=s", "GrammarType=s", "Help=s", "IncludeGarbageReject", "IndentXML=s", "KeepFragments", "KnownCatsFile=s", "Language=s", "MergeNouns=s", "MergeReal=s", "MergeShallow=s", "MergeVerbs=s", "MinFrequency=s", "NO_TAG_UNKNOWN", "PutDefaults", "ReadInitCats=s", "ReadNewCats=s", "Recall", "ReclassFile=s", "ReducedCorpus=s", "ReferenceTags=s", "RemoveRepeats", "Repository=s", "Rules=s", "RulesDirect=s", "RunBats", "SetTask=s", "SplitTrainTest=s", "Stats=s", "SuppressGrammar", "Synonyms=s", "TagAssist", "TagDefinitions=s", "TagRestore=s", "TaggedCorpus=s", "TagsDirect=s", "TagsDirSplit=s", "TargetLanguage=s", "TemplateTransformFile=s", "TestCreate=s", "TestParseFileOut=s", "TestRulesFrom=s", "TestSentence", "TestSentenceAmplify", "Translate=s", "TuningVersion=s", "UseOrigTranscriptions", "UsePreviousTest", "UseSentencePrefix", "UseTraditionalTranscriptions", "VerifyRules", "Version=s", "Vocab=s", "WithRetag", "WriteDataFiles");

###########################################################
# Gather command line options
###########################################################

$command_line_options = "";
foreach $elem ( sort { $a cmp $b } keys %cmdopt) {
	if ($cmdopt{$elem} ne "") {
		if (defined $defaultcmdopt{$elem}) {
			if ($cmdopt{$elem} ne $defaultcmdopt{$elem}) {
			  $command_line_options = stringBuilder($command_line_options, "-$elem ".$cmdopt{$elem}, " ");
			}
		} else {
			if ($cmdopt{$elem} eq "1") {
			  $command_line_options = stringBuilder($command_line_options, "-$elem", " ");
			} else {
			  $command_line_options = stringBuilder($command_line_options, "-$elem ".$cmdopt{$elem}, " ");
			}
		}
	}
}

if ($ARGV[0] ne "") {
  $command_line_options = stringBuilder($command_line_options, $ARGV[0], " ");
}

my($parsefile) =  $ARGV[0];

###########################################################
################## INDEPENDENT STANDALONE OPTIONS #########
###########################################################

if ($cmdopt{Clear}) {
	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_backup_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_backup_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_backup_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_applytags_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_applytags_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_applytags_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_wordnet_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_wordnet_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_wordnet_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_info_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_info_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_info_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_important_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_important_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_important_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_analyze_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_analyze_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_analyze_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_temp_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_temp_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_temp_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_truth_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_truth_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_truth_files";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/docs")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/docs\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/docs";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/grammars")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/grammars\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/grammars";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/scripts")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/scripts\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/scripts";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/tools")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/tools\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/tools";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/transcriptions")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/transcriptions\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/transcriptions";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/data")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/data\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files\/data";
	}

	if (opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files")) {
		while (defined($file = readdir(INFODIR))) {
			unlink "slmdirect_results\/createslmDIR_tuning_files\/$file";
		}

		closedir("INFODIR");
		rmdir "slmdirect_results\/createslmDIR_tuning_files";
	}

	@file_list = <slmdirect_results/createslm_*>;

	unlink @file_list;

	@file_list = <slmdirect_results/CREATESLM_*>;

	unlink @file_list;

	@file_list = <slmdirect_results/slmp_compile_*>;

	unlink @file_list;

	unlink "tagging-filter.txt";

	@file_list = <createslm_*>;

	unlink @file_list;

	@file_list = <slmdirect_results/*>;

	unlink @file_list;

	if (opendir("INFODIR", "slmdirect_results")) {
	  closedir("INFODIR");
	  rmdir "slmdirect_results";
	}

	DebugPrint ("SCREEN", 1, "Main::Clear", $debug, $err_no++, "\nAll generated SLMDirect files and directories removed\n\n\n");

#	writeTask();

	exit(0);
}

if ($cmdopt{TagRestore}) {
  my($bak_file_used);

  $parsefile = $cmdopt{TagRestore};
  $bak_file_used = RestoreCorpusFile($parsefile);
  if ($bak_file_used == -1) {
	DebugPrint ("BOTH", 2, "TagRestore", $debug, $err_no++, "No backup files are available.  NOTHING TO DO!");
  } else {
	DebugPrint ("BOTH", 1, "TagRestore", $debug, $err_no++, "File $parsefile restored from backup file #".$bak_file_used);
  }

  DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "Main::CreateMainGrammar", $debug, $err_no++, "\n");
  writeTask();

  exit(0);
}

$test_sequence = $cmdopt{TestCreate};

if ($cmdopt{ReducedCorpus}) {
  GenReducedCorpus($parsefile, $test_sequence);

  writeTask();

  exit(0);
}

if ($cmdopt{IndentXML}) {
  $indentXML_file = $cmdopt{IndentXML};

  makeIndentedFile($indentXML_file);

  writeTask();

  exit(0);
}

if ($cmdopt{BaseCats}) {
  $use_basecats = $cmdopt{BaseCats};
}

################## END INDEPENDENT STANDALONE OPTIONS #####

############################################################################
# Set variables from command line options
############################################################################
#
if ($cmdopt{SetTask}) {

  ($task_no_in, $sub_task_no_in, $err_msg_no_in, $warning_msg_no_in, $num_errors_in, $num_warnings_in) = split ":", $cmdopt{SetTask};

  setTask($task_no_in, $sub_task_no_in, $err_msg_no_in, $warning_msg_no_in, $num_errors_in, $num_warnings_in, $called_from_gui);
} else {
    if (opendir("INFODIR", "slmdirect_results")) {
#	resetErrorsWarnings();
	unlink "slmdirect_results/createslmDIR_temp_files/temp_errors";
	unlink "slmdirect_results/createslmDIR_temp_files/temp_warnings";
	closedir("INFODIR");
    }
}

if ($cmdopt{NO_TAG_UNKNOWN}) {
  $do_no_tag_unknown = 1;
}

if ($cmdopt{WithRetag}) {
  $with_retag = 1;
}

if ($cmdopt{CreateRegExp}) {
    $do_create_regexp = 1;
}

$grammarbase = $cmdopt{GrammarBasename};
$shallow_parse_real_corpus_grammarfileout = $grammarbase."shallow_parse_real_corpus.grammar";
$version = $cmdopt{Version};
if ($version ne "") {
  $grammarbase = $version."_".$grammarbase;
}

$tuning_version = $cmdopt{TuningVersion};
if ($tuning_version ne "") {
  $grammarbase = "slmdirect_results\/createslmDIR_tuning_files\/grammars\/".$tuning_version."_".$grammarbase;
}

$main_language = lc($cmdopt{Language});
$main_language =~ s/\_/\-/g;
if ($main_language eq "es-us") {
  $scan_language = "esus";
  $language_suffix = "_esus";
}

if ($cmdopt{AddTest}) {
  $addtestfile = $cmdopt{AddTest};
  if ((lc($addtestfile) =~ /:precisionrecall\b/) || (lc($addtestfile) =~ /:pr\b/)) {
	$do_precision_recall = 1;
  }

  ($addtestfile, @rest) = split ":", $addtestfile;
}


$appendtestfile = $cmdopt{AppendTest};
$do_verify_rules = $cmdopt{VerifyRules};
$failparsefile = $cmdopt{Fail};
$filtercorpusfileout = "slmdirect_results\/createslm_amplify_out";

if ($cmdopt{CalledFromGUI}) {
  $called_from_gui = 1;
}

if ($cmdopt{PutDefaults}) {
  $do_put_defaults = 1;
}

$grammar_type = $cmdopt{GrammarType};
if (lc($grammar_type) =~ /nuance9/) {
	$do_normal_slm_nuance9 = 1;
	if ((lc($grammar_type) =~ /:robust\b/) || (lc($grammar_type) =~ /:r\b/)) {
		$do_robust_parsing_nuance9 = 1;
		$do_normal_slm_nuance9 = 0;
	}

	if ((lc($grammar_type) =~ /:slm\b/) || (lc($grammar_type) =~ /:s\b/)) {
		$do_normal_slm_nuance9 = 1;
	}

	$grammar_type = "NUANCE9";
}

if (lc($grammar_type) =~ /nuance_speakfreely/) {
	$do_normal_slm_speakfreely = 1;
	if ((lc($grammar_type) =~ /:robust\b/) || (lc($grammar_type) =~ /:r\b/)) {
		$do_robust_parsing_speakfreely = 1;
		$do_normal_slm_speakfreely = 0;
	}

	if ((lc($grammar_type) =~ /:slm\b/) || (lc($grammar_type) =~ /:s\b/)) {
		$do_normal_slm_speakfreely = 1;
	}

	$grammar_type = "NUANCE_SPEAKFREELY";
}

if (lc($grammar_type) eq "nuance_gsl") {
	$do_include_garbagereject = 0;
	if ($cmdopt{IncludeGarbageReject}) {
		$do_include_garbagereject = 1;
	}
} elsif (lc($grammar_type) eq "nuance_speakfreely") {
	$do_include_garbagereject = 1;
	if ($cmdopt{DontIncludeGarbageReject}) {
		$do_include_garbagereject = 0;
	}
} elsif (lc($grammar_type) eq "nuance9") {
	$do_include_garbagereject = 1;
	if ($cmdopt{DontIncludeGarbageReject}) {
		$do_include_garbagereject = 0;
	}
}

$repository = $cmdopt{Repository};

my($cat_nl_rules) = "$repository\/slmdirect_results\/createslm_init_nlrules";
my($nlrc_template_name) = "$repository\/slmdirect_template_nlrc";
my($knowncatsfile) = "$repository\/slmdirect_results\/createslmDIR_important_files\/info_known_cats";
my($reclassfile) = "$repository\/slmdirect_results\/createslmDIR_important_files\/info_reclass_file";

$merge_nouns = $cmdopt{MergeNouns};
$merge_real = $cmdopt{MergeReal};
$merge_shallow = $cmdopt{MergeShallow};
$merge_verbs = $cmdopt{MergeVerbs};
$min_freq = $cmdopt{MinFrequency};

if ((substr($cmdopt{Rules}, 0, 1) eq ".") && ((substr($cmdopt{Rules}, 1, 1) eq "/") || (substr($cmdopt{Rules}, 1, 1) eq "\/"))) {
  $nl_control = $cmdopt{Rules};
} elsif ((substr($cmdopt{Rules}, 0, 1) eq ".") && ((substr($cmdopt{Rules}, 1, 1) ne "/") && (substr($cmdopt{Rules}, 1, 1) ne "\/"))) {
  $nl_control = substr($cmdopt{Rules}, 1);
  $nl_control = "$repository\/".$nl_control;
} else {
  $nl_control = "$repository\/".$cmdopt{Rules};
}

$reclassfile_in = $cmdopt{ReclassFile};
$referencetagfile = $cmdopt{ReferenceTags};
$gen_referencetagfile = $cmdopt{GenReferenceTags};
$statsfile = $cmdopt{Stats};
$taggedcorpusfile = $cmdopt{TaggedCorpus};
$target_language = $cmdopt{TargetLanguage};
$vocabfile = $cmdopt{Vocab};

$autotag_option = $cmdopt{AutoTag};
$synonym_option = $cmdopt{Synonyms};

if ($cmdopt{SuppressGrammar}) {
	$do_suppress_grammar = 1;
}

if ($cmdopt{AddAllRules}) {
	$do_addallrules = 1;
}

if ($cmdopt{AddMainRulesOnly}) {
	$do_addmainrules_only = 1;
}

if ($cmdopt{DoTagging}) {
	$do_tagging = $cmdopt{DoTagging};
}

if ($cmdopt{DontClean}) {
	$dont_clean = 1;
}

if ($cmdopt{CleanOnly}) {
	$clean_only = 1;
	$dont_clean = 0;
}

if ($cmdopt{UseTraditionalTranscriptions}) {
	$do_flatfile_transcriptions = 0;
	$use_trad_trans = 1;
}

if ($cmdopt{UseOrigTranscriptions}) {
	$use_orig_trans = 1;
}

if ($cmdopt{WriteDataFiles}) {
	$do_write_data_files = 1;
}

if ($cmdopt{CreateRulesFrom}) {
	$container_file_in = $cmdopt{CreateRulesFrom};
	$do_make_nlrule_init = 1;
}

if ($cmdopt{TestRulesFrom}) {
	$container_file_in = $cmdopt{TestRulesFrom};
	$do_make_nlrule_init = 1;
	$do_make_nlrule_init_test = 1;
}

if ($cmdopt{DowncaseUtt}) {
	$downcase_utt = 1;
}

if ($cmdopt{DontRemoveRepeats}) {
	$removerepeats = 0;
}

if ($cmdopt{ApplyTags}) {

	$classifyfileout = $cmdopt{ApplyTags};
	($classifyfileout, $reclassification_file) = split ":", $classifyfileout;

	if ($reclassification_file ne "") {
		$use_reclassifications = 1;
	} elsif (-e $reclassfile) {
		$reclassification_file = $reclassfile;
		$use_reclassifications = 1;
	}

	$do_classify = 1;

	if (!opendir("INFODIR", "slmdirect_results")) {
	  mkdir "slmdirect_results", 0777;
	} else {
	  closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_applytags_files")) {
		mkdir "slmdirect_results\/createslmDIR_applytags_files", 0777;
	} else {
		closedir("INFODIR");
	}
}

if ($cmdopt{RulesDirect}) {
  $parsefile = $cmdopt{RulesDirect};
  if ((lc($parsefile) =~ /:amplify\b/) || (lc($parsefile) =~ /:a\b/)) {
	$filter_corpus = 1;
	$do_use_rule_multiplier = 1;
  }

  ($parsefile, @rest) = split ":", $parsefile;
  ($parsefile, $container_file_in) = split ",", $parsefile;

  if ($container_file_in eq "") {
	$container_file_in = "$repository\/slmdirect_results\/createslm_init_rules_container"."$language_suffix";
  } else {
	CALL_SLMDirect(0, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, $container_file_in, $nlrc_template_name, "", $downcase_utt, $removerepeats, "", "", $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", "");
  }
}

if ($cmdopt{UsePreviousTest}) {
	$use_previous_test_sequence = 1;
}

if ($cmdopt{SplitTrainTest}) {
  my(@temp_split_array) = split ":", $cmdopt{SplitTrainTest};

  $cat_file_init = shift @temp_split_array;
  $do_split_train_test = join ":", @temp_split_array;
  $do_split_train_test = $do_split_train_test.":".$use_previous_test_sequence;
}

if (($cmdopt{TagsDirect}) || ($cmdopt{TagsDirSplit})) {
  if ($cat_file_init eq "") {
	$do_read_catlist = 1;
	$do_make_nlrule_init = 1;
	$do_tagsdirect = 1;

	if ($cmdopt{TagsDirect}) {
	  $cat_file_init = $cmdopt{TagsDirect};
	}

	if ($cmdopt{TagsDirSplit}) {
	  $cat_file_init = $cmdopt{TagsDirSplit};
	  $do_split_train_test = "";
	}

	if ((lc($cat_file_init) =~ /:amplify\b/) || (lc($cat_file_init) =~ /:a\b/)) {
	  $do_filtercorpus_direct = 1;
	  $do_use_rule_multiplier = 1;
	}

	($cat_file_init, @rest) = split ":", $cat_file_init;
	($cat_file_init, $container_file_in) = split ",", $cat_file_init;
  }

  if ($container_file_in eq "") {
	$container_file_in = "$repository\/slmdirect_results\/createslm_init_rules_container"."$language_suffix";
  } else {
	CALL_SLMDirect(0, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, $container_file_in, $nlrc_template_name, "", $downcase_utt, $removerepeats, "", "", $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", "");
  }
}

if (defined $cmdopt{KeepFragments}) {
	$keep_fragment_length = $cmdopt{KeepFragments};
#	$keep_fragment_length = 5;
}

if ($cmdopt{TagAssist}) {
	$do_retag = 1;
}

if ($autotag_option ne "") {
	$do_autotag = 1;

	if (lc($autotag_option) eq "none") {
	  $wordnet_available = 0;
	}
}

if ($synonym_option ne "") {
	$do_synonyms = 1;
}

if (($merge_real ne $default_merge_real) && ($merge_real =~ /:/)) {
	my(@merge_real_array);
	my($mergefile);

	unlink "slmdirect_results\/createslmDIR_temp_files\/temp_merge_real";
	open(TEMPMERGE,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_merge_real") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_merge_real";
	(@merge_real_array) = split ":", $merge_real;
	foreach $mergefile (@merge_real_array) {
		open(MERGE,"<$mergefile") or die "cant open $mergefile";
		while(<MERGE>) {
			print TEMPMERGE "$_";
		}

		close(MERGE);
	}

	close(TEMPMERGE);

	$merge_real = "slmdirect_results\/createslmDIR_temp_files\/temp_merge_real";
}

if (($merge_shallow ne $default_merge_shallow) && ($merge_shallow =~ /:/)) {
	my(@merge_shallow_array);
	my($mergefile);

	unlink "slmdirect_results\/createslmDIR_temp_files\/temp_merge_shallow";
	open(TEMPMERGE,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_merge_shallow") or die "cant open "."slmdirect_results\/createslmDIR_temp_files\/temp_merge_shallow";
	(@merge_shallow_array) = split ":", $merge_shallow;
	foreach $mergefile (@merge_shallow_array) {
		open(MERGE,"<$mergefile") or die "cant open $mergefile";
		while(<MERGE>) {
			print TEMPMERGE "$_";
		}

		close(MERGE);
	}

	close(TEMPMERGE);

	$merge_shallow = "slmdirect_results\/createslmDIR_temp_files\/temp_merge_shallow";
}

if ($cmdopt{RunBats}) {
	$runbats = 1;
}

if ($cmdopt{CheckCats}) {
	$checkcats_files = $cmdopt{CheckCats};
	$do_checkcats = 1;
}

if ($cmdopt{TagDefinitions}) {
	$catdef_file = $cmdopt{TagDefinitions};

	open(CATDEFFILE,"<$catdef_file") or die "cant open $catdef_file";
	while (<CATDEFFILE>) {
		$elem = ChopChar($_);
		if ($elem eq "") {
			next;
		}

		if (substr($elem,0,1) eq "#") {
			next;
		}

		($autocat, $words) = split "\t", $elem;

		push @input_catdef_array, "$autocatº$words";
	}

	@auto_ordered_catdef_array = 
		map  {$_->[1]}
		sort { $b->[0] <=> $a->[0] }
	    map  {[catdefOrder($_), $_]}
	    @input_catdef_array;
}

if ($cmdopt{ReadInitCats}) {
	$cat_file_init = $cmdopt{ReadInitCats};
	$do_read_catlist = 1;
}

if ($cmdopt{ReadNewCats}) {
	$old_rules_file = $cmdopt{ReadNewCats};
	$do_read_newcats = 1;
}

if ($cmdopt{Translate}) {
	$transcat_file = $cmdopt{Translate};
	$do_transcat = 1;
}

if ($cmdopt{UseSentencePrefix}) { 
	$do_use_product_prefix = 1;
}

if ($cmdopt{DontCheckRules}) {
	$dont_check_nlrules = 1;
}

if ($cmdopt{DontDoAdditionalCommandVars}) {
	$dont_do_additional_command_vars = 1;
}

if (defined $cmdopt{TestSentence}) {
	$do_testsentence = 1;

	if ($webSwitch) {
	  my($wcnt) = 0;

	  $parsefile = "";
	  while ($ARGV[$wcnt] ne "") {
		$parsefile = stringBuilder($parsefile, $ARGV[$wcnt], " ");
		$wcnt++;
	  }

	  if ($parsefile eq "") {
	    DebugPrint ("BOTH", 2, "Main::TestSentence", $debug, $err_no++, "No sentence entered\n");
		exit(0);
	  }

	  DebugPrint ("BOTH", 2, "Main::TestSentence", $debug, $err_no++, "Sentence: $parsefile\n\n");

	}
}

if (defined $cmdopt{TestSentenceAmplify}) {
	$do_filtertestline = 1;
}

if (defined $cmdopt{TestParseFileOut}) {
	$testparsefileout = $cmdopt{TestParseFileOut};
	$do_testparsefile = 1;
}

############################################################################
# If Help print out help summary information
############################################################################
#
if ($cmdopt{Help}) {
	my(@help_array) = ();
	my(%help_hash);
	my($helpline);
	my($helpmsg);

	$help_hash{"addtest"} = "AddTest: This option (for XML grammars only) specifies the name of the file containing test sentences and their assigned categories.  The format of the input file is: category<tab>sentence.  These sentences are written directly into the <test> element of the training file.  If the :precisionrecall (:pr) option is specified, then precision and recall for the input categories is calculated and and the results placed in the file "."slmdirect_results\/createslmDIR_analyze_files/analyze_precision_recall";
	$help_hash{"all"} = "";
	$help_hash{"applytags"} = "ApplyTags: This option classifies sentences in the input file and outputs the classifications into a file called '"."slmdirect_results\/createslm_new_classifications'.";
	$help_hash{"autotag"} = "AutoTag: This option scans through a list of unclassified sentences in the input file and uses WordNet to generate synonyms to help group the sentences automatically.  The three sub-options are \"strict\" which limits the available synonyms, \"loose\" which include hyponyms and hypernyms and \"none\" which disables WordNet and classifies sentences solely on existing keywords. The recommended procedure is to 1) make an initial run to determine keywords, 2) add aliases to the slmdirect_template_nlrc file, and then 3) repeat steps 1 and 2 as many times as it takes to adequately classify the sentences.  The temporary classifications can then be replaced with the actual category names of the particular application.";
	$help_hash{"checkcats"} = "CheckCats: This option takes the English Rules Container file and another language, e.g., Spanish Rules Container file as input, checking to see if the categories of equivalent sentences match up.  Appropriate errors are displayed, if not.";
	$help_hash{"createregexp"} = "CreateRegExp: This option generates a file containing \'regular expressions\' that cover each valid sentence in the input file.  These expressions can be used for disambiguation after the recognition step.";
	$help_hash{"dontcheckrules"} = "DontCheckRules: This option disables the checking of the input Rules.  The default is to check the rules.";
	$help_hash{"dontremoverepeats"} = "DontRemoveRepeats: This option disables the default of taking out all repeated words and phrases from the input corpus so that a clean corpus can generate clean rules.";
	$help_hash{"downcaseutt"} = "DowncaseUtt: Downcasing is done when  the input corpus contains unnecessarily capitalized letters or words.  This option enables the downcasing of the transcription before parsing, if, e.g., the input corpus contains capital letters of say, a model number.  The default is not to downcase.";
	$help_hash{"fail"} = "Fail: An output file containing all records in the <input file> that failed to match a parsing rule in the 'Rules file'.  This information can then be used to amend the parsing rules.  The default filename is "."slmdirect_results\/createslm_fail.";
	$help_hash{"reducedcorpus"} = "ReducedCorpus: This option specifies the type of sequence for a reduced set of sentences to be used for test purposes, of which the default is \'original_order\'.  The other value is \'random\'.  One option modifier is available, <sentence num> (default 5000) which determines the number of sentences in the output file.";
	$help_hash{"genreferencetags"} = "GenReferenceTags: This option specifies the file in which to output all assigned tags.  This file can then be edited appropriately and used as input to the -ReferenceTags option.";
	$help_hash{"grammarbasename"} = "GrammarBasename: This option will name all output grammar files with the base name specified.  The default is 'CREATESLM_TESTGRAMMAR'.";
	$help_hash{"grammartype"} = "GrammarType: This option will set the type of the output grammar files.  Allowable values are: NUANCE_GSL, NUANCE_SPEAKFREELY, NUANCE9.  NUANCE_SPEAKFREELY and NUANCE9 can be further modified with \':r[obust]\' is a robust grammar should be generated.  The default is 'NUANCE9'.";
	$help_hash{"indentxml"} = "IndentXML: This option indents the input XML file in a readable manner.  No syntax checking is performed and ill-formed XML files will NOT complete the indent process successfully.  The output file is named for the input file plus an .indented suffix.";
	$help_hash{"keepfragments"} = "KeepFragments: This option checks any fragment (words transcribed with a '-') longer than 5 characters and checks if they are a known word.  If so, they are kept and used as keywords.";
	$help_hash{"language"} = "Language: This option sets the language in all the relevant grammars.  The default is 'en-us'.";
	$help_hash{"mergenouns"} = "MergeNouns: This option specifies the name of the file containing noun sentences to be merged with the corpus used by TagsDirect.  Sentence prefixes are provided by the MNP and MNVA Command Variables.";
	$help_hash{"mergereal"} = "MergeReal: This option specifies the name of the file containing real data sentences to be merged with the pseudo_corpus created by FilterCorpus.  The default file name is slmdirect_merge_real.  The input file name can contain multiple file names, separated by a \":\". ";
	$help_hash{"mergeshallow"} = "MergeShallow: This option specifies the name of the file containing sentences to be merged with the pseudo_corpus created by FilterCorpus.  The default file name is slmdirect_merge_shallow.  The input file name can contain multiple file names, separated by a \":\".";
	$help_hash{"mergeverbs"} = "MergeVerbs: This option specifies the name of the file containing verb sentences to be merged with the corpus used by TagsDirect.  Sentence prefixes are provided by the MVP and MNVA Command Variables.";
	$help_hash{"minfrequency"} = "MinFrequency: This option specifies the minimum frequency that a category element must have to be included in the grammar for that category.  The default is 1.";
	$help_hash{"rules"} = "Rules: A file containing 'parsing rules' for interpreting references with the sentence corpus, as well as processing directives governing overall parsing behavior.  The default filename is slmdirect_nlrc. See the example_slmdirect_nlrc file for details.";
	$help_hash{"rulesdirect"} = "RulesDirect: This option takes a file as input containing a list of untagged caller responses in association with the rules specified with the Rules option, creating a full set of grammar files.  The :amplify option appends noun phrases and verb phrases automatically constructed from sentences in the input list to the output grammar files.  The output grammar file is named <GrammarBasename>_corpus_direct.grammar. Processing continues to produce other grammar files according to selected options.";
	$help_hash{"splittraintest"} = "SplitTrainTest: This option will take the input file and split it into a training set and a test set, based on specified percentages.";
	$help_hash{"stats"} = "Stats: *** Not currently implemented  ***.  This option will print out various statistics resulting from the parsing process.";
	$help_hash{"synonyms"} = "Synonyms: This option scans through the words in the input file and uses WordNet to choose synonyms to create additional sentences.  The two sub-options are \"strict\" which limits the available synonyms and \"loose\" which include hyponyms and hypernyms. Sentences are automatically added to the corpus or else displayed if used with the TestParseline option.";
	$help_hash{"tagassist"} = "TagAssist: This option reads in a file containing a list of newly categorized sentences and tags any currently-untagged sentences according to existing tagged sentences and rules.  This allows representative sentences to be tagged which are then used to tag similar sentences. After each run, a backup file is placed in "."slmdirect_results\/createslmDIR_backup_files.";
	$help_hash{"tagrestore"} = "TagRestore: This option restores the most recently backed up sentence file from the TagAssist option.  Using this option multiple times restores the corpus file until there are no more backup files left.";
	$help_hash{"taggedcorpus"} = "TaggedCorpus: An output file containing the training text for the SLM, with all appropriate tokens replaced with a 'grammar class designator', e.g., ModelNumber, if specified.  This file is then used as input to the slm-train.bat script. The default filename is "."slmdirect_results\/createslm_tagged_corpus.";
	$help_hash{"tagsdirect"} = "TagsDirect: This option takes a file as input containing a list of tagged caller responses, creating a full set of grammar files.  The :amplify option appends noun phrases and verb phrases automatically constructed from sentences in the input list to the output grammar files.";
	$help_hash{"testcreate"} = "TestCreate: This option specifies the type of test sequence of which the default is \'random\'.  Other values are \'fileorder\', \'reversefileorder\' and \'none\'.  Two option modifiers are available, <test percent> (default 10) and <blank test percent> (default 3).  <test percent> is the percentage of the input data used as a test set.  <blank test percent> is the percentage of the test data allowed to be \'blank\' wav files, that is, either no speech or noise-only.";
	$help_hash{"testsentence"} = "TestSentence: This option allows the entry of test sentences in order to test parsing Rules.";
	$help_hash{"testsentenceamplify"} = "TestSentenceAmplify: This option parses an input line and categorizes it as a noun phrase or a verb phrase according to the current rule set.";
	$help_hash{"translate"} = "Translate: This option translates the slmdirect_results\/createslm_init_sentences and slmdirxect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment files based on the presence of a file (e.g., trans_file_es-us) containing each sentence in the "."slmdirect_results\/createslm_init_sentences file and its translation.  -Language <language> must be specified.";
	$help_hash{"useprevioustest"} = "UsePreviousTest: This option causes the ApplyTags option to refrain from generating a new random Test and instead use the previous generated Test stored in "."slmdirect_results\/createslmDIR_info_files\/info_truth_sequence.  If no previous Test exists, then a new random Test will be generated.";
	$help_hash{"usesentenceprefix"} = "UseSentencePrefix: This option tells the grammar generator to combine the prefixes in the list defined by the PX run control variable with any grammar items defined in the parsing rules, MR, BR, GR, ER or AR, and append the resulting sentences to the tagged corpus.";
	$help_hash{"verifyrules"} = "VerifyRules: This option compares the categories assigned by the specified Rules Container file with the categories assigned manually.  Active for the :amplify option of TagsDirect, if a Rules Container file is also specified.";
	$help_hash{"vocab"} = "Vocab: An output file containing all unique words found in the <input file>.  Due to the nature of real-world text, this file may well contain 'junk' and must therefore be manually edited and re-named to 'vocab_uniq.sorted.current' to be used as input to the slm-train.bat script. The default filename is "."slmdirect_results\/createslm_vocab_uniq.sorted.";

	(@help_array) = split ",", $cmdopt{Help};

    $helpmsg = "\n";
	foreach (@help_array) {
		$helpline = lc($_);

		if (defined $help_hash{$helpline}) {
		  if ($helpline eq "all") {
			foreach $elem ( sort { $a cmp $b } keys %help_hash) {
			  if ($elem ne "all") {
				$helpmsg = $helpmsg."\n".$help_hash{$elem}."\n\n----------------------------\n";
			  }
			}
		  } else {
			$helpmsg = $helpmsg."\n".$help_hash{$helpline}."\n\n----------------------------\n";
		  }
		}

	}

	if ($called_from_gui) {
	  print $helpmsg;
	} else {
	  if ($webSwitch) {
		$helpmsg =~ s/\</\&lt;/g;
	  }

	  system("echo \"$helpmsg\"|less");
	}

	if (opendir("INFODIR", "slmdirect_results")) {
	  writeTask();
	  closedir("INFODIR");
	}

    exit(0);
}

############################################################################
# Set various program options
############################################################################
#
if (!opendir("INFODIR", "slmdirect_results")) {
  mkdir "slmdirect_results", 0777;
} else {
  closedir("INFODIR");
}

$infile = "PARSE";
if ($do_testsentence || $do_filtertestline) {
	$infile = "STDIN";
}

if (((defined $parsefile) || $do_tagsdirect) && !($do_restore || $do_retag || $do_testsentence || $do_filtertestline || $do_testparsefile || $do_classify) && ($appendtestfile eq "")) {
	$make_maingrammar = 1;
}

if ($do_testsentence || $do_testparsefile || $do_classify || $do_filtercorpus_direct || $do_tagsdirect || $do_split_train_test) {
	$expand_vanilla = 0;
}

if ($do_testsentence || $do_testparsefile || $do_classify || $do_filtertestline) {
	$make_maingrammar = 0;
	$make_vocab = 0;

	if ($do_classify) {
		$write_out = "CLASSIFYFILEOUT";
		$write_out_catonly = "CLASSIFYFILEOUT_READY";

		if ($classifyfileout ne "STDOUT") {

			if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_temp_files")) {
			  mkdir "slmdirect_results\/createslmDIR_temp_files", 0777;
			} else {
			  closedir("INFODIR");
			}

			close(CLASSIFYFILEOUT);
			close(CLASSIFYFILEOUT_READY);
			close(CLASSIFYFILEOUT_VANILLA);
			close(CLASSIFYFILEOUT_UNKNOWN);

			open(CLASSIFYFILEOUT,">"."slmdirect_results\/$classifyfileout") or die "cant write "."slmdirect_results\/$classifyfileout";
			open(CLASSIFYFILEOUT_READY,">"."slmdirect_results\/$classifyfileout"."_ready") or die "cant write "."slmdirect_results\/$classifyfileout"."_ready";
			open(CLASSIFYFILEOUT_VANILLA,">$classify_sentence_file") or die "cant write $classify_sentence_file";
			open(CLASSIFYFILEOUT_UNKNOWN,">$classify_unknown_sentence_file") or die "cant write $classify_unknown_sentence_file";
			$failparsefile = "slmdirect_results\/$classifyfileout";

			$make_vocab = 1;
			$vocabfile = "slmdirect_results\/createslm_applytags_vocab_uniq.sorted";
		}
	}

	if ($do_testparsefile) {
		my($temp_testparsefileout) = $testparsefileout."_category_only";
		$write_out = "TESTPARSEFILEOUT";
		$write_out_catonly = "TESTPARSEFILEOUT_CATONLY";

		if ($testparsefileout ne "STDOUT") {
			close(TESTPARSEFILEOUT);
			close(TESTPARSEFILEOUT_CATONLY);
			open(TESTPARSEFILEOUT,">"."slmdirect_results\/$testparsefileout") or die "cant write "."slmdirect_results\/$testparsefileout";
			open(TESTPARSEFILEOUT_CATONLY,">"."slmdirect_results\/$temp_testparsefileout") or die "cant write "."slmdirect_results\/$temp_testparsefileout";
			$failparsefile = $testparsefileout;
		}
	}
}

if (lc($vocabfile) ne "none") {
	if ($make_maingrammar) {
		$make_vocab = 1;
	}
}

############################################################################
# If no inputfiles, etc. print out instructions
############################################################################
#
if (($do_split_train_test eq "") && $make_maingrammar == 0 && $make_vocab == 0 && $do_testsentence == 0 && $do_testparsefile == 0 && $do_classify == 0 && $filter_corpus == 0 && $do_check_nlrules == 0  && $do_filtertestline == 0 && $do_make_nlrule_init == 0 && $do_read_catlist == 0  && $do_read_newcats == 0 && $do_transcat == 0 && $do_checkcats == 0 && ($reclassfile_in eq "") && ($do_retag == 0) && ($do_restore == 0) && ($appendtestfile eq "") && ($do_write_data_files == 0)) {
	my($outmsg);
	my($outprog) = $0;
	my(@outprog_array);

	if ($webSwitch) {
	  $outprog = "SLMDirect Web Form";
	}

	$outprog =~ s/\\/\//g;
	@outprog_array = split "/", $outprog;

	$outprog = $outprog_array[-1];

    $outmsg = "\n";
    $outmsg = $outmsg."Usage 1: $outprog [<options>] \n";
    $outmsg = $outmsg."\n\tTagsDirect Context Options:\n";
    $outmsg = $outmsg."\t\t-TagsDirect <tagged sentence file>[:a{mplify}] \n";
    $outmsg = $outmsg."\t\t-GenReferenceTags <output tag file>\n";
    $outmsg = $outmsg."\t\t-ReferenceTags <file of valid tags> \n";

    $outmsg = $outmsg."\n\tRulesDirect Context Options:\n";
    $outmsg = $outmsg."\t\t-RulesDirect <untagged sentence file>[,<rules container file>][:a{mplify}] \n";
    $outmsg = $outmsg."\t\t-AddAllRules ........................................(default: don't add any rules to grammar)\n";
    $outmsg = $outmsg."\t\t-AddMainRulesOnly ...................................(default: don't add any rules to grammar)\n";
    $outmsg = $outmsg."\t\t-Fail <output file> .................................(default: "."slmdirect_results\/createslm_fail)\n";
    $outmsg = $outmsg."\t\t-Rules <rules file> .................................(default: "."slmdirect_nlrc)\n";
    $outmsg = $outmsg."\t\t-TaggedCorpus <tagged corpus output file> ...........(default: "."slmdirect_results\/createslm_tagged_corpus)\n";

    $outmsg = $outmsg."\n\tPrimary Common TagsDirect/RulesDirect Options:\n";
    $outmsg = $outmsg."\t\t-GrammarBasename <grammar files basename> ...........(default: CREATESLM_TESTGRAMMAR)\n";
    $outmsg = $outmsg."\t\t-GrammarType <grammar type>[:r{obust}] ..............(default: NUANCE9)\n";

    $outmsg = $outmsg."\n\tSecondary Common TagsDirect/RulesDirect Options:\n";
    $outmsg = $outmsg."\t\t-AddTest <test file>[:pr{ecisionrecall}] \n";
    $outmsg = $outmsg."\t\t-CreateRegExp\n";
    $outmsg = $outmsg."\t\t-DontCheckRules .....................................(default: check rules)\n";
	$outmsg = $outmsg."\t\t-DontRemoveRepeats  .................................(default: remove repeats)\n";
    $outmsg = $outmsg."\t\t-DowncaseUtt  .......................................(default: don\'t downcase)\n";
    $outmsg = $outmsg."\t\t-KeepFragments  .....................................(default: delete fragments)\n";
    $outmsg = $outmsg."\t\t-KnownCatsFile <known categories file> \n";
    $outmsg = $outmsg."\t\t-Language <language> ................................(default: en-us)\n";
    $outmsg = $outmsg."\t\t-MergeNouns <noun-sentence file> \n";
    $outmsg = $outmsg."\t\t-MergeVerbs <verb-sentence file> \n";
    $outmsg = $outmsg."\t\t-MergeReal <merge file>[:<merge file 2>: ...] .......(default: slmdirect_merge_real)\n";
    $outmsg = $outmsg."\t\t-MergeShallow <merge file>[:<merge file 2>: ...] ....(default: slmdirect_merge_shallow)\n";
	$outmsg = $outmsg."\t\t-MinFrequency <freq> ................................(default: 1)\n";
#    $outmsg = $outmsg."\t\t-UseSentencePrefix  .................................(default: off)\n";
    $outmsg = $outmsg."\t\t-ReclassFile <reclassifications file>\n";
#    $outmsg = $outmsg."\t\t-RunBats\n";
#    $outmsg = $outmsg."\t\t-Stats <stats file> ..................................(default: none) \n";
    $outmsg = $outmsg."\t\t-Synonyms <strict|loose> \n";
    $outmsg = $outmsg."\t\t-Translate defaults\n";
    $outmsg = $outmsg."\t\t-Translate <translation_file>:<tagged sentence file>:<source_rules_container_file>:<prev_version_target_language_rules_container_file> \n";
    $outmsg = $outmsg."\t\t\t... (default <translation_file> name is: trans_file_<language>, e.g., trans_file_es-us)\n";
    $outmsg = $outmsg."\t\t\t... (default <tagged sentence file> name is: trans_file_<language>, e.g., trans_file_es-us)\n";
    $outmsg = $outmsg."\t\t-TuningVersion <tuning version> .....................(default: none)\n";
    $outmsg = $outmsg."\t\t-VerifyRules\n";
    $outmsg = $outmsg."\t\t-Version <version> ..................................(default: none)\n";

    $outmsg = $outmsg."\t\t-Vocab <vocab output file> ..........................(default: "."slmdirect_results\/createslm_vocab_uniq.sorted)\n";

    $outmsg = $outmsg."\n\tTestSentence Context Options:\n";
    $outmsg = $outmsg."\t\t-TestSentence \n";
    $outmsg = $outmsg."\t\t-TestSentenceAmplify \n";
    $outmsg = $outmsg."\t\t-Rules <rules file> .................................(default: "."slmdirect_results/createslm_init_nlrules)\n";

    $outmsg = $outmsg."\n\tStandAlone Utility Options:\n";
	$outmsg = $outmsg."\t\t-CheckCats <translation_file>:<source_rules_container_file>:<target_rules_container_file> \n";
    $outmsg = $outmsg."\t\t-Clear\n";
    $outmsg = $outmsg."\t\t-Help All or <option1 [,option2...]>\n";
    $outmsg = $outmsg."\t\t-IndentXML <input XML file>\n";

    $outmsg = $outmsg."\n\nUsage 2: $outprog [<options>] <untagged or partially tagged sentence file> \n";
    $outmsg = $outmsg."\n\tApplyTags Context Options:\n";
    $outmsg = $outmsg."\t\t-ApplyTags <sentence output file>\n";
    $outmsg = $outmsg."\t\t-Rules <rules file> .................................(default: "."slmdirect_results/createslm_init_nlrules)\n";
    $outmsg = $outmsg."\t\t-ReclassFile <reclassifications file>\n";
    $outmsg = $outmsg."\t\t-TagAssist\n";
	$outmsg = $outmsg."\t\t-TagRestore <sentence file from TagAssist>\n";
    $outmsg = $outmsg."\t\t-TestCreate <test option>[:<test percent>][:<blank test percent>] ..(default: random:10:3)\n";
    $outmsg = $outmsg."\t\t-UsePreviousTest \n";
    $outmsg = $outmsg."\t\t-UseTraditionalTranscriptions .......................(default: use normal input format)\n";

    $outmsg = $outmsg."\n\tAutoTag Context Options:\n";
    $outmsg = $outmsg."\t\t-AutoTag <strict|loose|none> \n";
    $outmsg = $outmsg."\t\t-TagDefinitions <tagdef file> ...........................(default: none) \n";

    $outmsg = $outmsg."\n\nUsage 3: $outprog [<options>] <fully tagged sentence file> \n";
    $outmsg = $outmsg."\n\tReducedCorpus Context Options:\n";
	$outmsg = $outmsg."\t\t-ReducedCorpus <sequence option>[:<sentence num>]\n";

	if ($called_from_gui) {
	  print $outmsg;
	} else {
	  if ($webSwitch) {
		$outmsg =~ s/\</\&lt;/g;
	  }

	  system("echo \"$outmsg\"|less");
	}

	if (opendir("INFODIR", "slmdirect_results")) {
	  closedir("INFODIR");
	  if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files")) {
		rmdir "slmdirect_results";
	  }

	  closedir("INFODIR");
	}

	writeTask();

    exit(0);
}

###########################################################
################## INITIAL SETUP ##########################
###########################################################

DebugPrint ("LOG", 1, "Main::Info", 1, $err_no++, "*** Input Command Line: $0 $command_line_options ***\n\n");

if (($do_autotag || $do_synonyms) && $wordnet_available) {
  $wn = WordNet::QueryData->new;
}

# Make directories if they don't exist.
if (!opendir("INFODIR", "slmdirect_results")) {
	mkdir "slmdirect_results", 0777;
} else {
	closedir("INFODIR");
}

if (($synonym_option ne "") || ($autotag_option ne "")) {
  if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_wordnet_files")) {
	mkdir "slmdirect_results\/createslmDIR_wordnet_files", 0777;
  } else {
	closedir("INFODIR");
  }
} else {
   if (opendir("INFODIR", "slmdirect_results\/createslmDIR_wordnet_files")) {
	 while (defined($file = readdir(INFODIR))) {
	   unlink "slmdirect_results\/createslmDIR_wordnet_files\/$file";
	 }

	 closedir("INFODIR");
	 rmdir "slmdirect_results\/createslmDIR_wordnet_files";
   }
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_info_files")) {
	mkdir "slmdirect_results\/createslmDIR_info_files", 0777;
} else {
	closedir("INFODIR");
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_important_files")) {
	mkdir "slmdirect_results\/createslmDIR_important_files", 0777;
} else {
	closedir("INFODIR");
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_analyze_files")) {
	mkdir "slmdirect_results\/createslmDIR_analyze_files", 0777;
} else {
	closedir("INFODIR");
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_temp_files")) {
	mkdir "slmdirect_results\/createslmDIR_temp_files", 0777;
} else {
	closedir("INFODIR");
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_backup_files")) {
	mkdir "slmdirect_results\/createslmDIR_backup_files", 0777;
} else {
	closedir("INFODIR");
}

if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_truth_files")) {
  mkdir "slmdirect_results\/createslmDIR_truth_files", 0777;
} else {
  closedir("INFODIR");
}

if (($tuning_version ne "") || ($addtestfile ne "") || ($appendtestfile ne "") || $do_classify || $do_retag) {
	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/data")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/data", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/docs")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/docs", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/grammars")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/grammars", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/scripts")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/scripts", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/tools")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/tools", 0777;
	} else {
		closedir("INFODIR");
	}

	if (!opendir("INFODIR", "slmdirect_results\/createslmDIR_tuning_files\/transcriptions")) {
		mkdir "slmdirect_results\/createslmDIR_tuning_files\/transcriptions", 0777;
	} else {
		closedir("INFODIR");
	}
}

if (!$dont_check_nlrules) {
	unlink "temp123";
}

if (lc($failparsefile) ne "none") {
	$make_failparse = 1;
	if ($failparsefile ne "STDOUT") {
		if ((lc($failparsefile) ne lc($testparsefileout)) && (lc($failparsefile) ne lc($classifyfileout))) {
			$failparsefile_write_out = "FAILPARSEFILE";
			if ($failparsefile =~ /slmdirect_results/) {
			  open(FAILPARSEFILE,">$failparsefile") or die "cant write $failparsefile";
			} else {
			  open(FAILPARSEFILE,">"."slmdirect_results\/$failparsefile") or die "cant write "."slmdirect_results\/$failparsefile";
			}
		} elsif (lc($failparsefile) eq lc($testparsefileout)) {
			$failparsefile_write_out = "TESTPARSEFILEOUT";
		} elsif (lc($failparsefile) eq lc($classifyfileout)) {
			$failparsefile_write_out = "CLASSIFYFILEOUT";
			$failparsefile_write_out_catonly = "CLASSIFYFILEOUT_READY";
		}
	} else {
		$failparsefile_write_out = "STDOUT";
	}
}

############################################################################
# Read Template and Rules Files
############################################################################
#

if ($do_autotag || $do_restore || $do_retag || $do_synonyms || $do_split_train_test || $do_read_catlist || $do_read_newcats || $do_make_nlrule_init || ($appendtestfile ne "") || ($reclassfile_in ne "")) {
  if ($nl_control eq "$repository\/slmdirect_nlrc") {
	if (($do_tagsdirect) && ($container_file_in ne "$repository\/slmdirect_results\/createslm_init_rules_container"."$language_suffix")) {
	  $nl_control = "$cat_nl_rules";
	} elsif ($do_split_train_test) {
	  $nl_control = $nlrc_template_name;
	} else {
	  $nl_control = $nlrc_template_name;
	}
  } else {
	if ($nl_control =~ /$nlrc_template_name/) {
	  $nlrc_template_name = $nl_control;
	}
  }
}

$nl_counter = 0;
if (-e "$nlrc_template_name") {
	open(NLTEMPLATE,"<$nlrc_template_name") or die "cant open $nlrc_template_name";
	while (<NLTEMPLATE>) {
		$elem = ChopChar($_);
		if ($elem eq "") {
			next;
		}

		if (substr($elem,0,1) eq "#") {
			next;
		}

		($first, @rest) = split ",", $elem;
		$second = "";
		if (checkMultiParseVariables($first)) {
			$second = shift @rest;
		}

		$next = join ",", @rest;

		if ($second ne "") {
			$nl_template_hash{"$first:$second"} = $nl_counter;
			push @nl_overall_array, "$first,$second,$next";
		} else {
			if (checkSpecialParseVariables($first) && (defined $nl_template_hash{$first})) {
				$connector = setConnector($first);
				$nl_overall_array[$nl_template_hash{$first}] = $nl_overall_array[$nl_template_hash{$first}].$connector.$next;
				$nl_counter--;
			} else {
				$nl_template_hash{$first} = $nl_counter;
				push @nl_overall_array, "$first,$next";
			}
		}

		$nl_counter++;
	}
}

close(NLTEMPLATE);

if ($nl_control ne $nlrc_template_name) {
	if (-e "$nl_control") {
		open(NLRULES,"<$nl_control") or die "cant open $nl_control";
		$nl_counter_rules = 0;
		while (<NLRULES>) {
			$elem = ChopChar($_);
			if ($elem eq "") {
				next;
			}

			if (substr($elem,0,1) eq ",") {
				$unknown_nl_types_hash{"BLANK"}{$elem}++;

				next;
			}

			if (substr($elem,0,1) eq "#") {
				next;
			}

			($first, @rest) = split ",", $elem;
			$second = "";
			if (checkMultiParseVariables($first)) {
				$second = shift @rest;
			}

			$next = join ",", @rest;

			if ($second ne "") {
				$nl_rules_counter_hash{"$first:$second"} = $nl_counter_rules;
				$nl_rules_hash{"$first:$second"} = "$first,$second,$next";
				push @nl_rules_array, "$first:$second";
			} else {
				if (checkSpecialParseVariables($first) && (defined $nl_rules_hash{$first})) {
					$connector = setConnector($first);
					$nl_rules_hash{$first} = $nl_rules_hash{$first}.$connector.$next;
					$nl_counter_rules--;
				} else {
					$nl_rules_counter_hash{$first} = $nl_counter_rules;
					$nl_rules_hash{$first} = "$first,$next";
					push @nl_rules_array, "$first";
				}
			}

			$nl_counter_rules++;
		}

		close(NLRULES);

		foreach $elem (@nl_rules_array) {
			$line_num = $nl_template_hash{$elem};
			if (defined $line_num) {
				if (checkSpecialParseVariables($elem)) {
					$connector = setConnector($elem);
					$temp_string = $nl_rules_hash{$elem};
					$temp_string =~ s/(([A-Z])+)\,//;
					$nl_overall_array[$line_num] = $nl_overall_array[$line_num].$connector.$temp_string;
				} else {
					$nl_overall_array[$line_num] = $nl_rules_hash{$elem};
				}
			} else {
				$nl_overall_array[$nl_counter] = $nl_rules_hash{$elem};
				$nl_counter++;
			}
		}
	} else {
		DebugPrint ("BOTH", 3, "Main::CheckRules", $debug, $err_no++, "Can't find RULES FILE: ".NormalizeFilename($nl_control));

		DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "Main::CreateMainGrammar", $debug, $err_no++, "\n");

		writeTask();

		exit(0);
	}
}

undef %nl_template_hash;
undef %nl_rules_hash;
@nl_rules_array = ();

############################################################################
# Process Rules and Command Variables
############################################################################
#

if ($make_maingrammar || $do_testsentence || $do_testparsefile || $do_classify || $filter_corpus || $do_check_nlrules || $do_filtertestline || $do_read_catlist || $do_make_nlrule_init || ($reclassfile_in ne "") || ($appendtestfile ne "") || ($do_split_train_test ne "")) {
	$do_check_nlrules = 1;
	if ($dont_check_nlrules) {
		$do_check_nlrules = 0;
	}

	if ($infile eq "STDIN") {
		print "Loading Rules .... ";
	}

	@all_gram_elems_array = ();
	@all_gram_elems_nuance_speakfreely_array = ();
	@all_gram_elems_nuance_class_full_xml_array = ();
	$test_slotname = "itemname";
	$test_confirm_as = "confirm_as";
	$test_reject_name = "GARBAGE_REJECT";

	foreach (@nl_overall_array) {
		if (substr($_,0,1) ne "#") {
			($nl_type,@nl_key_array) = split ",";
			(@nl_sub_types_array) = split ":", $nl_type;
			$temp_string = ChopChar($_);
			$varname = "";

			$set_normal_varvalue = 0;
			$do_add_grammar = 0;
			$do_add_vocab = 0;
			$do_add_wordnet_pos = 0;
			$do_add_wordnet_synonym = 0;
			$do_alias_exclusion = 0;
			$do_ambig_gen_rule = 0;
			$do_ambig_only = 0;
			$do_ambig_rule = 0;
			$do_assoc_array = 0;
			$do_char_omit = 0;
			$do_automatic_class_grammars = 0;
			$do_class_grammars = 0;
			$do_conditional_replace = 0;
			$do_correct_spelling = 0;
			$do_delete_char = 0;
			$do_explicit_categories = 0;
			$do_exclude_numbers = 0;
			$do_exclude_words = 0;
			$do_expand_grammar = 0;
			$do_external_rule = 0;
			$do_generic_rule = 0;
			$do_grammar = 0;
			$do_grammar_gen = 0;
			$do_heavy_categories = 0;
			$do_join = 0;
			$do_label_omit = 0;
			$do_label_replace = 0;
			$do_main_rule = 0;
			$do_allow_general = 0;
			$do_max_wordnet_sentence_length = 0;
			$do_max_filter_sentence_length = 0;
			$do_max_wordnet_count = 0;
			$do_min_wordnet_frequency_noun = 0;
			$do_min_wordnet_frequency_verb = 0;
			$do_min_wordnet_frequency_adjective = 0;
			$do_merge_noun_prefix = 0;
			$do_merge_noun_verb_alias = 0;
			$do_merge_verb_prefix = 0;
			$do_product_prefix = 0;
			$do_response_exclusion = 0;
			$do_response_exclusion_tags = 0;
			$do_sentence_length = 0;
			$do_specify_dictionary = 0;
			$do_set_false_frequency = 0;
			$do_test_variable = 0;
			$do_trainfile_meta = 0;
			$do_trainfile_param = 0;
			$do_trainfile_ssm_param = 0;
			$do_trainfile_stop = 0;
			$do_valid_restricted_end = 0;
			$do_valid_restricted_general = 0;
			$do_variable = 0;
			$do_word_groups = 0;
			$do_replace = 0;
			$do_search = 0;

			foreach $sub_type ( @nl_sub_types_array ) {
				if ($sub_type eq "AE") {
					$do_alias_exclusion = 1;
				} elsif ($sub_type eq "AG") {
					$do_allow_general = 1;
				} elsif ($sub_type eq "AO") {
					$do_ambig_only = 1;
				} elsif ($sub_type eq "AR") {
					$do_ambig_gen_rule = 1;
				} elsif ($sub_type eq "AV") {
					$do_add_vocab = 1;
				} elsif ($sub_type eq "BR") {
					$do_ambig_rule = 1;
				} elsif ($sub_type eq "CG") {
					$do_class_grammars = 1;
				} elsif ($sub_type eq "ACG") {
					$do_automatic_class_grammars = 1;
				} elsif ($sub_type eq "CN") {
				    $varname = "company_name";
				    $set_normal_varvalue = 1;
				} elsif ($sub_type eq "CO") {
					$do_char_omit = 1;
				} elsif ($sub_type eq "CS") {
					$do_correct_spelling = 1;
				} elsif ($sub_type eq "CR") {
					$do_variable = 1;
					$do_conditional_replace = 1;
				} elsif ($sub_type eq "DC") {
					$do_delete_char = 1;
				} elsif ($sub_type eq "EC") {
					$do_explicit_categories = 1;
				} elsif ($sub_type eq "EN") {
					$do_exclude_numbers = 1;
				} elsif ($sub_type eq "ER") {
					$do_external_rule = 1;
				} elsif ($sub_type eq "EV") {
					$do_exclude_words = 1;
				} elsif ($sub_type eq "FA") {
					$varname = "test_confirm_as";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FB") {
					$varname = "test_app_past_verbs";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFB") {
					$varname = "test_app_past_verbs_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FN") {
					$varname = "test_app_nouns";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FP") {
					$varname = "test_pre_app_specific_string";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FQ") {
					$varname = "test_filter_multiplier";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FS") {
					$varname = "test_pre_string";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "FV") {
					$varname = "test_app_present_verbs";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFN") {
					$varname = "test_app_nouns_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFP") {
					$varname = "test_pre_app_specific_string_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFS") {
					$varname = "test_pre_string_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFV") {
					$varname = "test_app_present_verbs_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "ESFVA") {
					$varname = "test_app_present_additional_verbs_esus";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "G") {
					$do_grammar = 1;
				} elsif ($sub_type eq "GD") {
					$set_normal_varvalue = 1;
					$varname = "test_general";
				} elsif ($sub_type eq "GE") {
					$do_expand_grammar = 1;
				} elsif ($sub_type eq "GG") {
					$do_variable = 1;
					$do_grammar_gen = 1;
				} elsif ($sub_type eq "GN") {
				    $varname = "main_grammar_name";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "GR") {
					$do_generic_rule = 1;
				} elsif ($sub_type eq "HC") {
					$do_heavy_categories = 1;
				} elsif ($sub_type eq "LO") {
					$do_label_omit = 1;
				} elsif ($sub_type eq "LR") {
					$do_label_replace = 1;
				} elsif ($sub_type eq "MNP") {
					$do_merge_noun_prefix = 1;
				} elsif ($sub_type eq "MNVA") {
					$do_merge_noun_verb_alias = 1;
				} elsif ($sub_type eq "MR") {
					$do_main_rule = 1;
				} elsif ($sub_type eq "MVP") {
					$do_merge_verb_prefix = 1;
				} elsif ($sub_type eq "NL") {
				    $varname = "normalization_level";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "PF") {
				    $varname = "product_prefix_num";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "PN") {
	                $varname = "pfsg_name";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "PX") {
					$do_product_prefix = 1;
				} elsif ($sub_type eq "R") {
					$do_variable = 1;
					$do_replace = 1;
				} elsif ($sub_type eq "RD") {
					$varname = "test_relevant";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "RET") {
					$do_response_exclusion_tags = 1;
				} elsif ($sub_type eq "RE") {
					$do_response_exclusion = 1;
				} elsif ($sub_type eq "RMN") {
	                $varname = "rule_multiplier_num";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "RN") {
					$varname = "test_reject_name";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "SD") {
					$do_specify_dictionary = 1;
				} elsif ($sub_type eq "SL") {
					$do_sentence_length = 1;
				} elsif ($sub_type eq "SN") {
					$varname = "test_slotname";
					$set_normal_varvalue = 1;
				} elsif ($sub_type eq "STP") {
					$do_trainfile_ssm_param = 1;
				} elsif ($sub_type eq "TM") {
					$do_trainfile_meta = 1;
				} elsif ($sub_type eq "TP") {
					$do_trainfile_param = 1;
				} elsif ($sub_type eq "TS") {
					$do_trainfile_stop = 1;
				} elsif ($sub_type eq "VWRE") {
					$do_valid_restricted_end = 1;
				} elsif ($sub_type eq "VWRG") {
					$do_valid_restricted_general = 1;
				} elsif ($sub_type eq "WCC") {
					$do_max_wordnet_count = 1;
				} elsif ($sub_type eq "WFN") {
					$do_min_wordnet_frequency_noun = 1;
				} elsif ($sub_type eq "WFV") {
					$do_min_wordnet_frequency_verb = 1;
				} elsif ($sub_type eq "WFA") {
					$do_min_wordnet_frequency_adjective = 1;
				} elsif ($sub_type eq "WFF") {
					$do_set_false_frequency = 1;
				} elsif ($sub_type eq "WSL") {
					$do_max_wordnet_sentence_length = 1;
				} elsif ($sub_type eq "FSL") {
					$do_max_filter_sentence_length = 0;
				} elsif ($sub_type eq "WDP") {
					$do_add_wordnet_pos = 1;
				} elsif ($sub_type eq "WAS") {
					$do_add_wordnet_synonym = 1;
				} elsif ($sub_type eq "WG") {
					$do_word_groups = 1;
				} elsif ($sub_type eq "\%") {
					$do_assoc_array = 1;
				} elsif ($sub_type eq "+") {
					$do_join = 1;
				} elsif ($sub_type eq "\$") {
					$do_variable = 1;
					$do_test_variable = 1;
					if (substr($_,0,1) ne "#") {
						if (($_ =~ /_alias\,/) && ($_ !~ /esus_alias\,/) && ($_ !~ /generic_alias\,/)) {
							($temp_qaz, $alias_name, $alias_def) = split ",", $temp_string;
							$alias_search_hash{$alias_name} = $alias_def;
						} elsif (($_ =~ /_esus_alias/) && ($_ !~ /generic_alias\,/)) {
							($temp_qaz, $alias_name, $alias_def) = split ",", $temp_string;
							$alias_search_esus_hash{$alias_name} = $alias_def;
						}
					}
				} elsif ($sub_type eq "\^") {
					$do_variable = 1;
					$do_add_grammar = 1;
					$do_test_variable = 1;
				} elsif ($sub_type eq "\?") {
					$do_variable = 1;
					$do_search = 1;
				} else {
					$unknown_nl_types_hash{$sub_type}{$temp_string}++;
				}
			}

			if ($varname ne "") {
			  $do_variable = 1;
			}

			if ($do_main_rule == 1) {
				($main_Rule_count) = Apply_Rule_Type("main", $main_language, $_, \%rule_varname_hash, \%neg_rule_varname_hash, $main_Rule_count, \%level_counter_hash, $make_vocab, "\{<$test_slotname \"%s\"> <$test_confirm_as \"%s\"> <Spokentext \$string>}", "<item>\n\t<ruleref uri=\"#%s\" \/>\n\t<tag>$test_slotname_nuance_speakfreely=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag>\n<\/item>\n", \%apply_rules_hash, \@all_gram_elems_array, \@all_gram_elems_nuance_speakfreely_array, \@all_gram_elems_nuance_class_full_xml_array, \%full_vocab_hash, \%grammar_rules_additional, \%grammar_rules_additional_nuance_speakfreely, \%grammar_rules_additional_nuance_class_full_xml);
			} elsif ($do_generic_rule == 1) {
				($general_Rule_count) = Apply_Rule_Type("general", $main_language, $_, \%rule_varname_hash, \%neg_rule_varname_hash, $general_Rule_count, \%level_counter_generic_hash, $make_vocab, "\{<$test_slotname \"%s\"> <$test_confirm_as \"%s\"> <Spokentext \$string>}", "<item>\n\t<ruleref uri=\"#%s\" \/>\n\t<tag>$test_slotname_nuance_speakfreely=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag>\n<\/item>\n", \%generic_rules_hash, \@all_gram_elems_array, \@all_gram_elems_nuance_speakfreely_array, \@all_gram_elems_nuance_class_full_xml_array, \%full_vocab_hash, \%grammar_rules_additional, \%grammar_rules_additional_nuance_speakfreely, \%grammar_rules_additional_nuance_class_full_xml);
			} elsif ($do_ambig_rule == 1) {
				($main_Ambig_Rule_count) = Apply_Rule_Type("main_ambig", $main_language, $_, \%rule_varname_hash, \%neg_rule_varname_hash, $main_Ambig_Rule_count, \%level_counter_mainambig_hash, $make_vocab, "\{<ambig_key \"%s\">\t<$test_confirm_as \"%s\">}", "<item>\n\t<ruleref uri=\"#%s\" \/>\n\t<tag>AMBIG_KEY=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag>\n<\/item>\n", \%apply_ambig_rules_hash, \@all_gram_elems_array, \@all_gram_elems_nuance_speakfreely_array, \@all_gram_elems_nuance_class_full_xml_array, \%full_vocab_hash, \%grammar_rules_additional, \%grammar_rules_additional_nuance_speakfreely, \%grammar_rules_additional_nuance_class_full_xml);
			} elsif ($do_external_rule == 1) {
				($external_Rule_count) = Apply_Rule_Type("external", $main_language, $_, \%rule_varname_hash, \%neg_rule_varname_hash, $external_Rule_count, \%level_counter_external_hash, $make_vocab, "\{<ambig_key \"%s\">\t<$test_confirm_as \"%s\">}", "<item>\n\t<ruleref uri=\"#%s\" \/>\n\t<tag>AMBIG_KEY=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag>\n<\/item>\n", \%external_rules_hash, \@all_gram_elems_array, \@all_gram_elems_nuance_speakfreely_array, \@all_gram_elems_nuance_class_full_xml_array, \%full_vocab_hash, \%grammar_rules_additional, \%grammar_rules_additional_nuance_speakfreely, \%grammar_rules_additional_nuance_class_full_xml);
			} elsif ($do_valid_restricted_end == 1) {
				makeHashfromString($temp_string, \%valid_restricted_end_hash);
            } elsif ($do_allow_general == 1) {
				makeHashfromString($temp_string, \%allow_general_hash);
            } elsif ($do_specify_dictionary == 1) {
				makeHashfromString($temp_string, \%add_dictionaries_hash);
				makeHashfromString($temp_string, \%add_dictionaries_nuance9_hash);
            } elsif ($do_set_false_frequency == 1) {
				setFalseFreqsfromString($temp_string, \%wordnet_false_frequency_hash, \%alt_default_pos_hash);
            } elsif ($do_valid_restricted_general == 1) {
				makeHashfromString($temp_string, \%valid_restricted_general_hash);
            } elsif ($do_ambig_only == 1) {
				makeArrayfromString("rules", $temp_string, ",", \@ambig_markers_array);

#				foreach $elem (@ambig_markers_array) {
#				}

            } elsif ($do_label_omit == 1) {
				makeArrayfromString("rules", $temp_string, ":", \@omit_array);
            } elsif ($do_exclude_numbers == 1) {
				makeArrayfromString("rules", $temp_string, ",", \@exclude_nums_array);
            } elsif ($do_exclude_words == 1) {
				makeArrayfromString("rules", $temp_string, ",", \@exclude_words_array);
            } elsif ($do_delete_char == 1) {
				makeArrayfromString("rules", $temp_string, ":", \@delete_char_array);
            } elsif ($do_explicit_categories == 1) {
				makeHashfromString($temp_string, \%explicit_categories_hash);
            } elsif ($do_heavy_categories == 1) {
				makeHeavyHashfromString($temp_string, \%heavy_categories_hash);
            } elsif ($do_char_omit == 1) {
				makeArrayfromString("rules", $temp_string, ":", \@char_omit_array);
            } elsif ($do_label_replace == 1) {
				makeArrayfromString("rules", $temp_string, ",", \@replacement_array);
            } elsif ($do_max_wordnet_count == 1) {
				($nl_type,$max_wordnet_count) = split ",", $temp_string;
            } elsif ($do_min_wordnet_frequency_noun == 1) {
				($nl_type,$min_wordnet_frequency_noun) = split ",", $temp_string;
            } elsif ($do_min_wordnet_frequency_verb == 1) {
				($nl_type,$min_wordnet_frequency_verb) = split ",", $temp_string;
            } elsif ($do_min_wordnet_frequency_adjective == 1) {
				($nl_type,$min_wordnet_frequency_adjective) = split ",", $temp_string;
            } elsif ($do_max_wordnet_sentence_length == 1) {
				($nl_type,$max_wordnet_sentence_length) = split ",", $temp_string;
            } elsif ($do_max_filter_sentence_length == 1) {
				($nl_type,$max_filter_sentence_length) = split ",", $temp_string;
            } elsif ($do_add_wordnet_pos == 1) {
				makePOSHashfromString($temp_string, \%add_wordnet_pos_hash);
            } elsif ($do_add_wordnet_synonym == 1) {
				makeSynonymHashfromString($temp_string, \%alt_syn_default_pos_hash, \%add_wordnet_synonym_hash);
            } elsif ($do_product_prefix == 1) {
				makeArrayDirectfromString($temp_string, \@product_prefix_array);
			} elsif ($do_trainfile_stop == 1) {
				makeArrayDirectfromString($temp_string, \@training_stop_items_array);
			} elsif ($do_response_exclusion_tags == 1) {
				$response_exclusion_string_tags = makeStringDirectfromString($temp_string);
            } elsif ($do_response_exclusion == 1) {
				$response_exclusion_string = makeStringDirectfromString($temp_string);
            } elsif ($do_sentence_length == 1) {
				$sentence_length_for_scan = makeStringDirectfromString($temp_string);
		    } elsif ($do_expand_grammar == 1) {
				makeArrayDirectfromString($temp_string, \@expand_grammar_array);
		    } elsif ($do_add_vocab == 1) {
				stringToVocab("do_add_vocab", $temp_string, \%full_vocab_hash);
            } elsif ($do_assoc_array == 1) {
				($nl_type,$varname,@array_elems) = split ",", $temp_string;

				foreach $elem ( @array_elems ) {
					($assoc_name,$assoc_val) = split ":", $elem;
					${$varname}{$assoc_name} = $assoc_val;
	            }
		    } elsif ($do_join == 1) {
				($nl_type,$new_varname,$add_varname,$add_word) = split ",", $temp_string;
				${$new_varname} = "${$add_varname}|";
		        ${$new_varname} =~ s/\|/ $add_word\|/g;

	            ${$new_varname} = ChopChar(${$new_varname});
            } elsif ($do_automatic_class_grammars == 1) {
			  $auto_class_grammar_search_string = $temp_string;
			  $auto_class_grammar_search_string =~ s/^ACG\,//;
            } elsif ($do_class_grammars == 1) {
				if ($grammar_type eq "NUANCE_GSL") {
					makeClassGrammars($main_language, "NUANCE_GSL", $grammarbase, $temp_string, \%class_grammar_hash, $dont_do_additional_command_vars);
				}

				if ($grammar_type eq "NUANCE_SPEAKFREELY") {
					makeClassGrammars($main_language, "NUANCE_SPEAKFREELY", $grammarbase, $temp_string, \%class_grammar_hash, $dont_do_additional_command_vars);
				}

				if ($grammar_type eq "NUANCE9") {
					makeClassGrammars($main_language, "NUANCE9", $grammarbase, $temp_string, \%class_grammar_hash, $dont_do_additional_command_vars);
				}

            } elsif ($do_merge_noun_prefix == 1) {
				$prev_level_count = 0;
				$level_count = 1000;
				$counter = 1;

				makeArrayDirectfromString($temp_string, \@do_temp_array);

				ProcessNounVerbSentences($main_language, \@do_temp_array, $debug, \%merge_noun_verb_alias_hash, \%merge_noun_prefix_hash);

				@do_temp_array = ();
            } elsif ($do_merge_noun_verb_alias == 1) {
				my($nva_name);
				my($nva_body);
				my($rep_alias);
				my($rep_body);

				makeArrayDirectfromString($temp_string, \@do_temp_array);
                foreach $elem (@do_temp_array) {
                    ($nva_name, $nva_body) = split /:/, $elem;

					$nva_body =~ s/\?\(((\w|\^|\ |\?|\||\_|\')+)\)/\(\(\<NULL\>\)\|\($1\)\)/g;
					$nva_body =~ s/\?((\w|\^|\_|\')+)/\(\<NULL\>\|$1\)/g;
					$nva_body =~ s/((\w|\_|\')+)/\($1\)/g;
					$nva_body =~ s/\^\(((\w|\_|\')+)\)/\^$1/g;
					$nva_body =~ s/\(NULL\)/NULL/g;

					if ($nva_body =~ /\?/) {
						$nva_body = ProcessOPTIONALs_SLMDirect ($debug, $nva_body, 0);
					}

					$temp_merge_noun_verb_alias_hash{$nva_name} = $nva_body;
                }

				foreach $elem ( sort { $a cmp $b } keys %temp_merge_noun_verb_alias_hash) {
					$elem1 = $temp_merge_noun_verb_alias_hash{$elem};
					while (index($elem1, "^") != -1) {
						if ($elem1 =~ /\^((\w|\_)+)/) {
							$rep_alias = $1;
							$rep_body = $temp_merge_noun_verb_alias_hash{$rep_alias};
							$elem1 =~ s/\^$rep_alias/\($rep_body\)/g;
						}
					}

					$merge_noun_verb_alias_hash{$elem} = $elem1;
				}

				@do_temp_array = ();
            } elsif ($do_merge_verb_prefix == 1) {
				makeArrayDirectfromString($temp_string, \@do_temp_array);

				ProcessNounVerbSentences($main_language, \@do_temp_array, $debug, \%merge_noun_verb_alias_hash, \%merge_verb_prefix_hash);

				@do_temp_array = ();
            } elsif ($do_alias_exclusion == 1) {
				makeAliasExclusion($temp_string, \%alias_exclusion_hash);
			} elsif ($do_trainfile_meta == 1) {
				makeTrainingFileArray("meta", $temp_string, \%training_items_hash);
			} elsif ($do_trainfile_param == 1) {
				makeTrainingFileArray("param", $temp_string, \%training_items_hash);
			} elsif ($do_trainfile_ssm_param == 1) {
				makeTrainingFileArray("param", $temp_string, \%training_ssm_items_hash);
			} elsif (($do_correct_spelling == 1) || ($do_word_groups == 1)) {
				my($elem);
				my($elem1);
				my($now);
				my($build_string);
				my($correction);
				my(@out_array);

				if ($do_word_groups == 1) {
					makeArrayDirectfromString($temp_string, \@do_temp_array);

					foreach $elem (@do_temp_array) {
						push @correct_spelling_list, $elem;
					}

					if ($do_correct_spelling == 0) {
						$correct_spelling_test_string = "";
					}
				} else {
					($nl_type,@correct_spelling_list) = split ",", $temp_string;
				}

				foreach $elem (@correct_spelling_list) {
					($now, $correction) = split /\+/, $elem;
					if (($now ne "") && ($correction ne "")) {
						if (index($now,">") != -1) {
							BuildRepStrings($now, \@out_array);

							foreach $elem1 (@out_array) {
							  $correct_spelling_test_string = stringBuilder($correct_spelling_test_string, "\\b".$elem1."\\b", "|");
							}
						} else {
						  $correct_spelling_test_string = stringBuilder($correct_spelling_test_string, "\\b".$now."\\b", "|");
						}
					} else {
						$rule_now_correction_error_hash{"$now <==> $correction"}++;
					}
				}

				@do_temp_array = ();
            } elsif ($do_grammar == 1) {
				($nl_type,$varname,$varvalue) = split ",", $temp_string;

			    $combo = SetGlobalVars (":", $varvalue);
                $combo = TrimChars($combo);

			    $combo = $varname." ".$combo;

                push(@grammar_array, $combo);
            } elsif ($do_variable == 1) {
				if ($set_normal_varvalue) {
					$varvalue = makeStringDirectfromString($temp_string);
                } else {
					my($level);

	                ($nl_type,$varname,$varvalue,@rest) = split ",", $temp_string;
					($varname, $level) = split /\>/, $varname;
					$varname_hash{$varname}++;
                }

				$varvalue = GetRuleErrors($do_check_nlrules, $varvalue, \%varname_hash, \%rule_error_nullor_hash, \%rule_error_double_dollar_hash, \%rule_error_badalias_hash, \%rule_error_missingalias_hash, \%rule_error_countparens_hash, \%rule_error_emptyparens_hash);

                $combo = SetGlobalVars (":", $varvalue);
				if ($combo =~ /(\$(\w|\_|\d)+)/) {
					$alias_name = $1;
					$temp_alias_name = $alias_name;
					$temp_alias_name =~ s/\$//g;

					$combo =~ s/_alias\'s/_alias/g;
					$alias_def = $alias_search_hash{$temp_alias_name};
					if (defined $alias_def) {
						$alias_name = quotemeta($alias_name);
						$combo =~ s/$alias_name/$alias_def/g;
					}
				}

				if ($do_test_variable == 1) {
					setRuleWordHash($combo, \%rule_word_hash);
				}

				if (index($combo,">") != -1) {
					my(@out_array);
					my($build_string);
					my($elem1);
					my($tstr1, $tstr2, $tstr3);

					while ($combo =~ /(\b(\w)+\b)\>(\b(\w)+\b)/) {

						$tstr1 = $1;
						$tstr2 = $3;
						$tstr3 = $tstr1.">".$tstr2;

						BuildRepStrings($tstr3, \@out_array);

						$build_string = "";
						foreach $elem1 (@out_array) {
						  $build_string = stringBuilder($build_string, $elem1, "|");
						}

						$build_string = "(".$build_string.")";
						$combo =~ s/$tstr3/$build_string/g;
					}
				}

				$combo =~ s/_(\d+)FILLER(\d+)_/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\{$1\,$2\}\?/g;
				$combo =~ s/_FILLER(\d+)_/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\{0\,$1\}\?/g;
				$combo =~ s/_(\d+)FILLER_/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\{$1\,\}\?/g;
				$combo =~ s/_FILLER_/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\*\?/g;
                $combo = TrimChars($combo);

			    ${$varname} = $combo;

				if ($varname eq "test_slotname") {
					$test_slotname_nuance_speakfreely = $test_slotname;
				}

				if ($varname eq "test_confirm_as") {
					$test_confirm_as_nuance_speakfreely = $test_confirm_as;
				}

                if ($do_search == 1) {
					$combo = $varname.":".$rest[0];

                    push(@search_array, $combo);
                }

                if ($do_replace == 1) {
					$combo = $varname.":".$rest[0];

                    push(@replacement_array, $combo);
			    }

			    if ($do_conditional_replace == 1) {
					$combo = $varname.":".$rest[0];

                    push(@conditional_replace_array, $combo);
                }

			    if ($do_grammar_gen == 1) {
					$combo = $varname.":".$rest[0];

                    push(@grammar_gen_array, $combo);
			    }

				if (($do_add_grammar) && ($do_addallrules || $do_addmainrules_only)) {
					my($build_string) = "";
					my(@grammar_items) = ();
					my(@class_grammar_items);
					my($elem);
					my($save_combo);
					my($do_the_add) = 1;

					$combo =~ s/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\{\d+,\d+\}\?/ \?_FILTEMP_ /g; 
					$combo =~ s/\\s\+\(\(\\w\|\\_\|\\'\)\*\\s\*\)\*\?/ \?_FILTEMP_ /g; 
					$combo =~ s/\\b//g; 
					$combo =~ s/\(\?\!\((\w|\s|\|)+\)//g;

					if ($combo =~ /\((.*)\)/) {
						$combo = $1;
					}

					$save_combo = $combo;

					if ($do_addmainrules_only) {
						if (($combo !~ /_FILTEMP_/) && ($combo !~ / /)) {
							if (not defined $allow_general_hash{$combo}) {
								$disallow_general_additional_hash{$combo}++;
								$do_the_add = 0;
							}
						}
					}

					if ($do_the_add) {
						if ($grammar_type eq "NUANCE_GSL") {
							@grammar_items = ();
							@class_grammar_items = ();
							while ($combo ne "") {
								$combo = FindEnclosure("", "", "NUANCE_GSL", $combo, \@grammar_items, \@class_grammar_items);
							}

							foreach $elem (@grammar_items) {
							  $build_string = stringBuilder($build_string, $elem, ":");
							}

							$grammar_rules_additional{"\$".$varname} = $build_string;
						}

						if ($grammar_type eq "NUANCE_SPEAKFREELY") {
							@grammar_items = ();
							@class_grammar_items = ();
							$combo = $save_combo;

							$build_string = "";

							while ($combo ne "") {
								$combo = FindEnclosure("", "", "NUANCE_SPEAKFREELY", $combo, \@grammar_items, \@class_grammar_items);
							}

							foreach $elem (@grammar_items) {
							  $build_string = stringBuilder($build_string, $elem, ":");
							}

							$grammar_rules_additional_nuance_class_full_xml{"\$".$varname} = $build_string;

							$build_string =~ s/\n/ /g;
							$build_string =~ s/\<item\>/ /g;
							$build_string =~ s/\<\/item\>/ /g;
							$build_string =~ s/\<one-of\>/ /g;
							$build_string =~ s/\<\/one-of\>/ /g;
							$build_string = TrimChars($build_string);

							$grammar_rules_additional_nuance_speakfreely{"\$".$varname} = $build_string;
						}

						if ($grammar_type eq "NUANCE9") {
							@class_grammar_items = ();
							@grammar_items = ();
							$combo = $save_combo;

							$build_string = "";

							while ($combo ne "") {
								$combo = FindEnclosure("", "", "NUANCE9", $combo, \@grammar_items, \@class_grammar_items);
							}

							foreach $elem (@grammar_items) {
							  $build_string = stringBuilder($build_string, $elem, ":");
							}

							$grammar_rules_additional_nuance_class_full_xml{"\$".$varname} = $build_string;

							$build_string =~ s/\n/ /g;
							$build_string =~ s/\<item\>/ /g;
							$build_string =~ s/\<\/item\>/ /g;
							$build_string =~ s/\<one-of\>/ /g;
							$build_string =~ s/\<\/one-of\>/ /g;
							$build_string = TrimChars($build_string);

							$grammar_rules_additional_nuance9{"\$".$varname} = $build_string;
						}
					}
                }
            }
		}
	}

############################################################################
# Check Rules and Command Variables for integrity
############################################################################
#

	if ($do_check_nlrules) {
	  checkRules ($nl_control, $nlrc_template_name, $do_read_catlist, $do_make_nlrule_init, \%rule_varname_hash, \%varname_hash, \%neg_rule_varname_hash, \%rule_error_nullor_hash, \%rule_error_double_dollar_hash, \%rule_now_correction_error_hash, \%rule_error_badalias_hash, \%rule_error_missingalias_hash, \%rule_error_countparens_hash, \%rule_error_emptyparens_hash, \%unknown_nl_types_hash);

		if (!($make_maingrammar || $do_testsentence || $do_testparsefile || $do_classify || $filter_corpus || $do_filtertestline || $do_checkcats || $do_read_catlist || $do_read_newcats || $do_transcat || $do_make_nlrule_init || ($reclassfile_in ne "") || ($appendtestfile ne "") || ($do_split_train_test ne ""))) {
		  writeTask();

			exit(0);
		}
	}

	undef %varname_hash;
	undef %rule_varname_hash;
	undef %rule_error_nullor_hash;
	undef %rule_error_double_dollar_hash;
	undef %rule_error_badalias_hash;
	undef %rule_error_missingalias_hash;
	undef %rule_error_countparens_hash;
	undef %rule_error_emptyparens_hash;
	undef %grammar_rules_additional;
	undef %grammar_rules_additional_nuance_speakfreely;
	undef %grammar_rules_additional_nuance_class_full_xml;

	if ($test_slotname eq "") {
		$test_slotname = "itemname";
	}

	if ($test_confirm_as eq "") {
		$test_confirm_as = "confirm_as";
	}

	$test_slotname_nuance_speakfreely = $test_slotname;
	$test_confirm_as_nuance_speakfreely = $test_confirm_as;

    if ($product_prefix_num eq "") {
		$product_prefix_num = 1;
	}

	if ($normalization_level eq "") {
		$normalization_level = 0;
	}

	if ($test_filter_multiplier eq "") {
		$test_filter_multiplier = $product_prefix_num;
	}

	if ($rule_multiplier_num eq "") {
		$rule_multiplier_num = $test_filter_multiplier + 30;
	}

	if ($do_use_rule_multiplier) {
		$rule_multiplier = $rule_multiplier_num * $product_prefix_num;
	} else {
		$rule_multiplier = $test_filter_multiplier;
	}

	if ($infile eq "STDIN") {
		print "Done\n\n";
	}
}

if (($do_autotag || $do_synonyms) && $wordnet_available) {
	DebugPrint ("BOTH", 0, "Main::BuildWordEndingsList", $debug, $err_no++, "Loading Wordnet Part of Speech Arrays");
	$wordnet_min_hash{"all"} = $min_wordnet_frequency_noun;
	$wordnet_min_hash{"noun"} = $min_wordnet_frequency_noun;
	$wordnet_min_hash{"verb"} = $min_wordnet_frequency_verb;
	$wordnet_min_hash{"adjective"} = $min_wordnet_frequency_adjective;

	$total_noun_count= BuildWordEndingsList("noun", $wn, \%ending_noun_hash);
	$total_verb_count= BuildWordEndingsList("verb", $wn, \%ending_verb_hash);
	$total_adjective_count= BuildWordEndingsList("adjective", $wn, \%ending_adjective_hash);

	DebugPrint ("BOTH", 1, "Main::BuildWordEndingsList", $debug, $err_no++, "Noun Count: \t\t$total_noun_count");
	DebugPrint ("BOTH", 1, "Main::BuildWordEndingsList", $debug, $err_no++, "Verb Count: \t\t$total_verb_count");
	DebugPrint ("BOTH", 1, "Main::BuildWordEndingsList", $debug, $err_no++, "Adjective Count: \t\t$total_adjective_count");

}

if (defined $test_pre_string) {
	$test_pre_string = $test_pre_string." throatwarblermangrove";
} else {
	$test_pre_string = "throatwarblermangrove";
}

if (defined $test_pre_string_esus) {
	$test_pre_string_esus = $test_pre_string_esus." throatwarblermangrove";
} else {
	$test_pre_string_esus = "throatwarblermangrove";
}

#ATTENTION - are these skip hashes needed?
if (defined $test_pre_string) {
  my($temp_elem);
  my(@temp_array);

  if (($main_language eq "en-us") || ($target_language eq "en-us") || ($main_language eq "en-gb") || ($target_language eq "en-gb")) {
	(@skip_array) = split " ", $test_pre_string;
	foreach $elem1 (@skip_array) {
	  if ($elem1 !~ /\#/) {
		if ($elem1 =~ /\!/) {
		  (@temp_array) = split /\!/, $elem1;
		  $elem1 = $temp_array[0];
		} elsif ($elem1 =~ /\_/) {
		  (@temp_array) = split /\_/, $elem1;
		  foreach $temp_elem (@temp_array) {
			$spell_checker_hash{$temp_elem}++;
		  }

		  next;
		}

		$spell_checker_hash{$elem1}++;
#				$skip_hash{$elem1}++;
	  }
	}
  }
}

if (defined $test_pre_string_esus) {
  my($temp_elem);
  my(@temp_array);

  if (($main_language eq "es-us") || ($target_language eq "es-us")) {
	(@skip_array) = split " ", $test_pre_string_esus;
	foreach $elem1 (@skip_array) {
	  if ($elem1 !~ /\#/) {
		if ($elem1 =~ /\!/) {
		  (@temp_array) = split /\!/, $elem1;
		  $elem1 = $temp_array[0];
		} elsif ($elem1 =~ /\_/) {
		  (@temp_array) = split /\_/, $elem1;
		  foreach $temp_elem (@temp_array) {
			$spell_checker_hash{$temp_elem}++;
		  }

		  next;
		}

		$spell_checker_hash{$elem1}++;
#				$skip_esus_hash{$elem1}++;
	  }
	}
  }
}

if (!$make_maingrammar) {
    $do_use_product_prefix = 0;
}

###########################################################
################## SET UP ARGUMENT Packages ###############
###########################################################

%findReference_args = (
					  FindReference_BR => \%store_FindReference_BR,
					  FindReference_ER => \%store_FindReference_ER,
					  FindReference_GR => \%store_FindReference_GR,
					  FindReference_KWN => \%store_FindReference_KWN,
					  FindReference_KWN_wordbag => \%store_FindReference_KWN_wordbag,
					  FindReference_MR => \%store_FindReference_MR,
					  FindReference_MR_reclassifications => \%store_FindReference_MR_reclassifications,
					  FindReference_MR_wordbag => \%store_FindReference_MR_wordbag,
					  FindReference_MR_wordbag_reclassifications => \%store_FindReference_MR_wordbag_reclassifications,
					  FindReference_focus_BR => \%store_FindReference_focus_BR,
					  FindReference_focus_ER => \%store_FindReference_focus_ER,
					  FindReference_focus_GR => \%store_FindReference_focus_GR,
					  FindReference_focus_KWN => \%store_FindReference_focus_KWN,
					  FindReference_focus_KWN_wordbag => \%store_FindReference_focus_KWN_wordbag,
					  FindReference_focus_MR => \%store_FindReference_focus_MR,
					  FindReference_focus_MR_reclassifications => \%store_FindReference_focus_MR_reclassifications,
					  FindReference_focus_MR_wordbag => \%store_FindReference_focus_MR_wordbag,
					  FindReference_focus_MR_wordbag_reclassifications => \%store_FindReference_focus_MR_wordbag_reclassifications,
					  BR_rule_assignment => \%BR_rule_assignment_hash,
					  BR_rule_nofire => \%BR_rule_nofire_hash,
					  ER_rule_assignment => \%ER_rule_assignment_hash,
					  ER_rule_nofire => \%ER_rule_nofire_hash,
					  GR_rule_assignment => \%GR_rule_assignment_hash,
					  GR_rule_nofire => \%GR_rule_nofire_hash,
					  MR_rule_assignment => \%MR_rule_assignment_hash,
					  MR_rule_nofire => \%MR_rule_nofire_hash,
			);

$wordnet_2_letter_words{"ai"}++;
$wordnet_2_letter_words{"am"}++;
$wordnet_2_letter_words{"ax"}++;
$wordnet_2_letter_words{"be"}++;
$wordnet_2_letter_words{"do"}++;
$wordnet_2_letter_words{"go"}++;
$wordnet_2_letter_words{"he"}++;
$wordnet_2_letter_words{"id"}++;
$wordnet_2_letter_words{"is"}++;
$wordnet_2_letter_words{"it"}++;
$wordnet_2_letter_words{"ma"}++;
$wordnet_2_letter_words{"me"}++;
$wordnet_2_letter_words{"pa"}++;
$wordnet_2_letter_words{"pi"}++;
$wordnet_2_letter_words{"up"}++;

%wordnet_args = (
				 add_wordnet_pos => \%add_wordnet_pos_hash,
				 add_wordnet_synonym => \%add_wordnet_synonym_hash,
				 alt_default_pos => \%alt_default_pos_hash,
				 alt_syn_default_pos => \%alt_syn_default_pos_hash,
				 auto_ordered_minus_max => \@auto_ordered_minus_max_array,
				 autotag_option => $autotag_option,
				 do_autotag => $do_autotag,
				 do_synonyms => $do_synonyms,
				 max_wordnet_count => $max_wordnet_count,
				 max_wordnet_sentence_length => $max_wordnet_sentence_length,
				 min_wordnet_frequency_adjective => $min_wordnet_frequency_adjective,
				 min_wordnet_frequency_noun => $min_wordnet_frequency_noun,
				 min_wordnet_frequency_verb => $min_wordnet_frequency_verb,
				 reverse_synonym_corrected => \%reverse_synonym_corrected_hash,
				 synonym_corrected => \%synonym_corrected_hash,
				 synonym_modified_corrected => \@synonym_modified_corrected_array,
				 synonym_option => $synonym_option,
				 wordnet => $wn,
				 wordnet_available => $wordnet_available,
				 wordnet_false_frequency => \%wordnet_false_frequency_hash,
				 wordnet_min => \%wordnet_min_hash,
				 wordnet_2_letter_words => \%wordnet_2_letter_words,
			);

if ($company_name eq "") {
  $company_name = "SampleApp"
}

%general_args = (
				 company_filter => $company_filter,
				 company_name => $company_name,
				 create_regexp => $do_create_regexp,
				 do_use_product_prefix => $do_use_product_prefix,
				 downcase_utt => $downcase_utt,
                                 filenames_are_unique => $filenames_are_unique,
				 filter_corpus => $filter_corpus,
				 full_vocab => \%full_vocab_hash,
				 generic_scale_factor => $generic_scale_factor,
				 grammar_type => $grammar_type,
				 grammarbase => $grammarbase,
				 just_keywords => \%just_keywords_hash,
				 language_suffix => $language_suffix,
				 main_grammar_name => $main_grammar_name,
				 main_language => $main_language,
				 make_vocab => $make_vocab,
				 min_freq => $min_freq,
				 normalization_level => $normalization_level,
				 no_tag_unknown => $do_no_tag_unknown,
				 product_prefix => \@product_prefix_array,
				 product_prefix_num => $product_prefix_num,
				 run_bats => $runbats,
				 spell_checker => \%spell_checker_hash,
				 split_train_test => $do_split_train_test,
				 taggedcorpusfile => $taggedcorpusfile,
				 target_language => $target_language,
				 test_reject_name => $test_reject_name,
				 tuning_version => $tuning_version,
				);

%cleaning_args = (
				  auto_class_grammar_search => $auto_class_grammar_search_string,
				  char_omit => \@char_omit_array,
				  class_grammar => \%class_grammar_hash,
				  clean_trans => \%clean_trans_hash,
				  correct_spelling_list => \@correct_spelling_list,
				  correct_spelling_test_string => $correct_spelling_test_string,
				  delete_char => \@delete_char_array,
				  exclude_nums => \@exclude_nums_array,
				  exclude_words => \@exclude_words_array,
				  expand_grammar => \@expand_grammar_array,
				  good_fragment_list => \%good_fragment_list_hash,
				  omit => \@omit_array,
				  removerepeats => $removerepeats,
				  response_exclusion => $response_exclusion_string,
				  response_exclusion_tags => $response_exclusion_string_tags,
				  ramble_exclusion => $ramble_exclusion_string,
				  top_skip => \%top_skip_hash,
				 );

%nuance_gsl_args = (
					all_gram_elems => \@all_gram_elems,
					pfsg_name => $pfsg_name,
					test_confirm_as => $test_confirm_as,
					test_slotname => $test_slotname,
				   );

%osr_args = (
			 addtestfile => $addtestfile,
			 add_dictionaries => \%add_dictionaries_hash,
			 all_gram_elems => \@all_gram_elems_nuance_speakfreely,
			 all_gram_elems_nuance_class_full_xml => \@all_gram_elems_nuance_class_full_xml_array,
			 test_confirm_as => $test_confirm_as_nuance_speakfreely,
			 test_slotname => $test_slotname_nuance_speakfreely,
			 training_items => \%training_items_hash,
			 training_fragment_items => \@training_fragment_items_array,
			 training_stem_items => \@training_stem_items_array,
			 training_stop_items => \@training_stop_items_array,
			);

%speakfreely_args = (
					 do_normal_slm => $do_normal_slm_speakfreely,
					 do_robust_parsing => $do_robust_parsing_speakfreely,
					 swisrsdk_location => $swisrsdk_location_speakfreely,
					);

%nuance9_args = (
				 do_normal_slm => $do_normal_slm_nuance9,
				 do_robust_parsing => $do_robust_parsing_nuance9,
				 training_ssm_items => \%training_ssm_items_hash,
				 add_dictionaries => \%add_dictionaries_nuance9_hash,
				 swisrsdk_location => $swisrsdk_location_nuance9,
				);

if (($main_language eq "en-us") || ($main_language eq "en-gb")) {
  foreach $elem ( sort { $a cmp $b } keys %alias_search_hash) {
	$elem =~ s/_alias//g;
	$elem =~ s/\^//g;
	$explicit_categories_hash{$elem}++;
  }
}

if ($main_language eq "es-us") {
  foreach $elem ( sort { $a cmp $b } keys %alias_search_esus_hash) {
	$elem =~ s/_alias//g;
	$elem =~ s/\^//g;
	$explicit_categories_hash{$elem}++;
  }
}

%meaning_args = (
				 External_Rule_count => $external_Rule_count,
				 General_Rule_count => $general_Rule_count,
				 Main_Ambig_Rule_count => $main_Ambig_Rule_count,
				 Main_Rule_count => $main_Rule_count,
				 alias_exclusion => \%alias_exclusion_hash,
				 alias_search => \%alias_search_hash,
				 alias_search_esus => \%alias_search_esus_hash,
				 app_nouns => $test_app_nouns,
				 app_nouns_esus => $test_app_nouns_esus,
				 app_past_verbs => $test_app_past_verbs,
				 app_past_verbs_esus => $test_app_past_verbs_esus,
				 app_present_additional_verbs_esus => $test_app_present_additional_verbs_esus,
				 app_present_verbs => $test_app_present_verbs,
				 app_present_verbs_esus => $test_app_present_verbs_esus,
				 apply_ambig_rules => \%apply_ambig_rules_hash,
				 apply_rules => \%apply_rules_hash,
				 check_skip => \%check_skip_hash,
				 confirm_as => $test_confirm_as,
				 confirm_as_nuance_speakfreely => $test_confirm_as_nuance_speakfreely,
				 explicit_categories => \%explicit_categories_hash,
				 external_rules => \%external_rules_hash,
				 generic_rules => \%generic_rules_hash,
				 pre => \%pre_hash,
				 pre_app_specific_string => $test_pre_app_specific_string,
				 pre_app_specific_string_esus => $test_pre_app_specific_string_esus,
				 pre_string => $test_pre_string,
				 pre_string_esus => $test_pre_string_esus,
				 reject_name => $test_reject_name,
				 scan_language => $scan_language,
				 sentence_length_for_scan => $sentence_length_for_scan,
				 slotname => $test_slotname,
				 slotname_nuance_speakfreely => $test_slotname_nuance_speakfreely,
				 valid_restricted_end => \%valid_restricted_end_hash,
				 valid_restricted_general => \%valid_restricted_general_hash,
				);


############################################################################
# Fill Filter Arrays
############################################################################
#
FillFilterArrays (\%general_args, \%meaning_args, \%osr_args, \%app_hash);

############################################################################
# Read in/Write out  Known Categories and Open Output Files
############################################################################
#
if ($reclassfile_in ne "") {
	WriteNewCatsFile(\%general_args, \%cleaning_args, \%meaning_args, \%wordnet_args, "RECLASSIFICATION", $reclassfile_in, $reclassfile, $debug, $err_no, \%compressed_already_hash, \%wordlist_already_hash);

	if ($reclassfile_in ne "remove") {
		if (-e $reclassfile) {
			$reclassification_file = $reclassfile;
			$use_reclassifications = 1;
		}
	}
}

if (($do_read_catlist) || (($do_classify) && ($reclassification_file ne "")) || (($do_testparsefile || $do_testsentence) && ($reclassification_file ne ""))) {
	DebugPrint ("BOTH", 0, "Main::GetReclassInfo", $debug, $err_no++, "Loading Reclassifications File");

	if (($do_read_catlist) && ($reclassification_file eq "")) {
	  if (-e $reclassfile) {
		$reclassification_file = $reclassfile;
	  }
	}

	GetReclassInfo(\%general_args, \%findReference_args, $debug, $err_no, $reclassfile, $reclassification_file, \%reclass_hash);

	$use_reclassifications = 1;
}

if ($cmdopt{KnownCatsFile}) {
	$knowncatsfile_change = $cmdopt{KnownCatsFile};

	WriteNewCatsFile(\%general_args, \%cleaning_args, \%meaning_args, \%wordnet_args, "KNOWN CATEGORIES", $knowncatsfile_change, $knowncatsfile, $debug, $err, \%compressed_already_hash, \%wordlist_already_hash);
}
 
#if (($do_testparsefile || $do_classify || ($knowncatsfile_change ne ""))) {
#if (!do_read_catlist) {
if (((!$do_autotag) && (!$clean_only) && (!$do_synonyms && (!$do_write_data_files))) || $do_testsentence) {
	if ($make_maingrammar || $do_tagsdirect || $do_testparsefile || $do_testsentence || $do_classify || ($knowncatsfile_change ne "")) {
		DebugPrint ("BOTH", 0, "Main::GetKnownCatsInfo", $debug, $err_no++, "Loading Known Categories File");

		GetKnownCatsInfo(\%general_args, \%findReference_args, $debug, $err_no, $knowncatsfile, \%reclass_hash, \%truth_knowncats_hash, \%sentence_cat_hash);
	}
}

###########################################################
################## STANDALONE OPTIONS #####################
###########################################################

############################################################################
# Fill Reference Tag Hash
############################################################################
#
undef %referencetag_hash;
if ($referencetagfile ne "") {
	open(REFERENCETAGS,"<$referencetagfile") or die "cant open $referencetagfile";

   while(<REFERENCETAGS>) {
	   $line = ChopChar($_);

	   if ($line eq "") {
		   next;
	   }

	   if (substr($line,0,1) eq "#") {
		   next;
	   }

	   $referencetag_hash{lc($line)} = $line;
   }
}

############################################################################
# Write Data Files
############################################################################
#
if ($do_write_data_files) {
  if ($do_flatfile_transcriptions) {
	$input_is_transcription = 1;


	($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories) = BuildDataStrings_FlatFile($do_split_train_test, ($with_retag || $do_classify), \%general_args, \%cleaning_args, ($do_classify || $use_orig_trans), $parsefile, $tagged_sentence_file, $untagged_sentence_file, $retagged_categories_file, \%referencetag_hash);

	if ($contains_categories) {
	  WriteGenRefFile(\%general_args, $category_pre_search_string, $gen_referencetagfile);
	  CheckIntegrity1($do_classify, $pre_search_string, $filename_pre_search_string, $category_pre_search_string);
	}
  } else {
	my($grammar_pointer_default) = "G2";

	if ($grammar_pointer eq "") {
	  $grammar_pointer = $grammar_pointer_default;
	}

	($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription) = BuildDataStrings_Other($do_classify, $input_is_transcription, $parsefile, \@parsefile_array, $grammar_pointer, $grammar_type);
  }

  WriteDataStrings($pre_search_string, $filename_pre_search_string, $category_pre_search_string, $pre_search_string_count, $nl_total_records, $contains_categories, $input_is_transcription);

  writeTask();

  exit(0);
}

############################################################################
# Perform Retagging
############################################################################
#
if ($do_retag) {
	my($backup_filename);
	my($backup_successful);
	my($basecats_sentence_file) = "temp_basecats_sentences";
	my($category_conflicts) = "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts"."$language_suffix";
	my($category_keyword_conflicts) = "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts"."$language_suffix";
	my($filesize);
	my($init_string);
	my($r_mode) = "GET_PARTIAL_TAGS";
	my($readlen);
	my($retagged_counter);
	my($tagged_counter);
	my($tagged_found) = 0;
	my($template_file) = "slmdirect_results\/createslmDIR_temp_files\/temp_template";
	my($total_lines) = 0;
	my($total_string);
	my($tstring);
	my($tstring1);
	my($tstring2);
	my($tstring3);
	my($tstring4);
	my($unknown_counter) = 0;
	my($unknown_string);
	my($untagged_found) = 0;

	if (-e "slmdirect_template_nlrc") {
	  $template_file = "slmdirect_template_nlrc";
	  $r_mode = "GET_PARTIAL_TAGS_MINUS";
	} else {
	  open(TESTFILE,">$template_file") or die "cant open $template_file";

	  print TESTFILE "LO,background noise:background voices:bad-audio:breath:breath_noise:breath_noisne:clicks:cough:dtmf:expletive:garble:garbled:garbeld:hang-up:hang_up:mobile-phone:no speech:no-speech:other:pause:side_speech:speech-in-noise:system self-barge-in:system-self-barge-in:tones:transcription-error:within-car-noise:noise:non-native:bad-audio:ah:b:c:d:er:e:g:hm:h:ip:l:n:px:p:q:r:um:w:x:z\nCO,\\?:\\(:\\):\\*:,\nDC,~:-:umm:um:uh:ahhh:ahh:ah:er:eh:mm:errr:ab:ac:acc:ag:ano:auth:b:bala:c:ca:ch:co:cr:cu:d:de:di:dis:e:em:es:ex:f:g:h:i':j:k:l:li:n:o:op:p:paym:prog:r:recei:s:se:ser:sig:so:t:ta:w:x:y\n\n";

	  close (TESTFILE);
	}

	if ($use_basecats ne "") {
	  if (-e $use_basecats) {
		unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts";
		unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts";
		unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts_wordbag";

		CALL_SLMDirect(0, 0, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, "", "$template_file", "", $downcase_utt, $removerepeats, $use_basecats, "USE_BASECATS_PRELIM", $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "", "");

		if ((-e "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_conflicts") || (-e "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts") || (-e "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_filler_conflicts_wordbag")) {
		  DebugPrint ("BOTH", 2, "TagAssist", $debug, $err_no++, "Category conflicts and/or category/keyword/wordbag conflicts should be resolved before proceeding");

#		  unlink "temp_basecats_sentences_ready";
#		  unlink "temp_basecats_sentences_total";

#	writeTask();

#		  exit(0);
		}

		CALL_SLMDirect(0, 0, $vanilla_callingProg, $main_language, "", $grammarbase, $grammar_type, "", "slmdirect_results/createslm_init_nlrules", "", $downcase_utt, $removerepeats, $parsefile, "USE_BASECATS", $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", "");

		$parsefile = $basecats_sentence_file."_ready";
	  } else {
		DebugPrint ("BOTH", 2, "Main::TagAssist", $debug, $err_no++, "BaseCats File: $use_basecats Not Available.");
	  }
	}

	($tagged_found, $untagged_found, $total_lines) = SeparateTaggedSentences("TagAssist", $parsefile, $tagged_sentence_file, $untagged_sentence_file, $retagged_categories_file);

	if (!$tagged_found) {
		DebugPrint ("BOTH", 2, "TagAssist", $debug, $err_no++, "Sentence file is completely untagged.  NOTHING TO DO!");
	} elsif (!$untagged_found) {
		DebugPrint ("BOTH", 2, "TagAssist", $debug, $err_no++, "Sentence file is completely tagged.  NOTHING TO DO!");
	} else {
	  DebugPrint ("BOTH", 0, "TagAssist", $debug, $err_no++, "Analyzing hand-tagged sentences and creating parsing rules");
	  CALL_SLMDirect(0, 0, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, "", "$template_file", "", $downcase_utt, $removerepeats, $tagged_sentence_file, $r_mode, $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", "");

	  if ((-e "$category_conflicts") || (-e "$category_keyword_conflicts")) {
		DebugPrint ("BOTH", 2, "TagAssist", $debug, $err_no++, "Category conflicts and/or category/keyword/wordbag conflicts should be resolved before proceeding!");

#		unlink "temp_basecats_sentences_ready";
#		unlink "temp_basecats_sentences_total";

#	writeTask();

#		exit(0);
	  }

	  ($backup_filename, $backup_successful) = createBackup($parsefile);
	  if ($backup_successful) {
		DebugPrint ("BOTH", 0, "TagAssist", $debug, $err_no++, "Tagging sentences");
		CALL_SLMDirect(0, 0, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, "", "slmdirect_results/createslm_init_nlrules", "", $downcase_utt, $removerepeats, $untagged_sentence_file, "TAG_UNTAGGED", $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", "");

		open(TESTFILE,"<$tagged_sentence_file") or die "cant open $tagged_sentence_file";
		$filesize = -s TESTFILE;
		$readlen = sysread TESTFILE, $init_string, $filesize;
		close (TESTFILE);

		$tstring = $init_string;
		$tstring =~ s/\n//g;
		$tagged_counter = length($init_string) - length($tstring);

		open(TESTFILE,"<$classify_sentence_file") or die "cant open $classify_sentence_file";
		$filesize = -s TESTFILE;
		$readlen = sysread TESTFILE, $classify_string, $filesize;
		close (TESTFILE);

		if ($filesize == 0) {
		  $classify_string = "";
		} else {
		  $tstring = $classify_string;
		  $tstring =~ s/\n//g;
		  $retagged_counter = length($classify_string) - length($tstring);
		}

		open(TESTFILE,"<$classify_unknown_sentence_file") or die "cant open $classify_unknown_sentence_file";
		$filesize = -s TESTFILE;
		$readlen = sysread TESTFILE, $unknown_string, $filesize;
		close (TESTFILE);

		if ($filesize == 0) {
		  $unknown_string = "";
		} else {
		  $tstring = $unknown_string;
		  $tstring =~ s/\n//g;
		  $unknown_counter = length($unknown_string) - length($tstring);
		}

		$total_string = $init_string.$classify_string.$unknown_string;

		open(RETAGGED,">$parsefile") or die "cant write $parsefile";
		$total_string =~ s/( \t|\t )/\t/g;
		print RETAGGED "$total_string";
		close(RETAGGED);

		$tstring1 = sprintf("%3.2f", (($tagged_counter+$retagged_counter)/$total_lines)*100);
		$tstring2 = sprintf("%3.2f", ($tagged_counter/$total_lines)*100);
		$tstring3 = sprintf("%3.2f", ($retagged_counter/$total_lines)*100);
		$tstring4 = sprintf("%3.2f", ($unknown_counter/$total_lines)*100);
#$backup_filename
		if ($called_from_gui) {
		  $tstring = "Tag Assist Complete:\n\n\tBackup File created: $$backup_filename\n\n\tFile updated: $parsefile\n\n\tTotal sentences tagged: ".($tagged_counter+$retagged_counter)." (".$tstring1."%)\n\n\t\t"."Sentences tagged by hand:\t$tagged_counter\t"."(".$tstring2."%)\n\t\t"."Sentences auto-tagged:\t$retagged_counter\t"."(".$tstring3."%)\n\t\t"."Sentences still untagged:\t$unknown_counter\t"."(".$tstring4."%)";
		} else {
		  $tstring = "Tag Assist Complete:\n\n\tBackup File created: $$backup_filename\n\n\tFile updated: $parsefile\n\n\tTotal sentences tagged: ".($tagged_counter+$retagged_counter)." (".$tstring1."%)\n\n\t\t"."Sentences tagged by hand:\t$tagged_counter\t"."(".$tstring2."%)\n\t\t"."Sentences auto-tagged:\t\t$retagged_counter\t"."(".$tstring3."%)\n\t\t"."Sentences still untagged:\t$unknown_counter\t"."(".$tstring4."%)";
		}

		DebugPrint ("BOTH", 1, "TagAssist", $debug, $err_no++, "$tstring");
	  }
	}

	unlink "temp_basecats_sentences_ready";
	unlink "temp_basecats_sentences_total";

	writeTask();

	exit(0);
}

############################################################################
# Append a Test File
############################################################################
#
if ($appendtestfile ne "") {
  if ($appendtestfile eq "default") {
	$appendtestfile = "$repository\/slmdirect_results\/createslmDIR_truth_files\/createslm_applytags_test_input";
  } else {
	$appendtestfile = "$repository\/".$appendtestfile;
  }

  $trainingtestfile = getOutEncoding($main_language, $grammar_type)."$repository\/slmdirect_results\/$grammarbase"."_nuance_speakfreely_training.xml";

  open(TRAINING_nuance_speakfreely,"<$trainingtestfile") or die "cant open $trainingtestfile";
  open(APPENDTEST,"<$appendtestfile") or die "cant open $appendtestfile";

  (@training_contents_array) = (<TRAINING_nuance_speakfreely>);
  close(TRAINING_nuance_speakfreely);

  while(<APPENDTEST>) {
	$line = $_;

	if (substr($line,0,1) eq "#") {
	  next;
	}

	if ($line eq "") {
	  next;
	}

	$line = ChopChar($line);

	($filename, $corrected_sentence, $item_category) = split "\t", $line;

	if ((lc($corrected_sentence) !~ /__blank__/) && (lc($corrected_sentence) ne "0") && (lc($item_category) !~ /blank/)) {
	  if ($corrected_sentence ne "") {
#		PutInVocab("AppendTestFile", 1, \%full_vocab_hash, $corrected_sentence);
		$test_hash{$corrected_sentence}{$item_category}++;
	  }
	}
  }

  close(APPENDTEST);

  $trainingwithtestfile = getOutEncoding($main_language, $grammar_type)."$repository\/slmdirect_results\/$grammarbase"."_nuance_speakfreely_training_with_test.xml";

  open(TRAINING_nuance_speakfreely_append,">$trainingwithtestfile") or die "cant write $trainingwithtestfile";
  $transition1 = 0;
  $transition2 = 0;
  $transition3 = 0;
  $transition4 = 0;
  for($i = 0; $i < scalar(@training_contents_array); $i++) {
	$line = $training_contents_array[$i];
	if (!$transition1) {
	  if ($line !~ /<vocab>/) {
		print TRAINING_nuance_speakfreely_append "$line";
	  } else {
		$transition1 = 1;
		next;
	  }
	} else {
	  if (!$transition2) {
		if ($line !~ /<stop>/) {
		  if ($line =~ /<item>((\w|\_|\')+)<\/item>/) {
			$full_vocab_hash{$1}++;
		  } elsif ($line =~ /ruleref uri/) {
			$full_vocab_hash{$line}++;
		  }
		} else {
		  $transition2 = 1;
		  next;
		}
	  } else {
		if (!$transition3) {
		  if ($line !~ /<training>/) {
			if ($line =~ /<item>((\w|\_|\')+)<\/item>/) {
			  $stop_word_hash{$1}++;
			}
		  } else {
			if (scalar(keys %full_vocab_hash) > 0) {
			  print TRAINING_nuance_speakfreely_append "<vocab>\n";
			  foreach $elem ( sort { $a cmp $b } keys %full_vocab_hash) {
				printf(TRAINING_nuance_speakfreely_append "<item>%s</item>\n", $elem);
			  }

			  print TRAINING_nuance_speakfreely_append "</vocab>\n\n";
			}

			if (scalar(keys %stop_word_hash) > 0) {
			  print TRAINING_nuance_speakfreely_append "<\!-- STOP WORDS -->\n";
			  printf(TRAINING_nuance_speakfreely_append "<stop>\n", $elem1);
			  foreach $elem ( sort { $a cmp $b } keys %stop_word_hash) {
				printf(TRAINING_nuance_speakfreely_append "\t<item>%s</item>\n", $elem);
			  }

			  print TRAINING_nuance_speakfreely_append "</stop>\n";
			}

			print TRAINING_nuance_speakfreely_append "<training>\n";
			$transition3 = 1;
			next;
		  }
		} else {
		  if (!$transition4) {
			if ($line !~ /<\/SpeakFreelyConfig>/) {
			  print TRAINING_nuance_speakfreely_append "$line";
			} else {
			  print TRAINING_nuance_speakfreely_append "<test>\n";
			  foreach $elem1 ( sort { $a cmp $b } keys %test_hash) {
				foreach $elem2 ( sort { $a cmp $b } keys %{ $test_hash{$elem1} }) {
				  print TRAINING_nuance_speakfreely_append "<sentence meaning=\"".$test_slotname_nuance_speakfreely.":",$elem2,":".$test_confirm_as_nuance_speakfreely.":",$elem2,"\" count=\"", $test_hash{$elem1}{$elem2},"\">\n";
				  print TRAINING_nuance_speakfreely_append "    $elem1\n";
				  print TRAINING_nuance_speakfreely_append "</sentence>\n";
				}
			  }

			  print TRAINING_nuance_speakfreely_append "</test>\n\n";
			  print TRAINING_nuance_speakfreely_append "$line";

			  $transition4 = 1;
			  next;
			}
		  } else {
			  print TRAINING_nuance_speakfreely_append "$line";
		  }
		}
	  }
	}
  }

  close(TRAINING_nuance_speakfreely_append);

  writeTask();

  exit(0);

}

############################################################################
# Perform Translation
############################################################################
#
if ($do_transcat) {
	my($cat_sentence_file);
	my($default_cat_sentence_file) = "slmdirect_results\/createslmDIR_info_files\/info_init_sentence_category_assignment";;
	my($default_trans_file) = "trans_file_".$main_language;
	my($eng_rules) = "";
	my($old_rules_file) = "";
	my($trans_file);
	my($use_cat_sentence_file) = $default_cat_sentence_file;

	if ($transcat_file ne "defaults") {
		($trans_file, $cat_sentence_file, $eng_rules, $old_rules_file) = split ":", $transcat_file;

		if ($trans_file eq "") {
			$trans_file = $default_trans_file;
		}

		if ($cat_sentence_file ne "") {
			$use_cat_sentence_file = $cat_sentence_file;
		}
	}

	TransCatList(\%general_args, $trans_file, \%trans_hash, $use_cat_sentence_file, $eng_rules, $old_rules_file, $do_tagsdirect);

	if (!($do_tagsdirect || $do_read_catlist)) {
	  writeTask();

	  exit(0);
	}
}

############################################################################
# Read New Categories File
############################################################################
#
if ($do_read_newcats) {
	ReadNewCats(\%general_args, \%cleaning_args, $parsefile, $old_rules_file);

	writeTask();

	exit(0);
}

############################################################################
# Check Category Integrity
############################################################################
#
if ($do_checkcats) {

	CheckCats($checkcats_files, $test_reject_name);

	writeTask();

	exit(0);
}

############################################################################
# Process TestSentenceAmplify Options
############################################################################
#
if ($do_filtertestline) {
  print "\nReady\n";

  while (<STDIN>) {
	AssignLineType(\%general_args, \%meaning_args, \%wordnet_args, $_, "", "STDIN", $debug, \%app_hash, \%pre_phrases_hash, \%grammar_elems_hash, \%grammar_elems_other_hash, 0, "");
  }

  writeTask();

  exit(0);
}

#############################################################################
# Read in the Category List (for all options relating to Category Processing)
#############################################################################
#
if ($cat_file_init eq "") {
  $cat_file_init = $parsefile;
}

if (($do_read_catlist) || ((!$do_tagsdirect) && (($cat_file_init ne "") && ($infile ne "STDIN")))) {
  if (!$do_tagsdirect) {
# Open single or multiple Parse File(s)
	if ($cat_file_init =~ /\=/) {
	  (@parsefile_array) = split ",", $cat_file_init;
	  $grammar_pointer = "___MULTI___";
	  $do_flatfile_transcriptions = 0;
	} else {
	  if (substr($cat_file_init, length($cat_file_init),1) eq "/") {
		$cat_file_init = substr($cat_file_init, 0, length($cat_file_init)-1);
	  }

	  if (!opendir("PARSE", $cat_file_init)) {
		open(PARSE,"<$cat_file_init") or die "cant open $cat_file_init";
	  } else {
		$do_flatfile_transcriptions = 0;
		closedir("PARSE");
	  }
	}
  }

  if ($do_read_catlist) {
	$make_vocab = 1;
  }

  if ($grammar_pointer eq "___MULTI___") {
	DebugPrint ("BOTH", 0, "Main::CheckForTranscriptions", $debug, $err_no++, "Reading Input File(s)");
  } else {
	DebugPrint ("BOTH", 0, "Main::CheckForTranscriptions", $debug, $err_no++, "Reading Input File: $cat_file_init");
  }

  if ($with_retag) {
	$w_mode = "WRITEDATAFILES_WITHRETAG";
  }

# Check for Transcriptions
  CALL_SLMDirect($do_split_train_test, $do_create_regexp, $vanilla_callingProg, $main_language, $target_language, $grammarbase, $grammar_type, "", $nlrc_template_name, "", $downcase_utt, $removerepeats, "$cat_file_init", $w_mode, $repository, $called_from_gui, $referencetagfile, $use_trad_trans, "$classifyfileout", $autotag_option);

  ($main_search_string, $sentence_order, $synonym_sentence_order, $cat_file_init, $make_truth_files, $err_no, $nl_total_records, $nl_blank_utts) = CheckForTranscriptions(\%general_args, \%wordnet_args, \%cleaning_args, \%meaning_args, \%osr_args, \%findReference_args, $do_tagsdirect, $do_split_train_test, $do_read_catlist, $do_classify, $cat_file_init, $clean_only, $debug, $do_filtercorpus_direct, $do_flatfile_transcriptions, $do_tagging, $do_testsentence, $do_transcat, $dont_clean, $err_no, $filter_corpus, $filtercorpus_direct_in, $filtercorpusfileout, $gen_referencetagfile, $grammar_pointer, $keep_fragment_length, $knowncatsfile, $max_filter_sentence_length, $merge_nouns, $merge_verbs, $nl_blank_utts, $nl_total_records, $test_confirm_as, $test_confirm_as_nuance_speakfreely, $test_filter_multiplier, $test_slotname, $test_slotname_nuance_speakfreely, \%app_hash, \%ending_adjective_hash, \%ending_noun_hash, \%ending_verb_hash, \%gram_elem_cat_hash, \%keyword_2_filtered_utt_hash, \%merge_noun_prefix_hash, \%merge_noun_verb_alias_hash, \%merge_verb_prefix_hash, \%pre_hash, \%reclass_hash, \%sentence_cat_assignments_hash, \%sentence_cat_hash, \%trans_hash, \%truth_knowncats_hash, \%wordbag_keyword_2_filtered_utt_hash, \@compressed_alias_sentence_array, \@compressed_sentence_array, \@original_cat_array, \@original_transcription_array, \@original_wavfile_array, \%compressed_already_hash, \%wordlist_already_hash, \%gen_grammar_elem_hash, \%allow_general_hash, \%changed_utt_repeat_hash, \%disallow_general_hash, $do_addmainrules_only, $do_include_garbagereject, \%gsl_filler_hash, $rule_multiplier, $utt_source, $vocabfile, \@corrected_array);
}

if ($do_read_catlist) {
	if (!($do_transcat || $do_tagsdirect || $do_split_train_test)) {
	  writeTask();

	  exit(0);
	}
}

############################################################################
# Make Rules from input Category List
############################################################################
#
if ($do_make_nlrule_init) {
	MakeCatList2(\%general_args, \%cleaning_args, \%meaning_args, $cat_nl_rules, $nlrc_template_name, $container_file_in, $do_filtercorpus_direct, $do_tagsdirect, $do_make_nlrule_init_test, $dont_do_additional_command_vars, $vocabfile, $do_put_defaults);

	if (!$do_tagsdirect) {
	  writeTask();

	  exit(0);
	}
}

###########################################################
################## END STANDALONE OPTIONS #################
###########################################################

###########################################################
################## Main Routines (Not Direct Generation) ##
###########################################################

if (!$do_tagsdirect) {
	if (($parsefile ne "") && ($infile ne "STDIN")) {
		if (($tuning_version eq "") && ($addtestfile eq "") && !$do_classify) {
			$make_truth_files = 0;
		}

		if ($make_truth_files) {
			close(CLASSIFYFILEOUT);
			unlink "slmdirect_results\/$classifyfileout";
			open(CLASSIFYFILEOUT,">"."slmdirect_results\/$classifyfileout"."_total") or die "cant write "."slmdirect_results\/$classifyfileout"."_total";
			$failparsefile = "slmdirect_results\/$classifyfileout";
		}

		if ($parsefile ne $prev_parsefile) {
			close(PARSE);

			open(PARSE,"<$parsefile") or die "cant open $parsefile";
		}
	}

	undef %app_hash;
	undef %pre_phrases_hash;
	undef %grammar_elems_hash;
	undef %grammar_elems_other_hash;

############################################################################
# Main Loop
############################################################################
#
	if ($make_maingrammar || $do_testsentence || $do_testparsefile || $do_classify || $filter_corpus) {

		if (($infile eq "STDIN") && !$webSwitch) {
			($main_language, $scan_language, $grammar_type, $max_wordnet_count, $min_wordnet_frequency_noun, $min_wordnet_frequency_verb, $min_wordnet_frequency_adjective, $max_wordnet_sentence_length, $synonym_option, $do_synonyms, $pre_search_string) = interpretCommand(\%general_args, \%wordnet_args, "+h", $main_language, $scan_language, $grammar_type, \@sentence_entered_array, \@command_entered_array);

			print "Ready\n";
		}

		while (1) {
			if ($do_testsentence && !$webSwitch) {
				print "\n";
			}

			if ($infile eq "STDIN") { 
				$sentence_order = 0;
				if ($webSwitch) {
				  $pre_search_string = $parsefile;
				} else {
				  $pre_search_string = (<STDIN>);
				}

				$pre_search_string = ProcessCharsInitial($pre_search_string);

				if ($pre_search_string eq "") {
					next;
				}

				if ((substr($pre_search_string,0,1) eq "+") || (substr($pre_search_string,0,1) eq "-")){
					($main_language, $scan_language, $grammar_type, $max_wordnet_count, $min_wordnet_frequency_noun, $min_wordnet_frequency_verb, $min_wordnet_frequency_adjective, $max_wordnet_sentence_length, $synonym_option, $do_synonyms, $pre_search_string) = interpretCommand(\%general_args, \%wordnet_args, $pre_search_string, $main_language, $scan_language, $grammar_type, \@sentence_entered_array, \@command_entered_array);

					if (($do_autotag || $do_synonyms) && $wordnet_available) {
					  $wordnet_min_hash{"all"} = $min_wordnet_frequency_noun;
					  $wordnet_min_hash{"noun"} = $min_wordnet_frequency_noun;
					  $wordnet_min_hash{"verb"} = $min_wordnet_frequency_verb;
					  $wordnet_min_hash{"adjective"} = $min_wordnet_frequency_adjective;
					}

					if ((substr($pre_search_string,0,1) eq "+") || (substr($pre_search_string,0,1) eq "-")){
					  next;
					}
				}

				push @sentence_entered_array,  $pre_search_string;

				$pre_search_string = $pre_search_string."º";

				if ($downcase_utt) {
					$pre_search_string = lc($pre_search_string);
				}

				@original_transcription_array = ();
				@original_wavfile_array = ();
				@corrected_array = ();
				@compressed_sentence_array = ();

				undef %BR_rule_assignment_hash;
				undef %ER_rule_assignment_hash;
				undef %GR_rule_assignment_hash;
				undef %MR_rule_assignment_hash;

				($main_search_string, $sentence_order, $synonym_sentence_order) = createSearchString(\%general_args, \%cleaning_args, \%meaning_args, \%wordnet_args, $do_classify, $do_testsentence, $pre_search_string, \@corrected_array, \@original_transcription_array, \@original_wavfile_array, \@compressed_sentence_array, \@compressed_alias_sentence_array, \@original_cat_array, \%synfile_hash, \%ending_noun_hash, \%ending_verb_hash, \%ending_adjective_hash, \%compressed_already_hash);

			}

			if ($infile ne "STDIN") {
				close(PARSE);
			}

#############################################################################
# Apply Rules to each sentence in the input corpus
############################################################################
#
			if ($infile ne "STDIN") {
				if ($do_autotag) {
				  DebugPrint ("BOTH", 0, "Main::ApplyParsingRules", $debug, $err_no++, "Applying Rules to ".($sentence_order-1)." sentences");
				} else {
				  DebugPrint ("BOTH", 0, "Main::ApplyParsingRules", $debug, $err_no++, "Applying Rules to $sentence_order sentences");
				}
			}

#			ApplyParsingRules(\%general_args, \%meaning_args, "", $infile, $sentence_order, $main_search_string, \@corrected_array, \@compressed_sentence_array, \%store_FindReference_KWN, \%BR_rule_assignment_hash, \%BR_rule_nofire_hash, \%ER_rule_assignment_hash, \%ER_rule_nofire_hash, \%GR_rule_assignment_hash, \%GR_rule_nofire_hash, \%MR_rule_assignment_hash, \%MR_rule_nofire_hash, \%compressed_already_hash);

			ApplyParsingRules(\%general_args, \%meaning_args, \%findReference_args, "", $infile, $sentence_order, $main_search_string, \@corrected_array, \@compressed_sentence_array, \%compressed_already_hash);

			if ($do_synonyms && $wordnet_available) {
				$synonym_threshold = $sentence_order;
				if ($synonym_sentence_order != -1) {
					$sentence_order = $synonym_sentence_order;
				}

				$syn_wordfreq_sentence = "";
				foreach $elem ( sort { $a cmp $b } keys %synfile_hash) {
				  $syn_wordfreq_sentence = stringBuilder($syn_wordfreq_sentence, $elem, " ");
				}

				$syn_wordfreq_sentence =~ s/\t/ /g;
				$syn_wordfreq_sentence = TrimChars($syn_wordfreq_sentence);
				$syn_wordfreq_sentence = $syn_wordfreq_sentence." ";

				$syn_wordfreq_sentence =~ s/(\D|\_|\')+\s/ /g;
				$syn_wordfreq_sentence = TrimChars($syn_wordfreq_sentence);

				$syn_wordfreq_sentence = TrimChars($syn_wordfreq_sentence);


				(@syn_wordfreq_array) = split " ", $syn_wordfreq_sentence;
				@unique_array = grep {! $seen_hash{$_} ++ } @syn_wordfreq_array;
				undef %seen_hash;
				undef %synfile_hash;
			} else {
				$synonym_threshold = 400000000000;
			}

			if ($infile ne "STDIN") {
				DebugPrint ("BOTH", 0, "Main", $debug, $err_no++, "Determining Source of Tags");
			}

#############################################################################
# Determine Source Assignment of every Sentence
############################################################################
#
			$done_reapply_parsingrules = 0;
			$loop_count = 0;

			$j = 0;
			for ($i = 0; $i < $sentence_order; $i++) {
				if ($i >= $synonym_threshold) {
					$assignment_source = "SYNONYM";
					$changed_utt = $corrected_array[$i];
					if ($do_testsentence) {
						$changed_utt = $synonym_modified_corrected_array[$i];
					}
					$wavfilename = $original_wavfile_array[$i];
					$item_category = $assignment_hash{$synonym_corrected_hash{$i}};
					$item_id = $changed_utt;
				} else {
					($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled) = DetermineSourceAssignment (\%general_args, \%meaning_args, \%wordnet_args, \%findReference_args, $i, $j, \*$failparsefile_write_out, \*$failparsefile_write_out_catonly, \*CLASSIFYFILEOUT_VANILLA, \*CLASSIFYFILEOUT_UNKNOWN, $expand_vanilla, \@corrected_array, \@original_wavfile_array, $make_failparse, $do_classify, $do_testparsefile, $do_testsentence, $nl_total_records, $nl_blank_utts, $nl_not_handled, $use_reclassifications, \@compressed_sentence_array, \@original_transcription_array, \%classify_truth_hash, \%rule_sentence_hash, \@focus_item_id_array, \%check_expand_hash, \%classify_result_hash, $do_suppress_grammar, \%compressed_already_hash, \%wordlist_already_hash);

					if ($do_synonyms && $wordnet_available) {
						if ($item_category eq "") {
							if (!$done_reapply_parsingrules) {
								ApplyParsingRules(\%general_args, \%meaning_args, \%findReference_args, "", $infile, $sentence_order, $main_search_string, \@corrected_array, \@compressed_sentence_array, \%compressed_already_hash);
								$done_reapply_parsingrules = 1;
							}

							$j = 0;
							$syn_found = -1;
							foreach $k ( sort { $a cmp $b } keys %{$reverse_synonym_corrected_hash{$i}}) {
								($j, $assignment_source, $changed_utt, $wavfilename, $item_category, $item_id, $nl_total_records, $nl_blank_utts, $nl_not_handled) = DetermineSourceAssignment (\%general_args, \%meaning_args, \%wordnet_args, \%findReference_args, $k, $j, \*$failparsefile_write_out, \*$failparsefile_write_out_catonly, \*CLASSIFYFILEOUT_VANILLA, \*CLASSIFYFILEOUT_UNKNOWN, $expand_vanilla, \@corrected_array, \@original_wavfile_array, $make_failparse, $do_classify, $do_testparsefile, $do_testsentence, $nl_total_records, $nl_blank_utts, $nl_not_handled, $use_reclassifications, \@compressed_sentence_array, \@original_transcription_array, \%classify_truth_hash, \%rule_sentence_hash, \@focus_item_id_array, \%check_expand_hash, \%classify_result_hash, $do_suppress_grammar, \%compressed_already_hash, \%wordlist_already_hash);

								if ($item_category ne "") {
									$syn_found = $k;
									last;
								}
							}
						}
					}

					if ($changed_utt eq "") {
						$item_category = "";
					}

					$assignment_hash{$i} = $item_category;
				}

############################################################################
# Collect Sentence Components for Building Grammars
############################################################################
#

				if (($item_category ne "") && ($item_id ne "")){
					$nl_product{$item_category}++;
					$nl_product_utt{$item_category}{$item_id}++;
				}

				if (($item_category ne "") && (lc($item_category) ne lc($test_reject_name)) || (($item_category ne "") && ($assignment_source !~ /Stored/) && (lc($changed_utt) !~ /\*blank\*/) && ((lc($item_category) eq lc($test_reject_name)) && $do_include_garbagereject && ($do_testsentence || $do_testparsefile)))) {
					if ($do_testsentence || $do_testparsefile) {
						$focus_item_id_array[0] = $changed_utt;
						$direction = "";
						if ($do_testsentence && $webSwitch) {
						  $direction = "to_string";
						}

						$webOutString = Write_Output_Format(\%general_args, \%cleaning_args, $direction, $assignment_source, $changed_utt, \*$write_out, \*$write_out_catonly, $do_testsentence, $company_filter, \@focus_item_id_array, $ambig_active, $item_category, "<$test_slotname \"%s\">\t<$test_confirm_as \"%s\">\n", "<ambig_key \"%s\">\t<$test_confirm_as \"%s\">\n", "<tag>$test_slotname_nuance_speakfreely=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag><tag>category=\'%s\'</tag>\n", "<tag>ambig_key=\'%s\'</tag><tag>$test_confirm_as_nuance_speakfreely=\'%s\'</tag><tag>category=\'%s\'</tag>\n", $loop_count);

						if ($do_testsentence && $webSwitch) {
						  print "$webOutString\n";
						}

						$loop_count++;
					}

					if ($do_classify) {
						Classify_Output_Format(\%general_args, \%meaning_args, \%wordnet_args, $i, \@corrected_array, \%keyword_2_filtered_utt_hash, \%wordbag_keyword_2_filtered_utt_hash, \*$write_out, \*$write_out_catonly, \*CLASSIFYFILEOUT_VANILLA, \*CLASSIFYFILEOUT_UNKNOWN, $wavfilename, $assignment_source, $changed_utt, \%classify_truth_hash, \@original_transcription_array, $item_category, \%classify_result_hash, $do_suppress_grammar, \%wordlist_already_hash, \%referencetag_hash);
					}

					if ($make_maingrammar) {
						$temp_test_reject_name = lc($test_reject_name);
						if (($do_include_garbagereject) || (lc($item_category) !~ /$temp_test_reject_name/)) {
							$filtered_utt = $changed_utt;

							$new_cats_hash{$item_category}{$original_wavfile_array[$i]}{$original_transcription_array[$i]}++;
							FillGrammarElements(\%general_args, \%gen_grammar_elem_hash, 1, $changed_utt, $filtered_utt, $item_category, $ambig_active, $grammar_type, $utt_source);
						}
					}
				}
			} # END MAIN LOOP

			if ((!$do_testsentence) || ($webSwitch)) {
				last;
			}
		}
	}

	unlink "slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_ready";
	unlink "slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_uniq";
	if ((scalar keys %new_cats_hash) > 0) {
	  @temp_cat_array = ();
	  @temp_cat_array_uniq = ();
		open(NEWCAT,">"."slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_ready") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_ready";
		open(NEWCATUNIQ,">"."slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_uniq") or die "cant write "."slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_uniq";
		DebugPrint ("BOTH", 0, "Main", $debug, $err_no++, "Writing New Tagged Sentences to "."slmdirect_results\/createslmDIR_info_files\/info_rule_tagged_sentences_*");
		foreach $elem ( sort { $a cmp $b} keys %new_cats_hash) {
		  push @temp_cat_array, $elem;
			foreach $elem1 ( sort { $a cmp $b } keys %{$new_cats_hash{$elem}}) {
				foreach $elem2 ( sort { $a cmp $b } keys %{$new_cats_hash{$elem}{$elem1}}) {
					for ($i = 0; $i < $new_cats_hash{$elem}{$elem1}{$elem2}; $i++) {
						print NEWCAT "$elem1\t$elem2\t$elem\n";
					}

					print NEWCATUNIQ "$elem1\t$elem2\t$elem\n";
				}
			}
		}

		close(NEWCAT);
		close(NEWCATUNIQ);

	  if (!($do_tagsdirect || $do_filtercorpus_direct)) {
		@temp_cat_array_uniq = grep {! $cat_seen_hash{$_} ++ } @temp_cat_array;

		undef %cat_seen_hash;
		@temp_cat_array = ();

		foreach $elem (@temp_cat_array_uniq) {
		  $cat_seen_hash{uc($elem)}{$elem}++;
		}

		if ($gen_referencetagfile ne "") {
		  $genref_string = join "\n", sort { $a cmp $b } @temp_cat_array_uniq;
		  $genref_string = $genref_string."\n";

		  open(GENREF,">"."slmdirect_results\/$gen_referencetagfile") or die "cant open "."slmdirect_results\/$gen_referencetagfile";
		  print GENREF "$genref_string\n";
		  close(GENREF);
		}

		open(CATERROR,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch"."$language_suffix";

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
		  unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch"."$language_suffix";
		} else {
		  DebugPrint ("BOTH", 2, "Main", $debug, $err_no++, "CATEGORY NAMING CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_category_spelling_mismatch"."$language_suffix");
		}
	  }
	}

	undef $main_search_string;

	%cat_args = (
				 do_precision_recall => $do_precision_recall,
				 knowncats => $knowncatsfile,
				 sentence_cat_assignments => \%sentence_cat_assignments_hash,
				 truth_knowncats => \%truth_knowncats_hash,
				 heavy_categories => \%heavy_categories_hash,
				 include_garbagereject => $do_include_garbagereject,
				);

###########################################################
################## Make TRUTH Files ###################
###########################################################

	if ($make_truth_files) {
		makeTruthFiles(\%general_args, \%osr_args, \%cat_args, 1, $use_previous_test_sequence, $test_sequence, \%temp_total_truth_hash, \%classify_truth_hash);
	}

	undef %temp_total_truth_hash;
	undef %classify_truth_hash;


###########################################################
################## Write out VOCAB file ###################
###########################################################

	WriteVocabs (\%general_args, \%cleaning_args, \%meaning_args, $vocabfile);

###########################################################
################## Close Output files #####################
###########################################################
	if ($make_failparse) {
		if ($failparsefile ne "STDOUT") {
			if ((lc($failparsefile) ne lc($testparsefileout)) && (lc($failparsefile) ne lc($classifyfileout))) {
				close(FAILPARSEFILE);
			}
		}
	}

	if ($do_testparsefile) {
		if ($testparsefileout ne "STDOUT") {
			close(TESTPARSEFILEOUT);
			close(TESTPARSEFILEOUT_CATONLY);
		}
	}

	if ($do_classify) {
		if ($classifyfileout ne "STDOUT") {
			my($conflicts_found) = 0;
			open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts";
			foreach $elem ( sort { $a cmp $b} keys %keyword_2_filtered_utt_hash) {
				if (scalar (keys %{$keyword_2_filtered_utt_hash{$elem}}) > 1) {
					$conflicts_found = 1;
					print KEYOUT "$elem:\n";
					foreach $elem1 ( sort { $a cmp $b } keys %{$keyword_2_filtered_utt_hash{$elem}}) {
						print KEYOUT "\t$elem1:\n";
						foreach $elem2 ( sort { $a cmp $b } keys %{$keyword_2_filtered_utt_hash{$elem}{$elem1}}) {
							print KEYOUT "\t\t$elem2\n";
						}
					}

					print KEYOUT "\n";

				}
			}

			close(KEYOUT);

			if ($conflicts_found) {
				DebugPrint ("BOTH", 2, "Main::CLASSIFY_1", $debug, $err_no++, "APPLYTAGS CATEGORY CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts");
			} else {
				unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts";
			}

			$conflicts_found = 0;
			open(KEYOUT,">"."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts_wordbag") or die "cant open "."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts_wordbag";
			foreach $elem ( sort { $a cmp $b} keys %wordbag_keyword_2_filtered_utt_hash) {
				if (scalar (keys %{$wordbag_keyword_2_filtered_utt_hash{$elem}}) > 1) {
					$conflicts_found = 1;
					print KEYOUT "$elem:\n";
					foreach $elem1 ( sort { $a cmp $b } keys %{$wordbag_keyword_2_filtered_utt_hash{$elem}}) {
						print KEYOUT "\t$elem1:\n";
						foreach $elem2 ( sort { $a cmp $b } keys %{$wordbag_keyword_2_filtered_utt_hash{$elem}{$elem1}}) {
							print KEYOUT "\t\t$elem2\n";
						}
					}

					print KEYOUT "\n";

				}
			}

			close(KEYOUT);

			if ($conflicts_found) {
				DebugPrint ("BOTH", 2, "Main::CLASSIFY_2", $debug, $err_no++, "WORDBAG APPLYTAGS CATEGORY CONFLICTS: in "."slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts_wordbag");
			} else {
				unlink "slmdirect_results\/createslmDIR_analyze_files\/analyze_classify_category_conflicts_wordbag";
			}

			close(CLASSIFYFILEOUT);
			close(CLASSIFYFILEOUT_READY);
			close(CLASSIFYFILEOUT_VANILLA);
			close(CLASSIFYFILEOUT_UNKNOWN);
		}

		if (!$do_suppress_grammar) {
			DebugPrint ("BOTH", 1, "Main::CLASSIFY_3", $debug, $err_no++, "APPLYTAGS: Files "."slmdirect_results\/$classifyfileout"."\* created");

			foreach $elem ( sort { $a cmp $b} keys %classify_result_hash) {
				open(CLASSOUT,">"."slmdirect_results\/createslmDIR_applytags_files\/$classifyfileout"."_"."$elem") or die "cant open "."slmdirect_results\/createslmDIR_applytags_files\/$classifyfileout"."_"."$elem";
				foreach $elem1 ( sort { $a cmp $b} keys %{$classify_result_hash{$elem}} ) {
					print CLASSOUT "$elem1\n";
				}

				close(CLASSOUT);
			}

			DebugPrint ("BOTH", 1, "Main::CLASSIFY_4", $debug, $err_no++, "APPLYTAGS TAG SOURCE: Files "."slmdirect_results\/createslmDIR_applytags_files\/$classifyfileout"."\* created");
		} else {
		  unlink "slmdirect_results\/$classifyfileout"."_ready";
		  unlink "slmdirect_results\/$classifyfileout"."_total";
		  unlink "slmdirect_results\/createslm_applytags_vocab_uniq.sorted";
		  unlink "slmdirect_results\/createslm_applytags_vocab_uniq.sorted_minus_skip_words";
		}
	}

###########################################################
################## Write out Compare Rules files ##########
###########################################################
	if ((scalar keys %rule_sentence_hash) > 0) {
		unlink "slmdirect_results\/createslmDIR_temp_files\/temp_rulesfired";
		unlink "slmdirect_results\/createslmDIR_temp_files\/temp_rulesconflict";

		open(COMPRULESFILE,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_rulesfired") or die "cant write COMPRULESFILE";
		foreach $elem ( sort { $a cmp $b} keys %rule_sentence_hash) {
			foreach $elem1 ( sort { $a cmp $b } keys %{$rule_sentence_hash{$elem}}) {
				print COMPRULESFILE "$elem\t$elem1\n";
			}

			if ((scalar keys %{$rule_sentence_hash{$elem}}) > 1) {
				open(COMPRULESCONFLICTFILE,">>"."slmdirect_results\/createslmDIR_temp_files\/temp_rulesconflict") or die "cant write COMPRULESCONFLICTFILE";
				foreach $elem1 ( sort { $a cmp $b } keys %{$rule_sentence_hash{$elem}}) {
					foreach $elem2 ( sort { $a cmp $b } keys %{$rule_sentence_hash{$elem}{$elem1}}) {
						print COMPRULESCONFLICTFILE "$elem:\n\t$elem1\n\t\t$elem2\n";
					}

					if (defined $rule_sentence_actual_hash{$elem}{$elem1}) {
						print COMPRULESCONFLICTFILE "correct=$elem:\n\t$elem1\n";
					}

					print COMPRULESCONFLICTFILE "\n";
				}

				print COMPRULESCONFLICTFILE "\n";

				close(COMPRULESCONFLICTFILE);
			}
		}

		close(COMPRULESFILE);
	}

	undef %BR_rule_assignment_hash;
	undef %ER_rule_assignment_hash;
	undef %GR_rule_assignment_hash;
	undef %MR_rule_assignment_hash;
	undef %rule_sentence_hash;
	undef %rule_sentence_actual_hash;
	undef %apply_rules_hash;
	undef %apply_ambig_rules_hash;
	undef %external_rules_hash;
	undef %generic_rules_hash;
	undef %rule_word_hash;
	undef %store_FindReference_BR;
	undef %store_FindReference_ER;
	undef %store_FindReference_GR;
	undef %store_FindReference_MR;
	undef %store_FindReference_MR_reclassifications;
	undef %store_FindReference_MR_wordbag;
	undef %store_FindReference_MR_wordbag_reclassifications;
	undef %store_FindReference_focus_BR;
	undef %store_FindReference_focus_ER;
	undef %store_FindReference_focus_GR;
	undef %store_FindReference_focus_MR;
	undef %store_FindReference_focus_MR_reclassifications;
	undef %store_FindReference_focus_MR_wordbag;
	undef %store_FindReference_focus_MR_wordbag_reclassifications;
	undef %store_FindReference_KWN;
	undef %store_FindReference_KWN_wordbag;
	undef %store_FindReference_focus_KWN;
	undef %store_FindReference_focus_KWN_wordbag;

}

############################################################################
# Write out main Grammar Files
############################################################################
#
if (((scalar keys %disallow_general_hash) > 0) || ((scalar keys %disallow_general_additional_hash) > 0)) {
	open(DISALLOWGENERAL,">"."slmdirect_results\/createslmDIR_info_files\/info_disallow_general"."$language_suffix") or die "cant open "."slmdirect_results\/createslmDIR_info_files\/info_disallow_general"."$language_suffix";

	if ((scalar keys %disallow_general_hash) > 0) {
		print DISALLOWGENERAL "General Rules Not Added:\n";

		foreach $elem ( sort { $a cmp $b } keys %disallow_general_hash) {
			print DISALLOWGENERAL "$elem\n";
		}
	}

	if ((scalar keys %disallow_general_additional_hash) > 0) {
		print DISALLOWGENERAL "\n\nGeneral Rules ***from Rules File*** Not Added:\n";

		foreach $elem ( sort { $a cmp $b } keys %disallow_general_additional_hash) {
			print DISALLOWGENERAL "$elem\n";
		}
	}

	DebugPrint ("BOTH", 1, "DISALLOWGENERAL", $debug, $err_no++, "Disallow General File created: "."slmdirect_results\/createslmDIR_info_files\/info_disallow_general"."$language_suffix");
}

close(DISALLOWGENERAL);

if (($make_maingrammar || $do_tagsdirect) && !$do_suppress_grammar) {
	DebugPrint ("BOTH", 0, "Main::CreateMainGrammar", $debug, $err_no++, "Creating Main Grammar Files");

	if ($company_name eq "") {
		$company_name = "general_company";
	}

	CreateMainGrammar(\%gen_grammar_elem_hash, \%general_args, \%wordnet_args, \%cat_args, \%cleaning_args, \%nuance_gsl_args, \%osr_args, \%speakfreely_args, \%nuance9_args, \%meaning_args, \%compressed_already_hash, \%wordlist_already_hash, \%referencetag_hash);
}

DebugPrint ("BOTH UNDERLINE $called_from_gui", 4, "Main::CreateMainGrammar", $debug, $err_no++, "\n");

writeTask();

exit(0);

############################################################################
# Start of Local SUBROUTINES
############################################################################
#
sub FilterRule
{
    my($mysplitchar, $mysearchname) = @_;

    my($combo) = "";

	if (index($mysearchname, $mysplitchar) == -1) {
		$mysplitchar = "";
    }

	$combo = SetGlobalVars($mysplitchar, $mysearchname);

    return $combo;
}

sub SetGlobalVars
{
    my($mysplitchar, $mysearchname) = @_;

    my(@sub_search_array);
    my($combo) = "";
    my($part);
    my($add_part);

	if ($mysplitchar eq "") {
		if (substr($mysearchname,0,1) eq "\$") {
			$combo = ${substr($mysearchname,1)};
		} else {
			$combo = ${substr($mysearchname,0)};
		}
#		print "SetGlobalVars1: combo=$combo, mysearchname=$mysearchname, account_alias=$account_alias\n";
	} else {
		@sub_search_array = split $mysplitchar, $mysearchname;
		foreach $part ( @sub_search_array ) {
			$add_part = $part;
			if (substr($part,0,1) eq "\$") {
				$add_part = ${substr($part,1)};
			}

			$combo = $combo.$add_part;
		}
	}

    return $combo;
}

sub Apply_Rule_Type {

    my($mode, $main_language, $line, $rule_varname_hash, $neg_rule_varname_hash, $r_count, $level_counter_hash, $make_vocab, $grammar_string, $grammar_string_nuance_variant_xml, $apply_rules_hash, $all_gram_elems_array, $all_gram_elems_nuance_variant_xml_array, $all_gram_elems_nuance_class_full_xml_array, $full_vocab_hash, $grammar_rules_additional, $grammar_rules_additional_nuance_variant_xml, $grammar_rules_additional_nuance_class_full_xml) = @_;

	my($add_confirmed_as);
	my($add_item_category);
	my($additional_grammar_elems);
	my($base_level) = 0;
	my($elem);
	my($elem3);
	my($elem4);
	my($i);
	my($level);
	my($loc_count);
	my($nl_type);
	my($temp_elem);
	my($temp_level);
	my($temp_string);
	my($test_name);
	my($vocab_grammar_elems);
	my(@add_grammar_vocab_array);
	my(@rules_array);
	my(@temp_neg_rules_array);
	my(@temp_rules_array);

	$line = ChopChar($line);
	$line = TrimChars($line);

	($nl_type,@temp_rules_array) = split ",", $line;

	$temp_elem = $temp_rules_array[0];
	$temp_elem =~ s/\$//g;

	($temp_elem, $level) = split /\>/, $temp_elem;
	if ($level eq "") {
		$level = $base_level;
	}

	$$rule_varname_hash{$temp_elem}++;

	if ($temp_rules_array[1] ne "") {
		$temp_elem = $temp_rules_array[1];
		$temp_elem =~ s/\$//g;

		(@temp_neg_rules_array) = split "=", $temp_elem;
		foreach $elem (@temp_neg_rules_array) {
			$$neg_rule_varname_hash{$elem}++;
		}
	}

	$i = 0;
	push @rules_array, "";

	foreach $elem (@temp_rules_array) {
		if ($i == 0) {
			($elem, $temp_level) = split /\>/, $elem;
			$test_name = $elem;
			$elem = FilterRule(":", $elem);
		} elsif ($i == 1) {
			if (index($elem, "=") != -1) {
				my(@testnegs) = split "=", $elem;
				my($build_string) = "";
				foreach (@testnegs) {
				  $build_string = stringBuilder($build_string, FilterRule(":", $_), "|");
				}

				$elem = $build_string;
			} else {
				$elem = FilterRule(":", $elem);
			}
		} elsif (($i == 3) && (scalar @temp_rules_array == 4)) {
			push @rules_array, 0;
		}

		if (($i == 0) || ($i == 1)) {
			if ($elem !~ /(\?\!|\?\<|\?\=|\?\()/) {
				$elem =~ s/\?/\\\?/g;
			}

			$elem =~ s/\(\(\(\(\(\(/\[\[\[\[\[\[/g;
			$elem =~ s/\(\(\(\(\(/\[\[\[\[\[/g;
			$elem =~ s/\(\(\(\(/\[\[\[\[/g;
			$elem =~ s/\(\(\(/\[\[\[/g;
			$elem =~ s/\(\(/\[\[/g;

			$elem =~ s/\)\)\)\)\)\)/\]\]\]\]\]\]/g;
			$elem =~ s/\)\)\)\)\)/\]\]\]\]\]/g;
			$elem =~ s/\)\)\)\)/\]\]\]\]/g;
			$elem =~ s/\)\)\)/\]\]\]/g;
			$elem =~ s/\)\)/\]\]/g;

			$elem =~ s/\(/\(\\b/g;
			$elem =~ s/\)/\\b\)/g;
			$elem =~ s/([a-zA-z])\|/$1\\b\|/g;
			$elem =~ s/\|([a-zA-z])/\|\\b$1/g;

			$elem =~ s/\[\[\[\[\[\[/\(\(\(\(\(\(\\b/g;
			$elem =~ s/\[\[\[\[\[/\(\(\(\(\(\\b/g;
			$elem =~ s/\[\[\[\[/\(\(\(\(\\b/g;
			$elem =~ s/\[\[\[/\(\(\(\\b/g;
			$elem =~ s/\[\[/\(\(\\b/g;

			$elem =~ s/\]\]\]\]\]\]/\\b\)\)\)\)\)\)/g;
			$elem =~ s/\]\]\]\]\]/\\b\)\)\)\)\)/g;
			$elem =~ s/\]\]\]\]/\\b\)\)\)\)/g;
			$elem =~ s/\]\]\]/\\b\)\)\)/g;
			$elem =~ s/\]\]/\\b\)\)/g;

			$elem =~ s/\\b\\b/\\b/g;
			$elem =~ s/\\s\+\(\\b\\S\*\\s\*\\b\)/\\s\+\(\\S\*\\s\*\)/g;

			$elem =~ s/\(\\b\\w\\b\|\\b\\_\\b\|\\b\\'\\b\)\*\\s\*\\b\)/\(\\w\|\\_\|\\'\)\*\\s\*\)/g;
			$elem =~ s/\\s\+\(\\b\(\\b\\w\\b\|\\b\\_\\b\|\\b\\'\\b\)\*\\s\*\\b\)/\\s\+\((\\w\|\\_\|\\'\)\*\\s\*\)/g;

			$elem =~ s/\(\\b([íáñúéóú])/\($1/g;
			$elem =~ s/([íáñúéóú])\\b\)/$1\)/g;

			$elem =~ s/\\b\?/\?/g;
			$elem =~ s/ \\b/ /g;
		}

		push @rules_array, $elem;

		$i++;
	}

	if ((scalar @temp_rules_array) != 4) {
		push @rules_array, 0;
	}

	$loc_count = $$level_counter_hash{$level};
	if (not defined $loc_count) {
		$loc_count = 0;
	}

	$$level_counter_hash{$level}++;
	$$apply_rules_hash{$level}{$loc_count} = [ @rules_array ];

	$additional_grammar_elems = $$apply_rules_hash{$level}{$loc_count}[5];
	$add_item_category = $$apply_rules_hash{$level}{$loc_count}[3];

	$add_item_category = ChopChar($add_item_category);
	$additional_grammar_elems = ChopChar($additional_grammar_elems);

	if (($additional_grammar_elems ne "") || (defined $$grammar_rules_additional{$test_name}) || (defined $$grammar_rules_additional_nuance_variant_xml{$test_name})) {
		if ($additional_grammar_elems ne "") {
			if ($make_vocab) {
				$vocab_grammar_elems = $additional_grammar_elems;
				$vocab_grammar_elems =~ s/\(//g;  
				$vocab_grammar_elems =~ s/\)//g;  
				$vocab_grammar_elems =~ s/\[//g;  
				$vocab_grammar_elems =~ s/\]//g;  
				$vocab_grammar_elems =~ s/\?//g;  
				$vocab_grammar_elems =~ s/\!//g;  
				$vocab_grammar_elems =~ s/:/ /g;  

				@add_grammar_vocab_array = split " ", $vocab_grammar_elems;

				foreach (@add_grammar_vocab_array) {
					PutInVocab("additional_grammar_elems", $make_vocab, $full_vocab_hash, $_);
				}
			}
		}

		if (defined $$grammar_rules_additional{$test_name}) {
			if ($make_vocab) {
				@add_grammar_vocab_array = ();
				$vocab_grammar_elems = $$grammar_rules_additional{$test_name};
				$vocab_grammar_elems =~ s/\(//g;  
				$vocab_grammar_elems =~ s/\)//g;  
				$vocab_grammar_elems =~ s/\[//g;  
				$vocab_grammar_elems =~ s/\]//g;  
				$vocab_grammar_elems =~ s/\?//g;  
				$vocab_grammar_elems =~ s/\!//g;  
				$vocab_grammar_elems =~ s/:/ /g;  

				@add_grammar_vocab_array = split " ", $vocab_grammar_elems;

				foreach (@add_grammar_vocab_array) {
					PutInVocab("grammar_rules_additional", $make_vocab, $full_vocab_hash, $_);
				}
			}
		}

		if (defined $$grammar_rules_additional_nuance_variant_xml{$test_name}) {
			if ($make_vocab) {
				@add_grammar_vocab_array = ();
				$vocab_grammar_elems = $$grammar_rules_additional_nuance_variant_xml{$test_name};
				$vocab_grammar_elems =~ s/\(//g;  
				$vocab_grammar_elems =~ s/\)//g;  
				$vocab_grammar_elems =~ s/\[//g;  
				$vocab_grammar_elems =~ s/\]//g;  
				$vocab_grammar_elems =~ s/\?//g;  
				$vocab_grammar_elems =~ s/\!//g;  
				$vocab_grammar_elems =~ s/:/ /g;  

				@add_grammar_vocab_array = split " ", $vocab_grammar_elems;

				foreach (@add_grammar_vocab_array) {
					PutInVocab("grammar_rules_additional_nuance_variant_xml", $make_vocab, $full_vocab_hash, $_);
				}
			}
		}

		if (index($add_item_category, ":") != -1) {
			($add_item_category, $add_confirmed_as) = split ":", $add_item_category;
		}

		if ($add_confirmed_as ne "") {
			$temp_string = "b-".$add_item_category."-".$add_confirmed_as;
			$temp_string =~ s/ /_/g;

			if ($mode eq "external") {
				$elem3 = "<ExternalSlot \"EXTERNAL\">";
				$elem4 = "<tag>ExternalSlot=\'EXTERNAL\'</tag>";
			} else {
				$elem3 = sprintf($grammar_string, $add_item_category, $add_confirmed_as);
				$elem4 = sprintf($grammar_string_nuance_variant_xml, $temp_string, $add_item_category, $add_confirmed_as);
			}
		} else {
			$temp_string = "b-".$add_item_category."-".$add_item_category;
			$temp_string =~ s/ /_/g;

			if ($mode eq "external") {
				$elem3 = "<ExternalSlot \"EXTERNAL\">";
				$elem4 = "<tag>ExternalSlot=\'EXTERNAL\'</tag>";
			} else {
				$elem3 = sprintf($grammar_string, $add_item_category, $add_item_category);
				$elem4 = sprintf($grammar_string_nuance_variant_xml, $temp_string, $add_item_category, $add_item_category);
			}
		}

		if ($additional_grammar_elems ne "") {
			push @$all_gram_elems_array, $add_item_category.":".$elem3.":".$additional_grammar_elems;
			push @$all_gram_elems_nuance_variant_xml_array, $temp_string.":".$elem4.":".$additional_grammar_elems;
		}

		if (defined $$grammar_rules_additional{$test_name}) {
			push @$all_gram_elems_array, $add_item_category.":".$elem3.":".$$grammar_rules_additional{$test_name};
		}

		if (defined $$grammar_rules_additional_nuance_variant_xml{$test_name}) {
			push @$all_gram_elems_nuance_variant_xml_array, $temp_string.":".$elem4.":".$$grammar_rules_additional_nuance_variant_xml{$test_name};
			push @$all_gram_elems_nuance_class_full_xml_array, $temp_string.":".$elem4.":".$$grammar_rules_additional_nuance_class_full_xml{$test_name};
		}
	}

	$r_count++;

	return ($r_count);
}

