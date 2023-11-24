for index, _ in pairs(game.surfaces) do
  for _, entity in pairs(game.surfaces[index].find_entities_filtered{name = "signal-filter-combinator-output"}) do
    entity.destroy()
  end

  for _, entity in pairs(game.surfaces[index].find_entities_filtered{name = "signal-filter-combinator"}) do
    local output_entity = entity.surface.create_entity{
      name = "signal-filter-combinator-output",
      position = getOutputPosition(entity),
      direction = entity.direction,
      force = entity.force,
      fast_replace = false,
      raise_built = false,
      create_built_effect_smoke = false
    }

    output_entity.destructible = false
    output_entity.operable = false
    output_entity.rotatable = false
    output_entity.minable = false

    global.entities[entity.unit_number] = {}
    global.entities[entity.unit_number].main_entity = entity
    global.entities[entity.unit_number].output_entity = output_entity

    entity.connect_neighbour({
      wire = defines.wire_type.red,
      target_entity = output_entity,
      source_circuit_id = defines.circuit_connector_id.combinator_output,
      target_circuit_id = defines.circuit_connector_id.constant_combinator
    })
    entity.connect_neighbour({
      wire = defines.wire_type.green,
      target_entity = output_entity,
      source_circuit_id = defines.circuit_connector_id.combinator_output,
      target_circuit_id = defines.circuit_connector_id.constant_combinator
    })
  end
end

