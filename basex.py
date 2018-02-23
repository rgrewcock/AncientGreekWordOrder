# -*- coding: utf-8 -*-
"""
Created on Sun Feb 11 22:12:51 2018

These scripts can be used to read and process the output of the attached XQuery files.

Expected usage:
homer_results = read_file('AGDT_homer_xquery_output.xml')
[homer_totals, homer_details] = parse_results(homer_results)

Then 
print(homer_totals)
will output the totals in a formatted fashion, and the data are available in 
homer_totals and homer_details for further investigation.

"""



from bs4 import BeautifulSoup

class Totals(object):
    svo = 0
    sov = 0
    
    sv = 0
    vs = 0
    ov = 0
    vo = 0
    def __str__(self):
        return '      SV = {0}, VS = {1}, OV = {2}, VO = {3}'.format(self.sv, self.vs, self.ov, self.vo) \
                + '\n' + \
                'only: SV = {0}, VS = {1}, OV = {2}, VO = {3}'.format(self.sv_only, self.vs_only, self.ov_only, self.vo_only) \
                + '\n\n' + \
                'SVS = {0}, OVO = {1}, SVS and obj = {2}, OVO and sub = {3}'.format(self.svs, self.ovo, self.svs_and_obj, self.ovo_and_sub) \
                + '\n' + \
                'SV and obj = {0}, VS and obj = {1}, OV and sub = {2}, VO and sub = {3}'.format(self.sv_and_obj, self.vs_and_obj, self.ov_and_sub, self.vo_and_sub) \
                + '\n\n' + \
                '      SVO = {0}, SOV = {1}, VSO = {2}, VOS = {3}, OSV = {4}, OVS = {5}'.format(self.svo, self.sov, self.vso, self.vos, self.osv, self.ovs) \
                + '\n' + \
                'only: SVO = {0}, SOV = {1}, VSO = {2}, VOS = {3}, OSV = {4}, OVS = {5}'.format(self.svo_only, self.sov_only, self.vso_only, self.vos_only, self.osv_only, self.ovs_only) \
                + '\n\n' + \
                'SVO and OV = {0}, SVO and VS = {1}, SOV and VO = {2}, SOV and VS = {3}'.format(self.svo_and_ov, self.svo_and_vs, self.sov_and_vo, self.sov_and_vs) \
                + '\n' + \
                'VSO and OV = {0}, VSO and SV = {1}, VOS and OV = {2}, VOS and SV = {3}'.format(self.vso_and_ov, self.vso_and_sv, self.vos_and_ov, self.vos_and_sv) \
                + '\n' + \
                'OSV and VO = {0}, OSV and VS = {1}, OVS and VO = {2}, OVS and SV = {3}'.format(self.osv_and_vo, self.osv_and_vs, self.ovs_and_vo, self.ovs_and_sv) \
                + '\n\n' + \
                'Clauses with subjects = {0} \nClauses with objects = {1} \nClauses with both = {2}'.format(self.v_and_sub, self.v_and_obj, self.v_and_sub_and_obj)
    
class Detailed_results(object):
    of = 0

def read_file(filename):
    f1 = open(filename,'r',encoding='utf8')
    f1s = f1.read()
    soup = BeautifulSoup(f1s,'lxml')
    f1.close()
    results = soup.find_all('r')
    return results
    
def parse_results(results):    
    #These are eg position(subject) - position(verb), so the distance in words 
    #between subject and verb, or object and verb.
    sf_offsets = []
    of_offsets = []
    sp_offsets = []
    op_offsets = []
    

    cites = []
    lemmas = []

    n_svo = 0
    n_sov = 0
    n_vso = 0
    n_vos = 0
    n_osv = 0
    n_ovs = 0
    
    n_svo_only = 0
    n_sov_only = 0
    n_vso_only = 0
    n_vos_only = 0
    n_osv_only = 0
    n_ovs_only = 0
    
    n_sv = 0
    n_vs = 0
    n_ov = 0
    n_vo = 0
    
    n_sv_only = 0
    n_vs_only = 0
    n_ov_only = 0
    n_vo_only = 0
    
    n_sv_and_obj = 0
    n_vs_and_obj = 0
    n_svs_and_obj = 0
    n_ov_and_sub = 0
    n_vo_and_sub = 0
    n_ovo_and_sub = 0
    
    n_v_and_sub = 0
    n_v_and_obj = 0
    n_v_and_sub_and_obj = 0
    
    n_ovo = 0
    n_svs = 0

    n_svo_and_ov = 0
    n_svo_and_vs = 0
    n_sov_and_vs = 0
    n_sov_and_vo = 0
    n_vso_and_ov = 0
    n_vso_and_sv = 0
    n_vos_and_ov = 0
    n_vos_and_sv = 0
    n_osv_and_vo = 0
    n_osv_and_vs = 0
    n_ovs_and_vo = 0
    n_ovs_and_sv = 0
    
    for result in results:
        verb_id = int(result['verb_id'])
        sf = str.split(result['sub_following_id'])
        of = str.split(result['obj_following_id'])
        sp = str.split(result['sub_preceding_id'])
        op = str.split(result['obj_preceding_id'])
        
        #Record the S and O positions in the sentence, and get the 2-part numbers
        if sf:
            sf_n = [ int(x) - verb_id for x in sf ] 
            n_vs += 1
            if not sp:
                n_vs_only += 1
        else:
            sf_n = 0
        sf_offsets.append(sf_n)
     
        if sp:
            sp_n = [ int(x) - verb_id for x in sp ]
            n_sv += 1
            if not sf:
                n_sv_only += 1
        else:
            sp_n = 0
        sp_offsets.append(sp_n)  
            
        if of:
            of_n = [ int(x) - verb_id for x in of ] 
            n_vo += 1
            if not op:
                n_vo_only += 1
        else:
            of_n = 0
        of_offsets.append(of_n)
        
        if op:
            op_n = [ int(x) - verb_id for x in op ] 
            n_ov += 1
            if not of:
                n_ov_only += 1
        else:
            op_n = 0
        op_offsets.append(op_n)
            
        # Get the total numbers of clauses
        sub_present = 0
        obj_present = 0
        
        if sf or sp:
            sub_present = 1
            n_v_and_sub += 1
        
        if of or op:
            obj_present = 1
            n_v_and_obj += 1
            
        if obj_present and sub_present:
            n_v_and_sub_and_obj += 1
            
        #Get '2-part with the other thing there'
        if sp and obj_present:
            n_sv_and_obj += 1
        
        if sf and obj_present:
            n_vs_and_obj += 1
            
        if sp and sf and obj_present:
            n_svs_and_obj += 1
        
        if op and sub_present:
            n_ov_and_sub += 1
            
        if of and sub_present:
            n_vo_and_sub += 1
        
        if of and op and sub_present:
            n_ovo_and_sub += 1
            
        #Finally, the 3-part numbers
        if sp and of:
            n_svo += 1
            if (not sf) and (not op):
                n_svo_only += 1
            if op:
                n_svo_and_ov += 1
            if sf:
                n_svo_and_vs += 1
        if sp and op:
            if (max(sp_n) < min(op_n)) and (not of) and (not sf):
                #All subjects are before all objects and all objects are before the verb.
                n_sov_only += 1
            if min(sp_n) < max(op_n):
                #The earliest subject is before the last preceding object
                n_sov += 1
                if sf:
                    n_sov_and_vs += 1
                if of:
                    n_sov_and_vo += 1
            if (max(op_n) < min(sp_n)) and (not sf) and (not sf):
                #All objects are before all subjects and all subjects are before the verb.
                n_osv_only += 1

            if min(op_n) < max(sp_n):
                #The earliest object is before the last preceding subject
                n_osv += 1
                if sf:
                    n_osv_and_vs += 1
                if of:
                    n_osv_and_vo += 1
    
        if sf and op:
            n_ovs += 1
            if (not sp) and (not of):
                n_ovs_only += 1
            if of:
                n_ovs_and_vo += 1
            if sp:
                n_ovs_and_sv += 1
            
        if sf and of:
            if (max(sf_n) < min(of_n)) and (not sp) and (not op):
                #All subjects are before all objects and all subjects are after the verb.
                n_vso_only += 1
            if min(sf_n) < max(of_n):
                #The earliest following subject is before the last object
                n_vso += 1
                if sp:
                    n_vso_and_sv += 1
                if op:
                    n_vso_and_ov += 1
            if (max(of_n) < min(sf_n)) and (not op) and (not sp):
            #All objects are before all subjects and all objects are after the verb.
                n_vos_only += 1
            if min(of_n) < max(sf_n):
                #The earliest following object is before the last subject
                n_vos += 1
                if sp:
                    n_vos_and_sv += 1
                if op:
                    n_vos_and_ov += 1
                
        #Funky ones:
        if op and of:
            n_ovo += 1
        
        if sp and sf:
            n_svs += 1                
                
        #Record the cite and the verb lemma    
        cites.append(result['cite'])
        lemmas.append(result['verb_lemma'])
        
    totals = Totals()
    
    totals.svo = n_svo
    totals.sov = n_sov
    totals.vso = n_vso
    totals.vos = n_vos
    totals.osv = n_osv
    totals.ovs = n_ovs

    totals.svo_only = n_svo_only
    totals.sov_only = n_sov_only
    totals.vso_only = n_vso_only
    totals.vos_only = n_vos_only
    totals.osv_only = n_osv_only
    totals.ovs_only = n_ovs_only
    
    totals.sv = n_sv
    totals.vs = n_vs
    totals.ov = n_ov
    totals.vo = n_vo

    totals.sv_only = n_sv_only
    totals.vs_only = n_vs_only
    totals.ov_only = n_ov_only
    totals.vo_only = n_vo_only

    totals.sv_and_obj = n_sv_and_obj
    totals.vs_and_obj = n_vs_and_obj
    totals.ov_and_sub = n_ov_and_sub
    totals.vo_and_sub = n_vo_and_sub
    
    totals.v_and_sub = n_v_and_sub
    totals.v_and_obj = n_v_and_obj
    totals.v_and_sub_and_obj = n_v_and_sub_and_obj
    
    totals.ovo = n_ovo
    totals.svs = n_svs
    totals.svs_and_obj = n_svs_and_obj
    totals.ovo_and_sub = n_ovo_and_sub

    totals.svo_and_ov = n_svo_and_ov
    totals.svo_and_vs = n_svo_and_vs
    totals.sov_and_vs = n_sov_and_vs
    totals.sov_and_vo = n_sov_and_vo
    totals.vso_and_ov = n_vso_and_ov
    totals.vso_and_sv = n_vso_and_sv
    totals.vos_and_ov = n_vos_and_ov
    totals.vos_and_sv = n_vos_and_sv
    totals.osv_and_vo = n_osv_and_vo
    totals.osv_and_vs = n_osv_and_vs
    totals.ovs_and_vo = n_ovs_and_vo
    totals.ovs_and_sv = n_ovs_and_sv
    
    detailed = Detailed_results()
    detailed.sp = sp_offsets
    detailed.sf = sf_offsets
    detailed.op = op_offsets
    detailed.of = of_offsets
    
    detailed.cites = cites
    detailed.lemmas = lemmas    
    
    
    return [totals, detailed]
        