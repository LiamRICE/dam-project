//
//  CostsView.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI

struct CostsView: View {
    var cols = [GridItem(.flexible()), GridItem(.flexible())]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @EnvironmentObject var costsVM: CostsVM
    
    var body: some View {
        VStack{
            LazyVGrid(columns:cols, alignment:.leading){
                Text("Coût unitaire des fluides: ")
                TextField("Coût unitaire des fluides: ",value: $costsVM.fluidCost,formatter:formatter)
                Text("Coût unitaire du personnel: ")
                TextField("Coût unitaire du personnel: ",value: $costsVM.personnelCost,formatter:formatter)
                Text("Taux avec charges: ")
                TextField("Taux avec charges: ",value: $costsVM.markupWithCharges,formatter:formatter)
                Text("Taux sans charges: ")
                TextField("Taux sans charges: ",value: $costsVM.markupWithoutCharges,formatter:formatter)
            }
            Toggle("Utiliser charges:", isOn:$costsVM.usesChargesByDefault)
            HStack{
                Button("Enregistrer"){
                    costsVM.costsState.intentToChange(modyfing: Costs(fluides: costsVM.fluidCost, pers: costsVM.personnelCost, mark: costsVM.markupWithCharges, markNo: costsVM.markupWithoutCharges, charges: costsVM.usesChargesByDefault))
                }
                Button("Annuler"){
                    costsVM.costsState.intentToChange(cancel: true)
                }
            }
        }
        .onChange(of: costsVM.costsState, perform: {
            newValue in valueChanged(newValue)
        })
    }
    
    private func valueChanged(_ newValue: CostsIntent){
        switch newValue{
        case .modifiedCosts(_), .cancelledCosts:
            costsVM.costsState = .ready
        default:
            return
        }
    }
}

struct CostsView_Previews: PreviewProvider {
    static var previews: some View {
        CostsView()
    }
}
