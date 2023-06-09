//
//  TodayView.swift
//  CalPal
//
//  Created by Harsha Venkatesh on 31/05/23.
//

import SwiftUI
import Firebase
struct TodayView: View {
    @ObservedObject var m=ViewModel()
    @State var caloriesremaining=1650
    @State var item=""
    @State var sum=0
    @State var cal=""
    init(){
        m.getData()
        m.getweekdata()
    }
    @State var i=0
    let gradient = LinearGradient(colors: [Color.orange,Color.gray],
                                  startPoint: .top, endPoint: .bottom)
    @available(iOS 16.0, *)
    @available(iOS 16.0, *)
    var body: some View {
        
        ZStack{gradient
            .opacity(0.6)
            .ignoresSafeArea()
            VStack(spacing:0){
                
                Text(Date().addingTimeInterval(600),style: .date)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.all)
                    .offset(x: -70, y:0 )
                Text("Calories remaining \(1650-m.todaysum)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(21.0).background(Color(hue: 1.0, saturation: 0.079, brightness: 0.203))
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .offset(x: 0, y:0 )
                List(){
                    HStack{
                        Text("Item")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        Text("Kcal")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                    }.padding(.all)
                        .listRowBackground(
                            Rectangle()
                                .fill(Color(white: 0, opacity: 0.4))
                                .padding(.vertical, 0))
                    
                    ForEach (m.list, id:\.id)
                    {
                        todaycal in
                        HStack{
                            Text("\(todaycal.Item)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            Text("\(todaycal.Cal)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }.padding(.all)
                    }.onDelete { indexSet in
                        guard let deletedIndex = indexSet.first else { return }
                        m.deleteData(todoToDelete: m.list[deletedIndex]
                        )
                        m.weekData()
                    }
                    .listRowBackground(
                        Rectangle()
                            .fill(Color(white: 0, opacity: 0.4))
                            .padding(.vertical, 0))
                }
                .scrollContentBackground(.hidden)
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                }
                .padding(.bottom,0)
                .offset(x: 0, y:0)
                Form{
                    TextField("Iteam",text:$item)
                    TextField("Caloreis",text:$cal)
                        .keyboardType(.decimalPad)
                }.scrollContentBackground(.hidden)
                    .frame( height:140, alignment: .top)
                Button
                {
                    m.addData(item: item, cal: cal)
                    item=""
                    cal=""
                    m.weekData()
                }label:{Text("Add").bold()
                        .padding(.horizontal, 100.0)
                        .padding()
                        .background(Color(red: 0.353, green: 0.353, blue: 0.357))
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                    .font(.title2)}
            }
        }.onTapGesture {
            hideKeyboard()}
    }
}
struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
