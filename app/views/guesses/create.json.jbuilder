json.inserted_item render(partial: "connections/form", formats: :html, locals: { connection: @connection, attempt: @attempt, solved_groups: @solved_groups, unsolved_groups: @unsolved_groups, remaining_words: @remaining_words })

json.inserted_results render(partial: "connections/results", formats: :html, locals: { attempt: @attempt })
if @failed
  json.inserted_unsolved render(partial: "connections/formed_groups", formats: :html, locals: { formed_groups: @unsolved_groups, failed: @failed })
end
json.result @solved_groups
json.group @solved_group
json.message @message
json.success @success
json.wrong @wrong
json.failed @failed
json.complete @attempt.completed
json.already_guessed @already_guessed
