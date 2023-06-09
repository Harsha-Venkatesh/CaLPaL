//
//  ContentView.swift
//  CalPal
//
//  Created by Harsha Venkatesh on 31/05/23.

import SwiftUI
import Firebase
struct ContentView: View {
    @ObservedObject var m=ViewModel()
    
    init(){
        m.getData()
        m.weekData()
        m.getweekdata()
        m.goals()
    }
    
    var window:UIWindow?
    let gradient = LinearGradient(colors: [Color.orange,Color.black],
                                  startPoint: .top, endPoint: .bottom)
    var body: some View{
        NavigationView{
            ZStack{gradient
                .opacity(0.4)
                .ignoresSafeArea()
                VStack(spacing:0){
                    Text(Date().addingTimeInterval(600),style: .date)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                        .offset(x: -75, y:-30 )
                    Text("Goals completed 💪")
                        .fontWeight(.bold)
                        .padding(.all)
                        .onAppear(perform: m.goals)
                        .font(.title)
                        .offset(x: -45, y:-50 )
                    Text("This week : \(m.goalscomplete)/7")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.all)
                        .offset(x: -100, y: -70)
                    Divider().frame(width:400).offset(x: 0, y:-70)
                    HStack(spacing :150){
                        Text("Day")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Kcal")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.all)
                            .offset(x: 25, y:0)
                    }.offset(x: 0, y:-60)
                    Divider().frame(width:400).offset(x: 0, y:-52)
                    HStack(spacing :80){
                        List(){
                            ForEach (m.weeklist, id:\.id)
                            {
                                todaycal in
                                HStack{
                                    Text("\(todaycal.Day)")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                    
                                    Spacer()
                                    Text("\(todaycal.Totalcal)")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                }.padding(.all, 11.0)
                            }
                            .listRowBackground(
                                Rectangle()
                                    .fill(Color(white: 0, opacity: 0.4))
                                    .padding(.vertical, 0))
                        }
                        .onAppear() {
                            m.getweekdata()
                            m.goals()
                            UITableView.appearance().backgroundColor = UIColor.clear
                            UITableViewCell.appearance().backgroundColor = UIColor.clear
                        }
                        
                    }
                    .offset(x: 0, y:-50).frame(width: 400, height: 450)
                    .colorScheme(.light)
                    .scrollContentBackground(.hidden)
                    HStack(spacing : 80){
                        NavigationLink(destination: WeightView()){Text("WEIGHT").font(.title).fontWeight(.black).foregroundColor(Color.white)
                        }.offset(x:-10, y: 0)
                        NavigationLink(destination: TodayView()){Text("TODAY")
                                .font(.title)
                                .fontWeight(.black)
                            .foregroundColor(Color.white)}.offset(x:5, y: 0)
                    }
                }.frame(maxWidth: .infinity).offset(x: 0, y: -40)
            }.accentColor(.black)
        }.navigationBarTitle(Text(""),displayMode: .inline).tint(.black)
            .accentColor(.black)
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
            }
            
        }
    }
}


