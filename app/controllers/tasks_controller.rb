class TasksController < UITableViewController
  
  
  # ==================
  # = View Lifecycle =
  # ==================
  
  def viewDidLoad
    self.title = "Tasks"
    [EmptyCell, TaskCell].each do |cell_class|
      tableView.registerClass(cell_class, forCellReuseIdentifier: cell_class.name)
    end
    navigationItem.rightBarButtonItem = add_button
  end
  
  # ==============
  # = Properties =
  # ==============
  
  def add_button
    @add_button ||= UIBarButtonItem.alloc.
    initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, 
    action: 'add_button_tapped:')
  end
  
  def task_alert_view
    @task_alert_view ||= UIAlertView.alloc.initWithTitle("Add A Task", 
      message: "Insert the name of the task below",
      delegate: self, cancelButtonTitle: "Add", otherButtonTitles: nil).tap do |alert|
        alert.alertViewStyle = UIAlertViewStylePlainTextInput
    end
  end
  
  def tasks
    @tasks ||= Task.all
  end
  
  # ===========
  # = Actions =
  # ===========
  
  def add_button_tapped(sender)
    NSLog("add_button_tapped:#{sender}")
    task_alert_view.show
  end
  
  # =======================
  # = UIAlertViewDelegate =
  # =======================
 
  def alertView(alert_view, clickedButtonAtIndex: index_path)
    text_field = alert_view.textFieldAtIndex(0)
    text = text_field.text
    if text.to_s.length > 0
      NSLog("Saving new Task: #{text}")  
      Task.create(name: text) 
      cdq.save
      tableView.reloadData      
    else
      NSLog("Not saving Task as text label was empty.")
    end

  end
  
  # =======================
  # = UITableViewDelegate =
  # =======================
  
  def tableView(table_view, cellForRowAtIndexPath: index_path)
    if tasks_list_empty?
      table_view.dequeueReusableCellWithIdentifier(EmptyCell.name)
    else
      task = tasks[index_path.row]
      table_view.dequeueReusableCellWithIdentifier(TaskCell.name).tap do |cell|
        cell.textLabel.text = task.name
      end
    end
  end
  
  # =========================
  # = UITableViewDataSource =
  # =========================
  
  def tableView(table_view, heightForRowAtIndexPath: index_path)
    tasks_list_empty? ? tableView.frame.size.height : 60
  end
  
  def tableView(table_view, numberOfRowsInSection: section)
    tasks_list_empty? ? 1 : Task.count
  end
  
  def numberOfSectionsInTableView(table_view)
    1
  end
  
  
  private
  
  
  def tasks_list_empty?
    Task.count == 0
  end
  
end