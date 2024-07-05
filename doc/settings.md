# Main Settings

### General

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Close when in combat            | `bool` | `false` |
| Close when container is empty   | `bool` | `true`  |
| Break invisibility when used    | `bool` | `true`  |
| Open when container is unlocked | `bool` | `true`  |

# Display

### Position

| Name                            | Type                  | Default    |
|---------------------------------|-----------------------|------------|
| Anchor                          | `enum`                | `Top Left` |
| X offset                        | `int` [`-960`; `960`] | `100`      |
| Y offset                        | `int` [`-540`; `540`] | `-180`     |

> [!Note]  
> Valid values for `Anchor` are  `Top Left`, `Center Left`, `Bottom Left`, `Top Center`, `Center`, `Bottom Center`, `Top Right`, `Center Right` and `Bottom Right`.

### Size

| Name                            | Type                   | Default |
|---------------------------------|------------------------|---------|
| Scale                           | `float` [`0.1`; `3.0`] | `1.0`   |
| Min lines                       | `int`   [`0`; `25`]    | `0`     |
| Max lines                       | `int`   [`1`; `25`]    | `7`     |

> [!Note]  
> When setting Max Lines to a value smaller than Min Lines, Min Lines should be updated to take on the same value.  
> When setting Min Lines to a value larger than Max Lines, Max Lines should be updated to take on the same value.

### Icons

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Show stealing icon              | `bool` | `true`  |
| Show read icon                  | `bool` | `true`  |
| Show enchanted icon             | `bool` | `true`  |
| Show known enchanted icon       | `bool` | `true`  |
| Show special enchanted icon     | `bool` | `true`  |

### Transparency

| Name                            | Type                   | Default |
|---------------------------------|------------------------|---------|
| Regular                         | `float` [`0.1`; `1.0`] | `1.0`   |
| When empty                      | `float` [`0.1`; `1.0`] | `0.3`   |

### Reset

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Restore defaults                | Button | -       |

# Sorting

### By Item Category

- Gold
- Gems
- Soul Gems
- Lockpicks
- Ingots
- Ores
- Potions
- Food & Drinks
- Books
- Notes
- Scrolls
- Arrows & Bolts
- Jewelry
- Weapons
- Armors
- Clothes

### By Attribute

- Weightless
- By Weight
- By Value
- By Name
- LOTD Needed
- Completionist Needed

# Compatibility

### The Curator's Companion

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Show 'new' icon                 | `bool` | `true`  |
| Show 'found' icon               | `bool` | `true`  |
| Show 'displayed' icon           | `bool` | `true`  |

### Completionist

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Show 'needed' icon              | `bool` | `true`  |
| Show 'collected' icon           | `bool` | `true`  |

### Miscellaneous

| Name                            | Type   | Default |
|---------------------------------|--------|---------|
| Hide menu for animals           | `bool` | `false` |