def divide(x, y)
  begin
    result = x / y
  rescue => e
    puts "Error Class: #{e.class}"
    puts "Error Message: #{e.message}"
    puts "Error Backtrace: #{e.backtrace}"
  end
  raise "Invalid result" if result.nil?

  result
end

divide(10, 0)

