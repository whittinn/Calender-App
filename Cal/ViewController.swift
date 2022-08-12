//
//  ViewController.swift
//  Cal
//
//  Created by Nathaniel Whittington on 4/28/22.
//

import UIKit
import EventKitUI
import EventKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
   let store = EKEventStore()
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
        setMonthView()
    }
    @IBAction func addEvent(_ sender: Any) {
       
        store.requestAccess(to: .event) { [weak self]success, error in
            DispatchQueue.main.async {
                
                guard let store = self?.store else {return}
                let newEvent = EKEvent(eventStore: store)
                newEvent.title = "New items in Store"
                
                let vc = EKEventEditViewController()
                vc.event = newEvent
                guard let strongSelf = self else {return}
                strongSelf.present(vc, animated: true)
            }
        }
    }
    
    func setCellSize(){
        let hieght = (collectionView.frame.size.height - 2 ) / 8
        let weight = (collectionView.frame.size.width - 2 ) / 8
        let flowCollection = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowCollection?.itemSize = CGSize(width: weight, height: hieght)
        
        
    }
    
    func setMonthView(){
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let firstDayOfMoneth = CalenderHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMoneth)
        
        var count : Int = 1
        
        while(count < 42){
            if( count <=  startingSpaces || count - startingSpaces > daysInMonth){
                totalSquares.append("")
            }else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
            
        }
        monthLabel.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        
    }
    @IBAction func nextMonthButton(_ sender: Any) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func lastMonthButton(_ sender: Any) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = totalSquares[indexPath.item]
        return cell
    }
}

