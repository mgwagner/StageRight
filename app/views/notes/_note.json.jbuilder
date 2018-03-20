json.extract! note, :id, :script_id, :user_id, :note_content, :created_at, :updated_at
json.url note_url(note, format: :json)
