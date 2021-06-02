//
//  InterfaceController.swift
//  TelegramWatchApp WatchKit Extension
//
//  Created by Andrii Yehortsev on 19.05.2021.
//

import QRCodeSwift
import WatchKit

class InterfaceController: WKInterfaceController {
	
    @IBOutlet weak var chevronIconTop: WKInterfaceImage!
    @IBOutlet weak var chevronIconBottom: WKInterfaceImage!
    @IBOutlet weak var bodyText: WKInterfaceLabel!
    @IBOutlet weak var headline: WKInterfaceLabel!
    @IBOutlet weak var group: WKInterfaceGroup!
    @IBOutlet weak var telegramIconImg: WKInterfaceImage!
    @IBOutlet weak var qrCodeImg: WKInterfaceGroup!
    @IBOutlet weak var qrCodeImage: WKInterfaceImage!
    
    
    var rectPathToStroke = UIBezierPath() {
        didSet {
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.saveGState()
            rectPathToStroke.addClip()
            ctx?.addPath(rectPathToStroke.cgPath)
            ctx?.strokePath()
            ctx?.restoreGState()
        }
    }
    
    var rectPathToFill = UIBezierPath() {
        didSet {
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.addPath(rectPathToFill.cgPath)
            ctx?.fillPath()
//            rectPathToFill.fill()
        }
    }
    override func awake(withContext context: Any?) {
        self.setupViews()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
					
        // This method is called when watch view controller is no longer visible
    }
    
    
    func setupViews() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        self.headline.setAttributedText(
            NSAttributedString(
                string: "Log in to Telegram\nby QR Code",
                attributes: [
                    .font : UIFont.systemFont(ofSize: 17, weight: .medium),
                ]
            )
        )
        
        let symbol = UIImage(
            systemName: "chevron.down",
            withConfiguration: UIImage.SymbolConfiguration(
                font: UIFont.systemFont(ofSize: 14, weight: .regular))
        )
        self.chevronIconTop.setImage(symbol)
        self.chevronIconBottom.setImage(symbol)
        self.drawQRCode()
    }

	func drawQRCode() {
//        let myString = "tg://login?token=AQEvb6lgQoAsafSvUgPG7slBRELzdJJgV00AkQ-A7Z5P7Q"
//        let codeString = "tg://login?token=AQG33atgQoAsafSvUgMG5ZhnUqHb71haMyHdH_JagtCjiA"
//        let qrString = "tg://login?token=AQE0g7VgzIfJH_TuWgUOm2_esbMMm8r3nugVmDXUWLjU4w"

        var code = "tg://login?token=AQFCqrVgzIfJH_TuWgUBJSBXNtwkLgRkWZQ3BbrRqJy2yQ"
        guard let qrCode = try? QRCode("tg://login?token=AQFCqrVgzIfJH_TuWgUBJSBXNtwkLgRkWZQ3BbrRqJy2yQ", errorCorrectLevel: .M, withBorder: false) else {
//		guard let qrCode = try? QRCode("1", errorCorrectLevel: .H, withBorder: false) else {
			
			fatalError("Failed to generate QRCode")
			
		}

        let width = WKInterfaceDevice.current().screenBounds.width
        var codes = qrCode.imageCodes
        let bitWidth =  (width - 20) / CGFloat(codes.count)
        let padding = (width - bitWidth * CGFloat(codes.count)) / 2
        let count = codes.count
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), true, 0)
        let ctx = UIGraphicsGetCurrentContext()
		ctx?.setFillColor(UIColor.white.cgColor)
		ctx?.fill(CGRect(x: 0, y: 0, width: width, height: width))
        ctx?.setFillColor(UIColor.black.cgColor)
        ctx?.setLineWidth(bitWidth * 2)

        rectPathToStroke = UIBezierPath(
            roundedRect: CGRect(
                x: padding,
                y: padding,
                width: bitWidth * 7,
                height: bitWidth * 7
            ),
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
            cornerRadii: CGSize(width: bitWidth * 2, height: bitWidth * 2)
        )
        
        rectPathToStroke = UIBezierPath(
            roundedRect: CGRect(
                x: padding + bitWidth * (CGFloat(count) - 7),
                y: padding,
                width: bitWidth * 7,
                height: bitWidth * 7
            ),
            byRoundingCorners: [.topLeft, .topRight, .bottomRight],
            cornerRadii: CGSize(width: bitWidth * 2, height: bitWidth * 2)
        )
        
        rectPathToStroke = UIBezierPath(
            roundedRect: CGRect(
                x: padding,
                y: padding + bitWidth * (CGFloat(count) - 7),
                width: bitWidth * 7,
                height: bitWidth * 7
            ),
            byRoundingCorners: [.topLeft, .bottomRight, .bottomLeft],
            cornerRadii: CGSize(width: bitWidth * 2, height: bitWidth * 2)
        )
  
        rectPathToFill = UIBezierPath(
            roundedRect: CGRect(
                x: padding + bitWidth * 2,
                y: padding + bitWidth * 2,
                width: bitWidth * 3,
                height: bitWidth * 3
            ),
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
            cornerRadii: CGSize(width: bitWidth * 0.75, height: bitWidth * 0.75)
        )
        
        rectPathToFill = UIBezierPath(
            roundedRect: CGRect(
                x: padding + bitWidth * (CGFloat(count) - 5),
                y: padding + bitWidth * 2,
                width: bitWidth * 3,
                height: bitWidth * 3
            ),
            byRoundingCorners: [.topLeft, .topRight, .bottomRight],
            cornerRadii: CGSize(width: bitWidth * 0.75, height: bitWidth * 0.75)
        )
        
        rectPathToFill = UIBezierPath(
            roundedRect: CGRect(
                x: padding + bitWidth * 2,
                y: padding + bitWidth * (CGFloat(count - 5)),
                width: bitWidth * 3,
                height: bitWidth * 3
            ),
            byRoundingCorners: [.topLeft, .bottomRight, .bottomLeft],
            cornerRadii: CGSize(width: bitWidth * 0.75, height: bitWidth * 0.75)
        )
        
    	
        let iconCircle = UIBezierPath(
            arcCenter: CGPoint(x: width / 2, y: width / 2),
            radius: 21.0,
            startAngle: .zero,
            endAngle: .pi * 2,
            clockwise: true
        )
        iconCircle.close()
     
        var x = padding
        var y = padding
	
        for row in codes.indices {
            for col in codes[row].indices {
                let rect = CGRect(
                    x: CGFloat(x),
                    y: CGFloat(y),
                    width: bitWidth,
                    height: bitWidth
                )
                
                if iconCircle.contains(CGPoint(x: rect.minX, y: rect.minY)) ||
                   iconCircle.contains(CGPoint(x: rect.maxX, y: rect.maxY)) ||
                   iconCircle.contains(CGPoint(x: rect.minX, y: rect.maxY)) ||
                   iconCircle.contains(CGPoint(x: rect.maxX, y: rect.minY))
                {
                    codes[row][col] = false
                }
                x += bitWidth
            }
            x = padding
            y += bitWidth

        }
		
        x = padding
        y = padding
        
		for row in codes.indices {
			for col in codes[row].indices {
                let rect = CGRect(
                    x: CGFloat(x),
                    y: CGFloat(y),
                    width: bitWidth,
                    height: bitWidth
                )
                
				if codes[row][col] {
                    if (col > 6 && col < count - 7) ||
                       (row > 6 && row < count - 7) ||
                       (col >= count - 7 && row >= count - 7)
					{
						var roundedCorners: UIRectCorner = []
                        
						if (row == 0 || !codes[row - 1][col]) &&
                           (col == 0 || !codes[row][col - 1])
                        {
							roundedCorners.insert(UIRectCorner.topLeft)
						}

                        if (row == 0 || !codes[row - 1][col]) &&
                           (col == count - 1 || !codes[row][col + 1])
                        {
							roundedCorners.insert(UIRectCorner.topRight)
						}
                        
                        if (row == count - 1 || !codes[row + 1][col]) &&
                           (col == count - 1 || !codes[row][col + 1])
                        {
							roundedCorners.insert(UIRectCorner.bottomRight)
						}

						if (row == count - 1 || !codes[row + 1][col]) &&
                           (col == 0 || !codes[row][col - 1])
                        {
							roundedCorners.insert(UIRectCorner.bottomLeft)
						}
						
                        rectPathToFill = UIBezierPath(
                            roundedRect: rect,
                            byRoundingCorners: roundedCorners,
                            cornerRadii: CGSize(
                                width: bitWidth * 0.32,
                                height: bitWidth * 0.32
                            )
                        )
					}
                }
				x += bitWidth
			}
			y += bitWidth
            x = padding
		}
        
		let img = UIGraphicsGetImageFromCurrentImageContext()!
		qrCodeImage.setImage(img)
        UIGraphicsEndImageContext()
	}
	
    func createRectPath(
        origin: CGPoint,
        size: CGSize,
        corners: UIRectCorner = [],
        radius: CGSize
    ) -> UIBezierPath
    {
        let rect = CGRect(origin: origin, size: size)
        return UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radius)
    }
    /*
    func createQRCode() {
        let currentDevice = WKInterfaceDevice.current()
        let bounds = currentDevice.screenBounds
        let scaleFactor = currentDevice.screenScale
        print("bounds = \(bounds)", "scale = \(scaleFactor)")
        let myString = "tg://login?token=AQEvb6lgQoAsafSvUgPG7slBRELzdJJgV00AkQ-A7Z5P7Q"
        let codeString = "tg://login?token=AQG33atgQoAsafSvUgMG5ZhnUqHb71haMyHdH_JagtCjiA"
        let qrString = "tg://login?token=AQE0g7VgzIfJH_TuWgUOm2_esbMMm8r3nugVmDXUWLjU4w"
        guard let qrCode = try? QRCode("1") else {
            fatalError("Failed to generate QRCode")
            
        }
        
        
        if let image = EFQRCode.generate(
            for: "tg://login?token=AQFRqbVgzIfJH_TuWgXL4yzli-QEi0CuncXt8jG9OAPzRg",
            size: EFIntSize(width: Int(bounds.width - 6), height: Int(bounds.width - 6))
        ) {
            print("Create QRCode image success \(image)")
            self.qrCodeImage.setImage(UIImage(cgImage: image))
        } else {
            print("Create QRCode image failed!")
            
        }
        
    }
	*/
}
