// MARK: - put these inside the scene delegate before window stuf


// TAB BAR BACKGROUND COLOR HERE.
        UITabBar.appearance().barTintColor = UIColor.white
        
        // TAB BAR ICONS COLOR HERE.
        UITabBar.appearance().tintColor = UIColor.systemBlue
        UITabBar.appearance().isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            // TAB BAR BACKGROUND COLOR HERE. (same as above)
            appearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
        
        // correct the transparency bug for Navigation bars
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
