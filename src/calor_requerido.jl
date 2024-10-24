using DrWatson
quickactivate
using CoolProp
using Unitful
function CalorRequisitadoResfri(volume_tanque)
    volume_diario_leite = 5000u"L"
    volume_metade = (volume_diario_leite / 2) |> u"m^3"
    volume_tanque = volume_metade #Depois que definir o tamanho do tanque, tirar essas linhas 
    temp_inicial_leite = 311.15u"K"
    temp_final_leite = 276.15u"K"
    pressao_leite = 1.01325u"bar"
    substance = "Water"
    cp_leite = PropsSI("Cpmass", "T", temp_inicial_leite.val, "P", pressao_leite.val * 1e5, substance) * u"J/(kg*K)"
    delta_temp = temp_final_leite - temp_inicial_leite
    densidade_leite = 1030u"kg/m^3"

    massa_leite = volume_tanque * densidade_leite 
    calor_requisitado = massa_leite * delta_temp * cp_leite
    return(calor_requisitado)
end