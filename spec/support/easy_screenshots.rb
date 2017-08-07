module EasyScreenshots
  def screenshot!(filename: :auto_generate, selector: :none)
    return "#{SecureRandom.uuid}.png" if filename == :auto_generate
    filename = "named/#{filename}"

    options = if selector == :none
                { full: true }
              else
                { selector: selector }
              end

    screenshot_filename = "#{RSpec.configuration.screenshots_dir}/#{filename}"
    FileUtils.rm(screenshot_filename) if File.exist?(screenshot_filename)
    save_screenshot(screenshot_filename, options)
  end

  def within_with_screenshot(*args)
    if args.length == 1
      within(*args) do
        yield
        screenshot!(selector: args.first)
      end
    else
      puts "WARN: within_with_screenshot doesn't support anything other than a single selector.  You used #{args.inspect}"
      within(*args) do
        yield
      end
    end
  end
end
