# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Task CRUD_', type: :feature do
  let(:title) { 'TaskTitle' }
  let(:content) { "Task's content" }
  let(:end_time) { Time.now + 1.month }

  describe '任務的列表' do
    it 'visit root path' do
      visit tasks_path
      expect(page).to have_selector('h1', text: I18n.t('list').to_s)
    end
  end

  describe '新增任務' do
    it 'success create task' do
      create_tasks(title, content, end_time)
      expect(page).to have_content(I18n.t('controllers.tasks.create.notice').to_s)
      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end

    it 'unsuccess create task because do not input title and content' do
      create_tasks('', '', '')
      expect(page).to have_content('3 errors prohibited this content from being saved :')
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.content').to_s)
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.title').to_s)
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.end_time').to_s)
    end

    it 'unsuccess create task because do not input title' do
      create_tasks('', content, end_time)
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.title').to_s)
      expect(page).to have_content(content)
    end

    it 'unsuccess create task because do not input content' do
      create_tasks(title, '', end_time)
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.content').to_s)
    end
  end

  describe '檢視任務' do
    it 'show the task' do
      create_tasks(title, content, end_time)
      visit tasks_path
      expect(Task.all == 1)
    end
  end

  describe '修改任務' do
    it 'edit and update task and content' do
      create_tasks(title, content, end_time)
      edit_tasks(title, content, end_time)
      expect(page).to have_content('Task was successfully edied')
    end

    it "Only edit the task's titile, and content is empty" do
      create_tasks(title, content, end_time)
      edit_tasks(title, '', end_time)
      expect(page).to have_content('1 error prohibited this content from being saved :')
    end

    it "Only update the task's content, and title is empty" do
      create_tasks(title, content, end_time)
      edit_tasks('', content, end_time)
      expect(page).to have_content('1 error prohibited this content from being saved :')
      expect(page).to have_content(I18n.t('activerecord.errors.models.task.attributes.title').to_s)
    end
  end

  describe '刪除任務' do
    it 'Destory a task' do
      create_tasks(title, content, end_time)
      click_on 'Delete'
      expect(page).to have_content('Task deleted successfully')
    end
  end

  describe 'sorting tasks by end_time' do
    it 'Use ASC order, and it have the right order' do
      tasks = []
      5.times do |id|
        task = create(:task, title: "task#{id}", content: '1', end_time: Time.now + 1.month)
        tasks << task
      end

      visit tasks_path

      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
      within('form.form_created_at_sort_asc_desc') do
        select I18n.t('sort_by_created_at_asc').to_s, from: 'created_at'
        click_on I18n.t('sort_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
    end

    it 'Use DESC order' do
      tasks = []
      5.times do |id|
        task = create(:task, title: "task#{id}", content: '1', end_time: Time.now + 1.month)
        tasks << task
      end

      visit tasks_path

      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
      within('form.form_created_at_sort_asc_desc') do
        select I18n.t('sort_by_created_at_desc').to_s, from: 'created_at'
        click_on I18n.t('sort_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[4][:title]}/
        )
      end
    end
  end

  describe 'sorting tasks by created_at' do
    it 'Use ASC order, and it have the right order' do
      tasks = []
      5.times do |id|
        task = create(:task, title: "task#{id}", content: '1', end_time: Time.now + 1.month)
        tasks << task
      end

      visit tasks_path

      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
      within('form.form_end_time_sort_asc_desc') do
        select I18n.t('sort_by_end_time_asc').to_s, from: 'end_time'
        click_on I18n.t('sort_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
    end

    it 'Use DESC order' do
      tasks = []
      5.times do |id|
        task = create(:task, title: "task#{id}", content: '1', end_time: Time.now + 1.month)
        tasks << task
      end

      visit tasks_path

      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0][:title]}/
        )
      end
      within('form.form_end_time_sort_asc_desc') do
        select I18n.t('sort_by_end_time_desc').to_s, from: 'end_time'
        click_on I18n.t('sort_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[4][:title]}/
        )
      end
    end
  end

  describe 'searching task by title and state' do
    let!(:tasks) do
      tasks = []
      # Create a new task with some attributes
      searching_task = Task.create(
        id: 1,
        title: 'The Task be searching',
        content: 'searching',
        end_time: Time.now + 1.month,
        state: 'pending',
        priority: 2,
        created_at: Time.now,
        updated_at: Time.now
      )

      # Add the task to the array
      tasks << searching_task

      # Create four more tasks using a factory
      4.times do |_time|
        tasks << create(:task)
      end

      # Return the tasks array
      tasks
    end

    it "Use ransack to serch task's title" do
      visit tasks_path
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0].title}/
        )
      end
      within('div.search') do
        fill_in 'q_title_cont', with: tasks[0].title
        click_on I18n.t('search_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /#{tasks[0].title}/
        )
      end
    end

    it "Use ransack to serch task's state" do
      visit tasks_path
      within('div.tasks') do
        expect(page).to have_content(
          /state : #{tasks[0].state}/
        )
      end
      within('div.search') do
        fill_in 'q_state_eq', with: 'pending'
        click_on I18n.t('search_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /state : #{tasks[0].state}/
        )
      end
    end

    it "Use ransack to serch task's state" do
      visit tasks_path
      within('div.tasks') do
        expect(page).to have_content(
          /state : #{tasks[0].state}/
        )
      end
      within('div.search') do
        fill_in 'q_state_eq', with: 'pending'
        click_on I18n.t('search_submit').to_s
      end
      within('div.tasks') do
        expect(page).to have_content(
          /state : #{tasks[0].state}/
        )
      end
    end

    it "Sort task by task's priority ASC" do
      visit tasks_path

      within('form.form_priority_sort_asc_desc') do
        select I18n.t('sort_by_priority_asc').to_s, from: 'priority'
        click_on I18n.t('sort_submit').to_s
      end
      within('.tasks') do
        first_task = all('div').first
        expect(first_task[:class]).not_to eq('task1')
      end
    end

    it "Sort task by task's priority desc" do
      visit tasks_path

      within('form.form_priority_sort_asc_desc') do
        select I18n.t('sort_by_priority_desc').to_s, from: 'priority'
        click_on I18n.t('sort_submit').to_s
      end

      within('.tasks') do
        first_task = all('div').first
        expect(first_task[:class]).to eq('task1 max-w-sm rounded overflow-hidden shadow-lg')
      end
    end
  end

  private

  def create_tasks(title, content, end_time)
    visit tasks_path
    click_link I18n.t('create').to_s
    fill_in 'task_title', with: title
    fill_in 'task_content', with: content
    fill_in 'task_end_time', with: end_time
    click_button 'Create Task'
  end

  def edit_tasks(title, content, end_time)
    visit tasks_path
    # click_on 'Edit'
    click_link I18n.t('edit').to_s
    fill_in 'task_title', with: title
    fill_in 'task_content', with: content
    fill_in 'task_end_time', with: end_time
    click_on 'Update Task'
  end
end
