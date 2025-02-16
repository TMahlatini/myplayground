require 'kramdown'

class PagesController < ApplicationController
  def home
  end

  def about
    @content = File.read(Rails.root.join('app/content/about.md'))
    @markdown = Kramdown::Document.new(@content).to_html
  end

  def now
    @content = File.read(Rails.root.join('app/content/now.md'))
    @markdown = Kramdown::Document.new(@content).to_html
  end

  def notes
    @content = File.read(Rails.root.join('app/content/notes.md'))
    @markdown = Kramdown::Document.new(@content).to_html
  end

  def experiences
    @content = File.read(Rails.root.join('app/content/experiences.md'))
    @markdown = Kramdown::Document.new(@content).to_html
  end




end
