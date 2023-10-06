# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Task CRUD_', type: :feature do
  let(:title) { 'TaskTitle' }
  let(:content) { "Task's content" }

  describe '任務的列表' do
    it 'visit root path' do
      visit tasks_path
      expect(page).to have_selector('h1', text: 'Task list')
    end
  end

  describe '新增任務' do
    it 'success create task' do
      create_tasks(title, content)
      expect(page).to have_content('Task was successfully created.')
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    it 'unsuccess create task because do not input title and content' do
      create_tasks('', '')
      expect(page).to have_content('2 errors prohibited this content from being saved:')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Content can't be blank")
    end

    it 'unsuccess create task because do not input title' do
      create_tasks('', content)
      expect(page).to have_content('1 error prohibited this content from being saved:')
      expect(page).to have_content("Title can't be blank")
    end

    it 'unsuccess create task because do not input content' do
      create_tasks(title, '')
      expect(page).to have_content('1 error prohibited this content from being saved:')
      expect(page).to have_content("Content can't be blank")
    end
  end

  describe '檢視任務' do
    it 'show the task' do
      create_tasks(title, content)
      visit tasks_path
      expect(Task.all == 1)
    end
  end

  describe '修改任務' do
    it 'edit and update task and content' do
      create_tasks(title, content)
      edit_tasks(title, content)
      expect(page).to have_content('Task was successfully edied')
    end

    it "Only edit the task's titile, and content is empty" do
      create_tasks(title, content)
      edit_tasks(content, '')
      expect(page).to have_content('1 error prohibited this content from being saved:')
      expect(page).to have_content("Content can't be blank")
    end

    it "Only update the task's content, and title is empty" do
      create_tasks(title, content)
      edit_tasks('', content)
      expect(page).to have_content('1 error prohibited this content from being saved:')
      expect(page).to have_content("Title can't be blank")
    end
  end

  describe '刪除任務' do
    it 'Destory a task' do
      create_tasks(title, content)
      click_on 'Delete'
      expect(page).to have_content('Task deleted successfully')
    end
  end

  private

  def create_tasks(title, content)
    visit tasks_path
    click_link 'New Task'
    fill_in 'task_title', with: title
    fill_in 'task_content', with: content
    click_button 'Create Task'
  end

  def edit_tasks(title, content)
    visit tasks_path
    click_on 'Edit'
    fill_in 'task_title', with: title
    fill_in 'task_content', with: content
    click_on 'Update Task'
  end
end
