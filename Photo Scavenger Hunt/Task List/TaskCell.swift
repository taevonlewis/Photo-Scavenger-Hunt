//
//  TaskCell.swift
//  Photo Scavenger Hunt
//
//  Created by TaeVon Lewis on 3/14/23.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var completedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        titleLabel.textColor = task.isComplete ? .secondaryLabel : .label
        completedImageView.image = UIImage(systemName: task.isComplete ? "circle.inset.filled" : "circle")?.withRenderingMode(.alwaysTemplate)
        completedImageView.tintColor = task.isComplete ? .systemGreen : .tertiaryLabel
        completedImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
}

