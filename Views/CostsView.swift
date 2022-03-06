//
//  CostsView.swift
//  dam-project
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI

struct CostsView: View {
    var cols = [GridItem(.fixed(220)), GridItem(.flexible())]
    var cols2 = [GridItem(.flexible()), GridItem(.flexible())]
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
                TextField("Coût unitaire des fluides: ",value: $costsVM.fluidCost,formatter:formatter).padding(20)
                Text("Coût unitaire du personnel: ")
                TextField("Coût unitaire du personnel: ",value: $costsVM.personnelCost,formatter:formatter).padding(20)
                Text("Taux avec charges: ")
                TextField("Taux avec charges: ",value: $costsVM.markupWithCharges,formatter:formatter).padding(20)
                Text("Taux sans charges: ")
                TextField("Taux sans charges: ",value: $costsVM.markupWithoutCharges,formatter:formatter).padding(20)
                Text("Utiliser charges: ")
                Toggle("", isOn:$costsVM.usesChargesByDefault).padding(.trailing,120)
            }.padding(.horizontal,20)
            HStack{
                LazyVGrid(columns:cols2, alignment:.center){
                    Button("Enregistrer"){
                        costsVM.costsState.intentToChange(modyfing: Costs(fluides: costsVM.fluidCost, pers: costsVM.personnelCost, mark: costsVM.markupWithCharges, markNo: costsVM.markupWithoutCharges, charges: costsVM.usesChargesByDefault))
                    }.frame(width: 100)
                        .padding(5)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 5)
                        )
                        .padding(15)
                    Button("Annuler"){
                        costsVM.costsState.intentToChange(cancel: true)
                    }.frame(width: 100)
                        .padding(5)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 5)
                        )
                        .padding(15)
                }
            }
        }
        .onChange(of: costsVM.costsState, perform: {
            newValue in valueChanged(newValue)
        })
        .navigationTitle("Paramètres de coûts")
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
