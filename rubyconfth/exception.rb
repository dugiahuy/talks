def divide(x, y)
  puts "$! = #{$!}"
  puts "$@ = #{$@}"
  begin
    result = x / y
  rescue => e
    puts "===================="
    puts "$! = #{$!}"
    puts "$@ = #{$@}"
    puts "===================="
    puts "Error Message: #{e.message}"
    puts "Error Backtrace: #{e.backtrace}"
  end
  result
end

divide(10, 0)

