# Communication
If you found a bug, and can provide steps to reliably reproduce it, open an issue.
If you have a feature request, open an issue
If you want to contribute, submit a pull request.
# Installation
Copying the "UITableView+Extension.swift" file into your project
# WaveTableView Usage
Here is a simple example of how to use WaveTableView:
    func btnClick(btn : UIButton) {
        tableView.reloadDataAnimate(WaveAnimation.RightToLeftWaveAnimation)
        //tableView.reloadDataAnimate(WaveAnimation.LeftToRightWaveAnimation)
    }
