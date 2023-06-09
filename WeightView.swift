//
//  WeightView.swift
//  CalPal
//
//  Created by Harsha Venkatesh on 31/05/23.
//
import SwiftUI
extension View {
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
struct WeightView: View {
    @ObservedObject var m=ViewModel()
    init(){
        m.getDataweight()
    }
    @State var datevar=Date()
    @State var datevars = ""
    let dateformatter = DateFormatter()
    @State var weight=""
    let gradient = LinearGradient(colors: [Color.orange,Color.gray],startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack{gradient
                .opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing:0){
                
                Text(Date().addingTimeInterval(600),style: .date)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.top, .leading, .trailing])
                    .offset(x: -70, y:0 )
                Text("Lesgooooooo 💪")
                    .font(.largeTitle)
                    .offset(x: -45, y:0 )
                    .padding()
                List(){
                    HStack{
                        Text("Date")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        Text("Weight")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                    }.padding(.all)
                        .listRowBackground(
                            Rectangle()
                                .fill(Color(white: 0, opacity: 0.4))
                                .padding(.vertical, 0))
                    ForEach (m.list1, id:\.id)
                    {weight in
                        HStack{
                            Text("\(weight.date)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            Text("\(weight.weight)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }.padding(.all)
                    }.onDelete { indexSet in
                        guard let deletedIndex = indexSet.first else { return }
                        m.deleteDataweight(todoToDelete: m.list1[deletedIndex])
                        m.getDataweight()
                    }
                    .listRowBackground(
                        Rectangle()
                            .fill(Color(white: 0, opacity: 0.4))
                            .padding(.vertical, 0))
                    
                } .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
                .padding([.leading, .bottom, .trailing])
                .cornerRadius(65)
                .scrollContentBackground(.hidden)
                .offset(x: 0, y:0)
                Form{
                    DatePicker("Date",selection: $datevar,displayedComponents: .date)
                    
                    TextField("Weight",text:$weight)
                        .keyboardType(.decimalPad)
                }.frame( height: 140, alignment: .top)
                    .scrollContentBackground(.hidden)
                Spacer()
                VStack{
                    Button
                    {
                        datevars=formatDate(date: datevar)
                        m.addDataweight(date: String(datevars), weight: weight)
                        hideKeyboard()
                        
                    }label:{Text("Log").bold()
                            .padding(.horizontal, 100.0)
                            .padding()
                            .background(Color(red: 0.353, green: 0.353, blue: 0.357))
                            .clipShape(Capsule())
                            .foregroundColor(Color.white)
                        .font(.title2)}
                }
            }
        }.onTapGesture {
            hideKeyboard()}
    }
    struct WeightView_Previews: PreviewProvider {
        static var previews: some View {
            WeightView()
        }
    }
}
