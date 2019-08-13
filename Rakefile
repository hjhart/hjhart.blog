# coding: utf-8

$post_ext ||= ".markdown"
$post_dir ||= "_posts/"
$git_check ||= true
$git_autopush ||= false

#

desc 'Create a post'
task :create_post, [:title] do |t, args|
  if args.title == nil then
    puts "Error! title is empty"
    puts "Usage: create_post[date,title,category,content]"
    puts "DATE and CATEGORY are optional"
    puts "DATE is in the form: YYYY-MM-DD; use nil or empty for today's date"
    puts "CATEGORY is a string; nil or empty for no category"
    puts "Examples: create_post[\"\",\"#{args.title}\"]"
    puts "          create_post[nil,\"#{args.title}\"]"
    puts "          create_post[,\"#{args.title}\"]"
    puts "          create_post[#{Time.new.strftime("%Y-%m-%d")},\"#{args.title}\"]"
    exit 1
  end

  post_title = args.title
  post_date =  Time.new.strftime("%Y-%m-%d %H:%M:%S %Z")
  post_dir = $post_dir

  def slugify (title)
    # strip characters and whitespace to create valid filenames, also lowercase
    return title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  filename = post_date[0..9] + "-" + slugify(post_title) + $post_ext

  # generate a unique filename appending a number
  i = 1
  while File.exists?(post_dir + filename) do
    filename = post_date[0..9] + "-" +
               File.basename(slugify(post_title)) + "-" + i.to_s +
               $post_ext
    i += 1
  end

  # the condition is not really necessary anymore (since the previous
  # loop ensures the file does not exist)
  if not File.exists?(post_dir + filename) then
    File.open(post_dir + filename, 'w') do |f|
      f.puts "---"
      f.puts "title: \"#{post_title}\""
      f.puts "layout: post"
      f.puts "date: #{post_date}"
      f.puts "comments: true"
      f.puts "---"
      f.puts args.content if args.content != nil
    end

    puts "Post created under \"#{post_dir}#{filename}\""
  else
    puts "A post with the same name already exists. Aborted."
  end
  # puts "You might want to: edit #{$post_dir}#{filename}"
end
