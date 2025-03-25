require 'kramdown'

class NotebooksController < ApplicationController
    layout "notebook"


    def notebook
        posts = []
        @markdown = File.read(Rails.root.join('app/content/NoteBook/notebook.md'))

        # Gather book posts
        Dir.glob(Rails.root.join('app/content/NoteBook/books/*.md')).each do |file|
            content = File.read(file)
            posts << {
                category: 'book',
                identifier: File.basename(file, '.md'),
                title: extract_title(content),
                date: extract_date(content)
            }
        end

        # Gather conversation posts
        Dir.glob(Rails.root.join('app/content/NoteBook/conversations/*.md')).each do |file|
            content = File.read(file)
            posts << {
                category: 'conversation',
                identifier: File.basename(file, '.md'),
                title: extract_title(content),
                date: extract_date(content)
            }
        end

        # Gather random posts
        Dir.glob(Rails.root.join('app/content/NoteBook/random/*.md')).each do |file|
            content = File.read(file)
            posts << {
                category: 'random',
                identifier: File.basename(file, '.md'),
                title: extract_title(content),
                date: extract_date(content)
            }
        end

        # Sort posts by date (newest first); if a post lacks a date or the date is unparsable, default to a very early date.
        posts.sort_by! do |post|
            begin
                post[:date] ? Date.parse(post[:date]) : Date.new(0)
            rescue ArgumentError
                Date.new(0)
            end
        end
        posts.reverse!

        @posts = posts
    end

    # Books 
    def books
        @books = Dir.glob(Rails.root.join('app/content/NoteBook/books/*.md')).map do |file|
            content = File.read(file)
            {
                identifier: File.basename(file, '.md'),
                title: extract_title(content),
                summary: extract_summary(content),
                date: extract_date(content)
            }
        end
    end

    def book_post
        identifier = params[:id]
        file_path = Rails.root.join('app/content/NoteBook/books', "#{identifier}.md")
        unless File.exist?(file_path)
            render plain: "Book not found", status: :not_found and return
        end

        @content = File.read(file_path)
        @content = @content.gsub(/^---(.*?)---/m, '')
        @content = @content.gsub(/^#(.*?)#/, '')
        @markdown = Kramdown::Document.new(@content).to_html

        #navigation
        @book_files = Dir.glob(Rails.root.join('app/content/NoteBook/books/*.md')).sort
        @current_index = @book_files.find_index(file_path.to_s)
        @previous_book = @current_index && @current_index > 0 ? @book_files[@current_index - 1] : nil
        @next_book = @current_index && @current_index < @book_files.size - 1 ? @book_files[@current_index + 1] : nil

    end

    # Conversations

    def conversations
       @conversations = Dir.glob(Rails.root.join('app/content/NoteBook/conversations/*.md')).map do |file|
        content = File.read(file)
        {
            identifier: File.basename(file, '.md'),
            title: extract_title(content),
            summary: extract_summary(content),
            date: extract_date(content)
        }
        end
    end

    def conversation_post
        identifier = params[:id]
        file_path = Rails.root.join('app/content/NoteBook/conversations', "#{identifier}.md")
        unless File.exist?(file_path)
            render plain: "Conversation not found", status: :not_found and return
        end

        @content = File.read(file_path)
        @content = @content.gsub(/^---(.*?)---/m, '')
        @content = @content.gsub(/^#(.*?)#/, '')
        @markdown = Kramdown::Document.new(@content).to_html

        #navigation
        @conversation_files = Dir.glob(Rails.root.join('app/content/NoteBook/conversations/*.md')).sort
        @current_index = @conversation_files.find_index(file_path.to_s)
        @previous_conversation = @current_index && @current_index > 0 ? @conversation_files[@current_index - 1] : nil
        @next_conversation = @current_index && @current_index < @conversation_files.size - 1 ? @conversation_files[@current_index + 1] : nil
    end
    
    # Random
    def random
       @random_posts = Dir.glob(Rails.root.join('app/content/NoteBook/random/*.md')).map do |file|
        content = File.read(file)
        {
            identifier: File.basename(file, '.md'),
            title: extract_title(content),
            summary: extract_summary(content),
            date: extract_date(content)
        }
       end
    end

    def random_post
        identifier = params[:id]
        file_path = Rails.root.join('app/content/NoteBook/random', "#{identifier}.md")
        unless File.exist?(file_path)
            render plain: "Random post not found", status: :not_found and return
        end

        @content = File.read(file_path)
        @content = @content.gsub(/^---(.*?)---/m, '')
        @content = @content.gsub(/^#(.*?)#/, '')
        @markdown = Kramdown::Document.new(@content).to_html

        #navigation
        @random_files = Dir.glob(Rails.root.join('app/content/NoteBook/random/*.md')).sort
        @current_index = @random_files.find_index(file_path.to_s)
        @previous_post = @current_index && @current_index > 0 ? @random_files[@current_index - 1] : nil
        @next_post = @current_index && @current_index < @random_files.size - 1 ? @random_files[@current_index + 1] : nil
    end

    private

    def extract_title(content)
        if content =~ /---(.*?)---/m
            front_matter = Regexp.last_match(1)
            if front_matter =~ /title:\s*(.*+)/
                return $1.strip
            end
        end
        content.split("\n").find { |line| line.strip.start_with?("#") }&.sub(/^#/, "")&.strip || "Untitled"
    end

    def extract_summary(content)
        if content =~ /---(.*?)---/m
            front_matter = Regexp.last_match(1)
            if front_matter =~ /summary:\s*(.*+)/
                return $1.strip
            end
        end
        "..."
    end

    def extract_date(content)
        if content =~ /---(.*?)---/m
            front_matter = Regexp.last_match(1)
            if front_matter =~ /date:\s*(.*+)/
                return $1.strip
            end
        end
    end



end
