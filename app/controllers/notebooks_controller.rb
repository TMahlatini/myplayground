require 'kramdown'

class NotebooksController < ApplicationController
    layout "notebook"


    def notebook
        @content = File.read(Rails.root.join('app/content/NoteBook/notebook.md'))
        @markdown = Kramdown::Document.new(@content).to_html
    end

    def books
        @content = File.read(Rails.root.join('app/content/NoteBook/books.md'))
        @markdown = Kramdown::Document.new(@content).to_html
    end

    def conversations
        @content = File.read(Rails.root.join('app/content/NoteBook/conversations.md'))
        @markdown = Kramdown::Document.new(@content).to_html
    end

    def random
        @content = File.read(Rails.root.join('app/content/NoteBook/random.md'))
        @markdown = Kramdown::Document.new(@content).to_html
    end
end
