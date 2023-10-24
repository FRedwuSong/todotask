# frozen_string_literal: true

RSpec.describe Task, type: :model do
  # Assuming you have some tasks in your database
  let!(:tasks) do
    4.times { create(:task) }
    Task.create(
      id: 1,
      title: 'The Task be searching',
      content: 'searching',
      end_time: Time.now + 1.month,
      state: 'pending',
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  describe '.ransack' do
    # You can use different parameters to test different scenarios
    context 'when searching by title' do
      it 'returns the tasks that match the title' do
        q = Task.ransack(title_cont: 'The Task be searching')
        tasks = q.result(distinct: true)

        expect(tasks).to match_array(tasks)
      end
    end

    context 'when searching by state' do
      it 'returns the tasks that match the state' do
        q = Task.ransack(state_eq: 'pending')
        tasks = q.result(distinct: true)
        # binding.b
        expect(tasks).to match_array(tasks)
      end
    end
  end
end
