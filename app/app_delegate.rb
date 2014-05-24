class AppDelegate
  def ui_height; 480; end
  def ui_width; 640; end

  def applicationDidFinishLaunching(notification)
    @remote = Remote::Control.new(Remote::Connection.new("72230083"))

    buildMenu
    build_window
    build_configuration_panel
    add_keys
  end

  def build_window
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [ui_width, ui_height]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end

  def key_pressed(sender)
    @remote.send_command(@remote.commands[sender.tag])
  end

  def build_configuration_panel
    opts = {
      NSContinuouslyUpdatesValueBindingOption   => true,
      NSAllowsNullArgumentBindingOption         => false,
      NSInsertsNullPlaceholderBindingOption     => true,
      NSRaisesForNotApplicableKeysBindingOption => true
    }

    code_label = NSTextField.alloc.initWithFrame([[100, 40], [200, 20]])
    code_label.editable = false
    code_label.setStringValue "Remote code"

    code_field = NSTextField.alloc.initWithFrame([[200, 40], [200, 20]])
    code_field.setStringValue "salutii"
    code_field.bind(NSValueBinding, toObject: @remote, withKeyPath: 'connection.code', options: opts)

    @mainWindow.contentView.addSubview(code_label)
    @mainWindow.contentView.addSubview(code_field)
  end

  def add_keys
    size = 70
    height = 5
    margin = 60
    @remote.commands.each_with_index do |command,index|
      button = NSButton.alloc.initWithFrame([[(index / height) * size, ui_height - margin - ((index) % height) * size], [size, size]])
      button.title = command
      button.tag = index
      button.action = :"key_pressed:"
      button.target = self
      button.bezelStyle = NSRoundedBezelStyle
      button.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin
      @mainWindow.contentView.addSubview(button)
    end
  end

end
