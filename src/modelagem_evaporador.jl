using DrWatson
quickactivate
using CoolProp
import CoolProp.CoolProp as CP
using Unitful
include(srcdir("calor_requerido.jl"))
p_cond = 1600000u"Pa"
p_evap = 180000u"Pa"
conc_amonia= 0.97
function evaporador(P_cond,P_evap,conc_amonia)
    calor_requ= CalorRequisitadoResfri(2.5)
    conc_agua = 1- conc_amonia
    CP.apply_simple_mixing_rule('Water','Ammonia','linear')
    h_saida_cond = CP.PropsSI("Hmass", "P", P_evap.val, "Q", 1.0, 'Water[conc_agua]&Ammonia[conc_amonia]')
    h_entrada_evap = h_saida_cond #Considerando uma expansão isentálpica 
    h_saida_evap = CP.PropsSI("Hmass", "P", P_cond.val, "Q", 0.0, 'Water[conc_agua]&Ammonia[conc_amonia]')
    vazao_massica_amonia = calor_requ / (h_entrada_evap - h_saida_evap)
    return(vazao_massica_amonia)
end
