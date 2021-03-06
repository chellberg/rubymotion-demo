class NotificationController < UIViewController
  def viewDidLoad
     super

     @table = UITableView.alloc.initWithFrame(self.view.bounds)
    Motion::Layout.new do |layout|
      layout.view self.view
      layout.subviews table: @table
      layout.vertical "|-20-[table]-0-|"
      layout.horizontal "|-0-[table]-0-|"
    end
     @table.dataSource = self
     @table.delegate = self
     @data = ['IASTA Zach submitted a profile on IASTA', 'ZacCo submitted a profile on IASTA', 'Your RFx Evaluation on IASTA has been received']
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    # return UITableViewCell for the row
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @data[indexPath.row]
    cell

  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    UIAlertView.alert "HEY YOU! #{@data[indexPath.row]}!", buttons: ['No', 'Got it.'],
      message: "Get it?",
      cancel: proc { },
      success: proc { |pressed| App.alert("Good.") if pressed == "Got it." }
  end

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Notifications (3)', image:UIImage.imageNamed('notifications.png'), tag: 1)
    self
  end

  def preferredStatusBarStyle
    UIStatusBarStyleLightContent
  end
end

