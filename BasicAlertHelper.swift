// Usage
showBasicAlert(title: "Alert", text: "message")

// or
showBasicAlert(title: "Alert", text: "message") {
  // some completion action
}

// --------------

func showBasicAlert(title: String, text: String, completion: (() -> Void)? = nil){
  let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
  let cancel = UIAlertAction(title:"Ок", style: .default)
  alertController.addAction(cancel)
        
  present(alertController, animated:true, completion: {
    guard let callback = completion else { return }
    DispatchQueue.main.async {
      callback()
    }
  })
}
