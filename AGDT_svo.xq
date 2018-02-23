xquery version "1.0";

(: 
    These "[@cite...]" conditions can be added to the "for $verb..." line if you want to
    return results from only some of the books of the Iliad/Odyssey.
:)

(:Books 1-6: 
[@cite[matches(.,".*tlg001:[1-6][^0-9].*")]] 
:)
(:Books 7-12: 
[@cite[matches(.,".*tlg001:[7-9].*") or matches(.,".*tlg001:1[0-2].*")]] 
:)
(:Books 1-12: 
[@cite[matches(.,".*tlg001:.*")]]   
:)
(:Books 13-18: 
[@cite[matches(.,".*tlg001:1[3-8].*")]] 
:)
(:Books 19-24: 
[@cite[matches(.,".*tlg001:19.*") or matches(.,".*tlg001:2[0-4].*")]] 
:)

(:Books 1-6: 
[@cite[matches(.,".*tlg002:[1-6][^0-9].*")]] 
:)
(:Books 7-12: 
[@cite[matches(.,".*tlg002:[7-9].*") or matches(.,".*tlg002:1[0-2].*")]] 
:)
(:Books 1-12: 
[@cite[matches(.,".*tlg001:.*")]] 
:)
(:Books 13-18: 
[@cite[matches(.,".*tlg002:1[3-8].*")]] 
:)
(:Books 19-24: 
[@cite[matches(.,".*tlg002:19.*") or matches(.,".*tlg002:2[0-4].*")]] 
:)
let $r :=
for $verb in //word[@relation= ("PRED", "PRED_CO")]
let $obj_preceding := $verb/preceding-sibling::word[@relation = "OBJ"]
           [@postag[matches(.,"(n|p)......a.")]]
           [@head = $verb/@id]
let $sub_preceding := $verb/preceding-sibling::word[@relation = "SBJ"]
          [@postag[matches(.,"(n|p)........")]]
          [@head = $verb/@id]
let $obj_following := $verb/following-sibling::word[@relation = "OBJ"]
           [@postag[matches(.,"(n|p)......a.")]]
           [@head = $verb/@id]
let $sub_following := $verb/following-sibling::word[@relation = "SBJ"]
           [@postag[matches(.,"(n|p)........")]]
           [@head = $verb/@id]            
let $coord := $verb/parent::sentence/word[@relation="COORD"]
          [@head = $verb/@id]
let $obj_preceding_coord := $verb/preceding-sibling::word[@relation="OBJ_CO"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head = $coord/@id]  
let $obj_following_coord := $verb/following-sibling::word[@relation="OBJ_CO"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head = $coord/@id]
let $coord_2 := $verb/parent::sentence/word[@relation= "COORD"]
          [@id = $verb/@head]
let $sub_preceding_coord := $verb/preceding-sibling::word[@relation="SBJ_CO"]
          [@postag[matches(.,"(n|p)........")]]
          [@head = $coord/@id]  
let $sub_following_coord := $verb/following-sibling::word[@relation="SBJ_CO"]
          [@postag[matches(.,"(n|p)........")]]
          [@head = $coord/@id]
let $obj_preceding_2 := $verb/preceding-sibling::word[@relation = "OBJ"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head= $coord_2/@id]          
let $sub_preceding_2 := $verb/preceding-sibling::word[@relation = "SBJ"]
          [@postag[matches(.,"(n|p)........")]]
          [@head= $coord_2/@id]          
let $obj_following_2 := $verb/following-sibling::word[@relation = "OBJ"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head= $coord_2/@id]          
let $sub_following_2 := $verb/following-sibling::word[@relation = "SBJ"]
          [@postag[matches(.,"(n|p)........")]]
          [@head= $coord_2/@id]          
let $coord_3 := $verb/parent::sentence/word[@relation="COORD"]
          [@head = $coord_2/@id]
let $obj_preceding_coord_2 := $verb/preceding-sibling::word[@relation = "OBJ_CO"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head= $coord_3/@id]
let $obj_following_coord_2 := $verb/following-sibling::word[@relation = "OBJ_CO"]
          [@postag[matches(.,"(n|p)......a.")]]
          [@head= $coord_3/@id]      
let $sub_preceding_coord_2 := $verb/preceding-sibling::word[@relation = "SBJ_CO"]
          [@postag[matches(.,"(n|p)........")]]
          [@head= $coord_3/@id]
let $sub_following_coord_2 := $verb/following-sibling::word[@relation = "SBJ_CO"]
          [@postag[matches(.,"(n|p)........")]]
          [@head= $coord_3/@id]      

let $obj_preceding_any := ($obj_preceding, $obj_preceding_coord, $obj_preceding_2, $obj_preceding_coord_2)
let $sub_preceding_any := ($sub_preceding, $sub_preceding_coord, $sub_preceding_2, $sub_preceding_coord_2)
let $obj_following_any := ($obj_following, $obj_following_coord, $obj_following_2, $obj_following_coord_2)
let $sub_following_any := ($sub_following, $sub_following_coord, $sub_following_2, $sub_following_coord_2)

(: 
  
    With all of the "where ..." lines commented out, the search will output all relevant clauses, with the details of which of subjects, objects etc
    are present output in the results. This option is the simplest if the results will be post-processed (eg using the attached Python script)

    To select a subset of the clauses, uncomment one of the "where..." lines, matching the relevant word order.
    NB These clauses will contain the specified word order, but potentially other nouns as well.
    Eg an SVO search will return clauses containing SVO, but also SVOO, SOVO, SVOS, etc...
:)


(: SOV :)
(:where $obj_preceding_any and $sub_preceding_any and $obj_preceding_any/xs:integer(@id) > $sub_preceding_any/xs:integer(@id)
:)

(: OSV :)
(:where $obj_preceding_any and $sub_preceding_any and $obj_preceding_any/xs:integer(@id) < $sub_preceding_any/xs:integer(@id)
:)

(: SVO :)
(:where $sub_preceding_any and $obj_following_any 
:)

(: OVS :)
(:where $sub_following_any and $obj_preceding_any 
:)

(: VSO :)
(:where $obj_following_any and $sub_following_any and $obj_following_any/xs:integer(@id) > $sub_following_any/xs:integer(@id)
:)

(: VOS :)
(:where $obj_following_any and $sub_following_any and $obj_following_any/xs:integer(@id) < $sub_following_any/xs:integer(@id)
:)

(: SV :)
(:where $sub_preceding_any
:)

(: VS :)
(:where $sub_following_any
:)

(: OV :)
(:where $obj_preceding_any
:)

(: VO :) 
(:where $obj_following_any
:)


return    <r verb_id="{$verb/@cid}" verb="{$verb/@form}" cite="{$verb/@cite}" verb_lemma="{$verb/@lemma}"
          sub_preceding_id="{$sub_preceding_any/xs:integer(@cid)}"
          sub_following_id="{$sub_following_any/xs:integer(@cid)}"
          obj_preceding_id="{$obj_preceding_any/xs:integer(@cid)}"
          obj_following_id="{$obj_following_any/xs:integer(@cid)}"
          sentence_start_id="{min($verb/preceding-sibling::word/xs:integer(@cid))}"
          sentence_end_id="{max($verb/following-sibling::word/xs:integer(@cid))}"
          >
          <passage>{data($verb/parent::sentence/word/@form)}</passage>
          <pre_subject>{data($sub_preceding/@form)}</pre_subject>
          <fol_subject>{data($sub_following/@form)}</fol_subject>
          <pre_object>{data($obj_preceding/@form)}</pre_object>
          <fol_object>{data($obj_following/@form)}</fol_object>
          <pre_object_co>{data($obj_preceding_coord/@form)}</pre_object_co>
          <pre_subject_co>{data($sub_preceding_coord/@form)}</pre_subject_co>
          <pre_obj_attached_to_coord>{data($obj_preceding_2/@form)}</pre_obj_attached_to_coord>
          <pre_sub_attached_to_coord>{data($sub_preceding_2/@form)}</pre_sub_attached_to_coord>
          <fol_object_co>{data($obj_following_coord/@form)}</fol_object_co>
          <fol_subject_co>{data($sub_following_coord/@form)}</fol_subject_co>
          <fol_obj_attached_to_coord>{data($obj_following_2/@form)}</fol_obj_attached_to_coord>
          <fol_sub_attached_to_coord>{data($sub_following_2/@form)}</fol_sub_attached_to_coord>
          <pre_obj_co_attached_to_coord>{data($obj_preceding_coord_2/@form)}</pre_obj_co_attached_to_coord>
          <pre_sub_co_attached_to_coord>{data($sub_preceding_coord_2/@form)}</pre_sub_co_attached_to_coord>
          <fol_obj_co_attached_to_coord>{data($obj_following_coord_2/@form)}</fol_obj_co_attached_to_coord>
          <fol_sub_co_attached_to_coord>{data($sub_following_coord_2/@form)}</fol_sub_co_attached_to_coord>
          </r>

for $k at $n in $r
return <f number="{$n}">{$k}</f>