xquery version "1.0";
declare function local:getid($let_result as element()*)
as xs:integer*
{    
     if($let_result[@target-id]) then(
          $let_result/xs:integer(@target-id)
     )
     else(
         $let_result/xs:integer(@id)
     )
};

let $all_the_sentences :=
for $verb in //token[@relation = "pred"][@form]
let $subordinate := $verb/parent::sentence/token
          [@part-of-speech = "G-"]
          [@id = $verb/@head-id]
let $objthing2conjunction_which_is_pred := $verb/parent::sentence/token[@relation = "pred"]
          [@part-of-speech= "C-"]
          [@id = $verb/@head-id]
let $subordinate_coord := $verb/parent::sentence/token
          [@part-of-speech = "G-"]
          [@id = $objthing2conjunction_which_is_pred/@head-id]
let $objthing2conjunction_which_is_obj := $verb/parent::sentence/token[@relation= "obj"]
          [@part-of-speech = "C-"]
          [@head-id = $verb/@id]
let $objthing2conjunction_which_is_sub := $verb/parent::sentence/token[@relation= "sub"]
          [@part-of-speech = "C-"]
          [@head-id = $verb/@id]
let $obj_preceding := $verb/preceding-sibling::token[@relation="obj"]
          [@morphology[matches(., "......a...")]]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $verb/@id]
let $obj_following := $verb/following-sibling::token[@relation="obj"]
          [@morphology[matches(., "......a...")]]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $verb/@id]
let $sub_preceding := $verb/preceding-sibling::token[@relation="sub"]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $verb/@id]
let $sub_following := $verb/following-sibling::token[@relation="sub"]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $verb/@id]
          
let $obj_preceding_coord := $verb/preceding-sibling::token[@relation= "obj"]
          [@morphology[matches(., "......a...")]]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $objthing2conjunction_which_is_obj/@id]     
let $obj_following_coord := $verb/following-sibling::token[@relation= "obj"]
          [@morphology[matches(., "......a...")]]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $objthing2conjunction_which_is_obj/@id]
let $sub_preceding_coord := $verb/preceding-sibling::token[relation= "sub"]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $objthing2conjunction_which_is_sub/@id]     
let $sub_following_coord := $verb/following-sibling::token[relation= "sub"]
          [@part-of-speech = ("Pp", "Ne","Ps", "Pi","Pt", "Pk","Px", "Pc","Pd", "Nb")]
          [@head-id = $objthing2conjunction_which_is_sub/@id]     

let $objthing1_vo := let $objthing11_vo := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $obj_preceding/@id]         
          where $objthing11_vo/parent::token/xs:integer(@id) < $obj_preceding/xs:integer(@id) 
          return $objthing11_vo  
let $objthing2_vo := let $objthing22_vo := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $objthing2conjunction_which_is_obj/@id]         
          where $objthing22_vo/parent::token/xs:integer(@id) < $obj_preceding_coord/xs:integer(@id)
          return $objthing22_vo                             
let $objthing3_vo := let $objthing33_vo := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $obj_following/@id]         
          where $objthing33_vo/parent::token/xs:integer(@id) < $obj_following/xs:integer(@id)
          return $objthing33_vo  
let $objthing4_vo := let $objthing44_vo := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $objthing2conjunction_which_is_obj/@id]         
          where $objthing44_vo/parent::token/xs:integer(@id) < $obj_following_coord/xs:integer(@id)
          return $objthing44_vo
let $objthing1_ov := let $objthing11_ov := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $obj_preceding/@id]         
          where $objthing11_ov/parent::token/xs:integer(@id) > $obj_preceding/xs:integer(@id) 
          return $objthing11_ov  
let $objthing2_ov := let $objthing22_ov := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $objthing2conjunction_which_is_obj/@id]         
          where $objthing22_ov/parent::token/xs:integer(@id) > $obj_preceding_coord/xs:integer(@id)
          return $objthing22_ov                             
let $objthing3_ov := let $objthing33_ov := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $obj_following/@id]         
          where $objthing33_ov/parent::token/xs:integer(@id) > $obj_following/xs:integer(@id)
          return $objthing33_ov  
let $objthing4_ov := let $objthing44_ov := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="obj"]
          [@target-id= $objthing2conjunction_which_is_obj/@id]         
          where $objthing44_ov/parent::token/xs:integer(@id) > $obj_following_coord/xs:integer(@id)
          return $objthing44_ov

let $subthing1_vs := let $subthing11_vs := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $sub_preceding/@id]         
          where $subthing11_vs/parent::token/xs:integer(@id) < $sub_preceding/xs:integer(@id) 
          return $subthing11_vs 
let $subthing2_vs := let $subthing22_vs := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $objthing2conjunction_which_is_sub/@id]         
          where $subthing22_vs/parent::token/xs:integer(@id) < $sub_preceding_coord/xs:integer(@id)
          return $subthing22_vs                             
let $subthing3_vs := let $subthing33 := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $sub_following/@id]         
          where $subthing33/parent::token/xs:integer(@id) < $sub_following/xs:integer(@id)
          return $subthing33  
let $subthing4_vs := let $subthing44_vs := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $objthing2conjunction_which_is_sub/@id]         
          where $subthing44_vs/parent::token/xs:integer(@id) < $sub_following_coord/xs:integer(@id)
          return $subthing44_vs                            
let $subthing1_sv := let $subthing11_sv := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $sub_preceding/@id]         
          where $subthing11_sv/parent::token/xs:integer(@id) > $sub_preceding/xs:integer(@id) 
          return $subthing11_sv 
let $subthing2_sv := let $subthing22_sv := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $objthing2conjunction_which_is_sub/@id]         
          where $subthing22_sv/parent::token/xs:integer(@id) > $sub_preceding_coord/xs:integer(@id)
          return $subthing22_sv                             
let $subthing3_sv := let $subthing33 := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $sub_following/@id]         
          where $subthing33/parent::token/xs:integer(@id) > $sub_following/xs:integer(@id)
          return $subthing33  
let $subthing4_sv := let $subthing44_sv := $verb/parent::sentence/token[@relation = "pred"]
          [@head-id = $objthing2conjunction_which_is_pred/@id]/slash[@relation="sub"]
          [@target-id= $objthing2conjunction_which_is_sub/@id]         
          where $subthing44_sv/parent::token/xs:integer(@id) > $sub_following_coord/xs:integer(@id)
          return $subthing44_sv                            


let $obj_just_special_ov_any := ($objthing1_ov, $objthing2_ov, $objthing3_ov, $objthing4_ov)

let $sub_just_special_ov_any := ($subthing1_sv, $subthing2_sv, $subthing3_sv, $subthing4_sv)

let $obj_preceding_any := ($obj_preceding, $obj_preceding_coord, $objthing1_ov, $objthing2_ov, $objthing3_ov, $objthing4_ov) 
let $sub_preceding_any := ($sub_preceding, $sub_preceding_coord, $subthing1_sv, $subthing2_sv, $subthing3_sv, $subthing4_sv) 
let $obj_following_any := ($obj_following, $obj_following_coord, $objthing1_vo, $objthing2_vo, $objthing3_vo, $objthing4_vo) 
let $sub_following_any := ($sub_following, $sub_following_coord, $subthing1_vs, $subthing2_vs, $subthing3_vs, $subthing4_vs) 

(: 
     To run these searches, comment out exactly one of the "where ..." lines.
     
     The first line, labelled "Any verb" will output all relevant clauses, with the details of which of subjects, objects etc
     are present output in the results. This option is the simplest if the results will be post-processed (eg using the attached Python script)

     Subsequent lines select a subset of the clauses, matching the relevant word order.
     NB These clauses will contain the specified word order, but potentially other nouns as well.
     Eg an SVO search will return clauses containing SVO, but also SVOO, SOVO, SVOS, etc...
:)


(: Any verb :)
where (not($subordinate) and not($subordinate_coord))

(: SOV :)
(: where (($subordinate) or ($subordinate_coord)) and 
(
     $obj_preceding_any and $sub_preceding_any and 
     local:getid($sub_preceding_any) < local:getid($obj_preceding_any)
)
:)


(: OSV :)
(: where (not($subordinate) and not($subordinate_coord)) and 
(
     $obj_preceding_any and $sub_preceding_any and 
     local:getid($sub_preceding_any) > local:getid($obj_preceding_any)
)
:)

(: SVO :)
(: where (not($subordinate) and not($subordinate_coord)) and 
(
     $obj_following_any and $sub_preceding_any 
)
:)

(: OVS :)
(: where (not($subordinate) and not($subordinate_coord)) and 
(
     $obj_preceding_any and $sub_following_any 
)
:)

(: VSO :)
(: where (not($subordinate) and not($subordinate_coord)) and 
(
     $obj_following_any and $sub_following_any and 
     local:getid($sub_following_any) < local:getid($obj_following_any)
):)

(: VOS :)
(: where (not($subordinate) and not($subordinate_coord)) and 
(
     $obj_following_any and $sub_following_any and 
     local:getid($sub_following_any) > local:getid($obj_following_any)
):)


(: SV :)
(: where (not($subordinate) and not($subordinate_coord)) and $sub_preceding_any 
:)
(: VS :)
(: where (not($subordinate) and not($subordinate_coord)) and $sub_following_any 
:)
(: OV :)
(:where (not($subordinate) and not($subordinate_coord)) and $obj_preceding_any 
:)
(: VO :)
 (:where (not($subordinate) and not($subordinate_coord)) and $obj_following_any 
:)

return    
<r verb_id="{$verb/@id}" verb="{$verb/@form}" cite="{$verb/@citation-part}" verb_lemma="{$verb/@lemma}"
   sub_preceding_id="{local:getid($sub_preceding_any)}"
   sub_following_id="{local:getid($sub_following_any)}"
   obj_preceding_id="{local:getid($obj_preceding_any)}"
   obj_following_id="{local:getid($obj_following_any)}"
   sentence_start_id="{min($verb/preceding-sibling::token/xs:integer(@id))}"
   sentence_end_id="{max($verb/following-sibling::token/xs:integer(@id))}"
>
<passage>{data($verb/parent::sentence/token/@form)}</passage>
<pre_subject>{data($sub_preceding/@form)}</pre_subject>
<fol_subject>{data($sub_following/@form)}</fol_subject>
<pre_object>{data($obj_preceding/@form)}</pre_object>
<fol_object>{data($obj_following/@form)}</fol_object>
<pre_object_co>{data($obj_preceding_coord/@form)}</pre_object_co>
<fol_object_co>{data($obj_following_coord/@form)}</fol_object_co>
<pre_subject_co>{data($sub_preceding_coord/@form)}</pre_subject_co>
<fol_subject_co>{data($sub_following_coord/@form)}</fol_subject_co>

<subject_of_co_verb1_sv  v="{$subthing1_sv/parent::token/@form}">{data($sub_preceding/@form)}</subject_of_co_verb1_sv>
<subject_of_co_verb2_sv v="{$subthing2_sv/parent::token/@form}">{data($sub_preceding_coord/@form)}</subject_of_co_verb2_sv>
<subject_of_co_verb3_sv  v="{$subthing3_sv/parent::token/@form}">{data($sub_following/@form)}</subject_of_co_verb3_sv>
<subject_of_co_verb4_sv  v="{$subthing4_sv/parent::token/@form}">{data($sub_following_coord/@form)}</subject_of_co_verb4_sv>

<subject_of_co_verb1_vs  v="{$subthing1_vs/parent::token/@form}">{data($sub_preceding/@form)}</subject_of_co_verb1_vs>
<subject_of_co_verb2_vs v="{$subthing2_vs/parent::token/@form}">{data($sub_preceding_coord/@form)}</subject_of_co_verb2_vs>
<subject_of_co_verb3_vs  v="{$subthing3_vs/parent::token/@form}">{data($sub_following/@form)}</subject_of_co_verb3_vs>
<subject_of_co_verb4_vs  v="{$subthing4_vs/parent::token/@form}">{data($sub_following_coord/@form)}</subject_of_co_verb4_vs>

<object_of_co_verb1_ov  v="{$objthing1_ov/parent::token/@form}">{data($obj_preceding/@form)}</object_of_co_verb1_ov>
<object_of_co_verb2_ov v="{$objthing2_ov/parent::token/@form}">{data($obj_preceding_coord/@form)}</object_of_co_verb2_ov>
<object_of_co_verb3_ov  v="{$objthing3_ov/parent::token/@form}">{data($obj_following/@form)}</object_of_co_verb3_ov>
<object_of_co_verb4_ov  v="{$objthing4_ov/parent::token/@form}">{data($obj_following_coord/@form)}</object_of_co_verb4_ov>

<object_of_co_verb1_vo  v="{$objthing1_vo/parent::token/@form}">{data($obj_preceding/@form)}</object_of_co_verb1_vo>
<object_of_co_verb2_vo v="{$objthing2_vo/parent::token/@form}">{data($obj_preceding_coord/@form)}</object_of_co_verb2_vo>
<object_of_co_verb3_vo  v="{$objthing3_vo/parent::token/@form}">{data($obj_following/@form)}</object_of_co_verb3_vo>
<object_of_co_verb4_vo  v="{$objthing4_vo/parent::token/@form}">{data($obj_following_coord/@form)}</object_of_co_verb4_vo>
</r>
for $sentence at $n in $all_the_sentences
return 
<f number="{$n}">{$sentence}</f>