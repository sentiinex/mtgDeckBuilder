//
//  AdvancedSearchTableViewController Extension 2.swift
//  MTGPrices
//
//  Created by Gabriele Pregadio on 1/5/17.
//  Copyright © 2017 Gabriele Pregadio. All rights reserved.
//

import UIKit

extension AdvancedSearchTableViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SwitchDelegate {
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        sectionBeingEdited = textField.tag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        sectionBeingEdited = nil
        switch textField.tag {
        case ButtonTags.name: cardName = textField.text
        case ButtonTags.text: rulesText = textField.text
        case ButtonTags.subtype: subtype = textField.text
        default: return
        }
    }
    
    
    // MARK: - UIPickerView Delegate & Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag, component) {
        case (_, 0): return 5
        case (PickerViewTags.cmc, 1): return 17
        case (PickerViewTags.power, 1): return 17
        case (PickerViewTags.toughness, 1): return 17
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (component, row) {
        case (0, _): return pickerViewRestrictions[row]
        case (1, 0): return "any"
        case (1, _): return "\(row - 1)"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case PickerViewTags.cmc:
            switch (component, row) {
            case (0, _): cmcRestriction = pickerViewRestrictions[row]
            case (1, 0): cmc = "any"
            default: cmc = "\(row - 1)"
            }
        case PickerViewTags.power:
            switch (component, row) {
            case (0, _): powerRestriction = pickerViewRestrictions[row]
            case (1, 0): power = "any"
            default: power = "\(row - 1)"
            }
        case PickerViewTags.toughness:
            switch (component, row) {
            case (0, _): toughnessRestriction = pickerViewRestrictions[row]
            case (1, 0): toughness = "any"
            default: toughness = "\(row - 1)"
            }
        default: return
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Switch Delegate Methods
    
    func switchDidToggle(to value: Bool, tag: Int) {
        switch tag {
        case SwitchTags.matchColorsExactly: matchColorsExactly = value
        case SwitchTags.andColors: andColors = value
        case SwitchTags.andTypes: andTypes = value
        default: return
        }
    }
    
}
