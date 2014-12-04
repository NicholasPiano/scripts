#!usr/bin/python

#DirectSLM.py

# ****************************************************************************************
# ****************************************************************************************
#   Copyright 2012 Abacii Services.  All rights reserved.
#   This is an unpublished work of Abacii Services and is not to be
#   used or disclosed except as provided in a license agreement or
#   nondisclosure agreement with Abacii Services.
# ****************************************************************************************
# ****************************************************************************************
#
# Modified: Thu Jul 5 13:00:00 2012
#
# Created: Jul 5, 2012 v1.0 Nicholas Piano

#imports
import io
import math
import sys
import os

#tools and useful methods
def qw(a):
    return tuple(a.split())

#define program variables
export_tuple = qw('ApplyBuildMainString ApplyClassGrammars ApplyCorrectionAfterModSearch ApplyCorrectionRules ApplyFirstCorrectionRules ApplyParsingRules AssignLineType BuildDataStrings_FlatFile BuildDataStrings_Other BuildRepStrings BuildWordEndingsList CALL_SLMDirect CheckCats CheckForTranscriptions CheckIntegrity1 CheckKeywordHashes CheckSkipPhrase CheckTimeDiff checkRules ChopChar Classify_Output_Format ConditionalPrint CountParens createBackup CreateMainGrammar DebugPrint DetermineSourceAssignment DoAllCorrections ExpandSentence FillBuildStrings FillFilterArrays FillGoodFragmentHash FillGrammarElements FillSearchString FillTranslateHash FilterAmbigWords FilterCorpus FilterRepeatsETC FindAllReferences FindEnclosure FindFirstChar GenReducedCorpus GenWordList GetClosure GetClosure_SLMDirect GetEnclosure GetKnownCatsInfo GetReclassInfo GetResidualString GetReverseClosure GetRuleErrors writeTask MakeCatList1 MakeCatList2 MakeCleanTrans MakeCompressedAliasSentence NewGetClosure NormalizeFilename NormCat ParseGrammar ProcessChars ProcessCharsInitial ProcessCharsPlus ProcessNounVerbSentences ProcessOPTIONALs ProcessOPTIONALs_SLMDirect ProcessPrefix PutInVocab ReadNewCats ReadParse RemoveChar RemoveRepeats ReplaceEnclosures resetErrorsWarnings RestoreCorpusFile SeparateTaggedSentences Set_Elem_Format setTask SimpleReplaceMy SqueezeSentence stringBuilder TestSkipPhrase ThisGetClosure TransCatList TrimChars TrimCharsChangeTab WriteAssignmentFile WriteClassifications WriteDataStrings WriteGenRefFile WriteMainGrammar WriteMainGrammar_nuance_variant_xml WriteNewCatsFile WriteReplacementMainGrammar WriteVocabs Write_FilterCorpus_Fileout Write_Grammar_Out_all Write_SubGrammars_Out Write_Output_Format alphabetically AutoTagFilterSingles bump_num catdefOrder change_num change_num_three checkMultiParseVariables checkSpecialParseVariables chooseCompressedSentence createSearchString fisher_yates_shuffle getItemInfo getOutEncoding interpretCommand makeAliasExclusion makeArrayfromString makeArrayDirectfromString makeClassGrammars makeTaggingFile makeHashfromString makeHeavyHashfromString makeIndentedFile makePOSHashfromString makeSynonymHashfromString makeStringDirectfromString makeTrainingFileArray makeTruthFiles putItemInfo numerically setConnector setFalseFreqsfromString setRuleWordHash storeLocationInfo storeLocationInfoOrdered stringToVocab uniq')

