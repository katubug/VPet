# [WORKING TITLE] — Game Design Document
**Version:** 0.3 | **Status:** Draft

---

## Table of Contents
1. [Overview](#1-overview)
2. [Pet System](#2-pet-system)
3. [Needs & Stats](#3-needs--stats)
4. [World & Exploration](#4-world--exploration)
5. [Minigames](#5-minigames)
6. [Economy & Items](#6-economy--items)
7. [Social & Progression](#7-social--progression)
8. [Events & Special Content](#8-events--special-content)
9. [Debug & Dev Tools](#9-debug--dev-tools)
10. [Open Questions & Next Steps](#10-open-questions--next-steps)

---

## 1. Overview

[WORKING TITLE] is a virtual pet game for PC and Android, inspired by Tamagotchi. Players raise a pet through multiple life stages (egg → baby → child → teen → adult), keeping it fed, happy, and engaged through minigames, exploration, and world activities. The pet's adult form is determined by four hidden personality stats accumulated over its lifetime.

### 1.1 Core Pillars

| Pillar | Description |
|---|---|
| **Nurture** | Keep your pet healthy and happy through routine care |
| **Discover** | Explore areas, find rare encounters, unlock recipes and items |
| **Evolve** | Guide your pet's personality through activities and choices |
| **Collect** | Raise multiple pet types, genders, and shiny variants |

### 1.2 Platform & Input

- **Platforms:** PC and Android
- **Input:** Tap/mouse and keyboard (using the Input plugin for all input handling)
- **Push notifications:** Timed triggers only; notifications can pass data flags back to the game on click (e.g., setting an "I'm cold" state flag for next session load)

---

## 2. Pet System

### 2.1 Life Stages

Each pet progresses through the following stages over real time:

| Stage | Notes |
|---|---|
| **Egg** | No stats, no interaction yet — *see Open Questions* |
| **Baby** | No hidden stats; establish basic care routines |
| **Child** | Hidden stats begin accumulating; dominant stat → one of 4 child forms |
| **Teen** | Top two stats → one of 8 teen forms; aloof, may randomly refuse minigames; fewer unprompted calls for attention but still needs regular care |
| **Adult** | Top two stats + lowest stat → one of 16 adult forms |

### 2.2 Hidden Stats (Personality)

Four hidden stats determine the evolution path. They accumulate throughout childhood and teen stages:

- **Joy**
- **Self-Esteem**
- **Enthusiasm**
- **Nonsense**

Stats are earned through:
- **Minigames** — earn random stat items as drops; player chooses when to use them
- **Food** — each food type grants a direct stat boost; player chooses what to feed
- **Fey blessings** — random direct stat boost during forest exploration; player can refuse but cannot choose the stat
- **Fey curses** — random direct stat penalty; cannot be refused
- **Rare world events** — very rarely, a player is offered the ability to directly choose their adult form

| Source | Stat grant | Player control |
|---|---|---|
| **Minigames** | Random stat item; applied when player chooses | Indirect — choose when to cash in |
| **Food** | Direct stat boost; tied to food type | Direct — choose what to feed |
| **Fey blessing** | Random direct boost | Can refuse, can't choose type |
| **Fey curse** | Random direct penalty | Can't refuse, can't choose type |
| **Rare world event** | Choose adult form outright | Full control |

### 2.3 Gender

- Pets have two genders
- Gender is determined randomly upon hatching from the egg
- Players can swap gender using a purchasable Gender Change Potion

### 2.4 Shiny Variants

- Each pet type has a default and a rare "shiny" color scheme
- Shiny occurrence is random and rare
- Achievements for collecting all shinies (hidden achievement category)

### 2.5 Evolution Freeze

A high-tier item allows players to freeze their pet's evolution at its current stage indefinitely, so an adult can permanently wear a child's appearance.

### 2.6 Death

Death occurs when hidden Health reaches zero (see [Section 3.1](#31-health-hidden)). When death triggers:

1. Player is taken to a Rock Paper Scissors minigame against the Grim Reaper
2. **Win:** pet is revived and thanks the player
3. **Lose:** ~15–20% chance Death takes pity and leaves anyway; otherwise, pet says goodbye and passes on

---

## 3. Needs & Stats

The pet has several visible and hidden gauges that must be maintained. Letting needs decay triggers cascading consequences.

### 3.1 Health (Hidden)

- Not directly visible to the player
- Begins draining when Hunger hits zero
- Recovers at 1 HP per unit time when both Hunger AND Happiness are above 50%
- Reaches zero → death sequence (see [Section 2.6](#26-death))

### 3.2 Hunger

- Drains 1 point every **30 minutes**
- Below 25% full: Happiness begins to drain
- Empty: Health begins draining instead
- Refilled by: default free food, cooked meals, special consumables

### 3.3 Happiness

- Drains when Hunger is below 25%
- Drains when Thirst is below 50%
- Drains over time when room is cluttered
- At zero: a hidden **Neglect timer** begins
- Neglect timer fills → pet runs away
- Neglect heals by: playing minigames, petting, hugging; also recovers 1 per unit time when Happiness is at max

### 3.4 Thirst

- Drains every **~45–60 minutes** (slower than hunger — a background concern, not a primary stressor)
- **Below 50%:** contributes to Happiness drain
- **Empty:** minigames earn fewer coins (penalty TBD — e.g., -20%)
- Thirst is not a chore; it's a **positive engagement system** — players are rewarded for keeping it up rather than punished harshly for neglect

#### Drinks

Drinks are visually distinct and cute. They come from two sources:

| Source | Type | Effect |
|---|---|---|
| **Shop** | Basic refills | Restores thirst only; 2–3 cute varieties, no special effects |
| **Crafting** | Special drinks | Restores thirst + grants a bonus effect |

**Crafted drink effects (examples):**

- 🧊 Cold drinks → lower temperature / slow temperature rise
- ☕ Warm drinks → raise temperature / slow temperature drop
- ⭐ Fancy drinks → temporary coin multiplier on minigame wins
- 🍵 Calming drinks → slow Happiness drain for a set period
- 💊 Medicinal drinks → reduce sickness chance or speed recovery
- 🌀 Mystery drinks → random effect (fits the Nonsense stat vibe)

> 📝 **NOTE:** Full thirst does NOT grant a blanket bonus. Bonuses come from specific drink effects only. This keeps the system readable and avoids confusion.

### 3.5 Temperature

- Room temperature fluctuates between hot and cold
- **Player response:** give pet a sweater/blanket when cold; set up a fan when hot
- Drinks can help regulate temperature (see 3.4)
- Maintaining comfort slows Happiness drain
- **Notification example:** "I'm cold!" triggers after ~2 hrs of game being closed; sets a cold flag on next session load

### 3.6 Enrichment (Daily Needs)

To feel enriched, a pet needs each of the following **once per day:**

- [ ] Fed
- [ ] Given water/drink
- [ ] Bathed
- [ ] Hugged
- [ ] Taken outside

> ⚠️ **OPEN QUESTION:** Is the enrichment checklist visible to the player, or internal only? A visible daily checklist could help new players learn routines.

### 3.7 Sickness

- Chance of illness based on neglected stats and environmental conditions
- Each illness requires a specific medicine
- **Example illnesses:** flu, cold, anxiety attack (list to be expanded)

---

## 4. World & Exploration

### 4.1 Home Room

- Primary space where the pet wanders and idles
- Gets cluttered over time (dishes, clothes, tissues, etc.)
- Player taps/clicks clutter to clean it up
- Excessive clutter: lowers Happiness over time, increases sickness chance
- Furniture can slow needs decay (e.g., a comfy bed slows Happiness drain at night)

### 4.2 Areas to Visit

| Area | Description |
|---|---|
| **Park** | Daytime pet encounters |
| **Forest** | Nature exploration; stat blessings/curses from fey |
| **Shops** | Purchase food, items, high-ticket goods |
| **Arcade** | Dedicated minigame space |
| **School** | Pet can go to school to progress knowledge |

Travel between areas includes a walking animation.

### 4.3 Garden

- Passive coin generation over time
- Grows ingredients used in cooking and crafting
- No stat inheritance mechanic — fruit/seed stat system has been cut

### 4.4 Exploration Interactions

- Clicking/tapping objects while exploring earns coins
- Forest: chance to be blessed (choose to accept or refuse) or cursed (no choice) by a fey; both grant/penalise a random stat directly

### 4.5 Pet Encounters (Wild Pets)

- Wild "pet pets" spawn in Forest or Park depending on time of day
- Unusual-hour encounters (e.g., during sleep hours) can be accessed via earned vouchers

### 4.6 Night Events

- Special encounters triggered by taking the pet for a walk at night
- **Bread Fairy:** if pet is put to bed between 8pm–9pm, chance of a nighttime visit leaving coins

---

## 5. Minigames

### 5.1 Overview

Eight minigames are planned. All minigames earn coins and have a chance to drop random stat items, which the player can use at any time. Thirst level affects coin yield:

- **Empty thirst:** reduced coins (penalty TBD — e.g., -20%)
- **Specific drink effects:** can grant a temporary coin multiplier (not tied to thirst level itself)

Stat items drop randomly from any minigame — there is no fixed stat-to-minigame mapping. This ensures players who prefer certain minigames are never locked out of specific evolutions.

### 5.2 Minigame List

| Minigame | Type |
|---|---|
| **Button Masher** | Rapid-tap race |
| **Endless Runner** | Dodge obstacles |
| **Memory** | Match pairs |
| **Lullaby** | Rhythm / timing — soothe pet to sleep |
| **Sorting** | Drag items into correct categories before time runs out |
| **Survivor** | Auto-attack, dodge enemies, collect XP, pick power-ups |
| **Flappy Bird** | Tap to fly through gaps |
| **Match-3** | Swap tiles to match three or more |

### 5.3 Rock Paper Scissors (Special)

- Used in the death sequence (vs. Grim Reaper) — not a stat-granting minigame
- Unlockable "Gun" item: auto-wins RPS — high-tier unlock

### 5.4 Fishing Minigame

Details TBD — flagged as a planned addition beyond the core eight.

---

## 6. Economy & Items

### 6.1 Coins

- **Earned by:** winning minigames, tapping objects while exploring, Bread Fairy visits, garden (passive)
- Coin yield modified by Thirst level and active drink effects

### 6.2 Daily Gacha

One free gacha pull per day. Rewards TBD (cosmetics, consumables, rare items).

### 6.3 Shop

| Item | Notes |
|---|---|
| Gender Change Potion | Swaps pet gender |
| Evolution Freeze item | Locks current life stage permanently |
| Full Hunger restore | Consumable |
| Full Happiness restore | Consumable |
| RPS "Gun" | Auto-wins Rock Paper Scissors; high-tier |
| Furniture | Some items slow needs decay |
| Clothing / cosmetics | Dress-up system |
| Basic drinks | 2–3 varieties, no special effects |

### 6.4 Cooking & Crafting

- Players unlock recipes through gameplay: exploration, minigames, and other activities
- **Default free food:** fills hunger, grants no stats, pet accepts at any age
- **Cooked foods:** fill hunger + grant bonus effects (direct stat boosts by food type, illness immunity, need decay slowdown, etc.)
- **Crafted drinks:** fill thirst + grant special effects (see [Section 3.4](#34-thirst))
- **Ingredients:** sourced from the garden and exploration

---

## 7. Social & Progression

### 7.1 Marriage & Breeding

Breeding is an **endgame activity** — adults only, initiated by the player when they're ready.

**Rules:**
- Each pet can breed **exactly once**
- Partner options: a random NPC adult encountered in the world, or another player's adult pet online
- NPC partners are **randomized** (not curated)
- Breeding produces **a new egg** that restarts the life cycle
- Egg stats: **average of both parents' hidden stats**
- Shiny bonus: **only if both parents are shiny** (makes double-shiny pairings a rare coveted event)

**After breeding:**
- Player chooses when to breed and whether to retire the pet
- Once the egg hatches, the parent **departs**
- Departed parents can **visit their child** in future play sessions
- This is distinct from ghost visits — parents visit their direct child only; ghosts visit the player regardless of current pet

### 7.2 Evolution Tree

All pet names are pending finalization — stats shown are the determining hidden stats.

**Children (dominant stat):**

| Name | Primary Stat |
|---|---|
| Phil | Enthusiasm |
| Gnart | Self-Esteem |
| Looma | Joy |
| Plang | Nonsense |

**Teenagers (top two stats):**

| Name | Primary | Secondary |
|---|---|---|
| Teru | Enthusiasm | Self-Esteem |
| Pleh | Enthusiasm | Joy |
| Blertrand | Enthusiasm | Nonsense |
| Vleesh | Self-Esteem | Joy |
| Goot | Self-Esteem | Nonsense |
| Merm | Nonsense | Self-Esteem |
| Moof | Joy | Enthusiasm |
| Yorge | Joy | Nonsense |

**Adults (top two + lowest stat):**

| Name | High 1 | High 2 | Low |
|---|---|---|---|
| Blinko | Enthusiasm | Self-Esteem | -Joy |
| Tibb | Enthusiasm | Self-Esteem | -Nonsense |
| Clup | Enthusiasm | Joy | -Self-Esteem |
| Teedee | Enthusiasm | Joy | -Nonsense |
| Teemb | Enthusiasm | Nonsense | -Joy |
| Gluft | Enthusiasm | Nonsense | -Self-Esteem |
| Chomly | Self-Esteem | Joy | -Enthusiasm |
| Balbio | Self-Esteem | Joy | -Nonsense |
| Homma | Self-Esteem | Nonsense | -Enthusiasm |
| Grimble | Self-Esteem | Nonsense | -Joy |
| Chimchee | Joy | Enthusiasm | -Self-Esteem |
| Elboo | Joy | Enthusiasm | -Nonsense |
| Nabafee | Joy | Nonsense | -Self-Esteem |
| Bedapy Crinoga | Joy | Nonsense | -Enthusiasm |
| Froodle | Self-Esteem | Nonsense | -Enthusiasm |
| Slof | Enthusiasm | Nonsense | -Joy |

> ⚠️ **NOTE:** Evolution tree stats to be verified directly against project code before finalizing.

### 7.3 Player Identity

- Player enters their name at the start
- **Starting title:** "Mom," "Dad," or a gender-neutral equivalent (TBD)
- Titles unlock through gameplay — examples: Maestro, Boss, Captain, Butthead
- Title display style: similar to ACNH / Monster Hunter

### 7.4 Achievements

- Raise every pet type (both genders where applicable)
- Raise one shiny pet
- **Hidden achievement:** collect ALL shinies

### 7.5 Dress-Up

Cosmetic clothing and accessories for the pet (inspired by Tamagotchi). Details TBD.

### 7.6 Property Owning

Flagged as a potential feature, inspired by Tamagotchi. Scope TBD.

### 7.7 School & Jobs

Flagged as a potential feature. Could tie into stat growth or coin earning during teen/adult stages.

---

## 8. Events & Special Content

### 8.1 Pet Birthdays

- Pets celebrate a "birthday" on a regular cycle — approximately monthly
- **Proposed solution:** pets have their own internal calendar (e.g., every 30 in-game days = birthday); real-world holidays are handled as a separate event layer, avoiding conflicts

### 8.2 Ghost Visits

Ghosts of deceased past pets can visit during later playthroughs. Ghosts visit **the player**, regardless of which pet is currently being raised. This is distinct from parent visits (see [Section 7.1](#71-marriage--breeding)).

### 8.3 Holiday Events

Real-world holiday tie-ins. Calendar and scope TBD.

---

## 9. Debug & Dev Tools

### 9.1 Cheat Page

- Hidden/dev-only screen (or unlockable for players)
- Displays ALL hidden stats in real time
- Buttons to manually raise or lower any need or stat

---

## 10. Open Questions & Next Steps

### Resolved ✅

| Topic | Decision |
|---|---|
| **Thirst punishment** | Empty thirst = fewer coins only (mild, non-cascading) |
| **Thirst drain rate** | ~45–60 min; slower than hunger's 30 min |
| **Drink variety** | Yes — different drinks do different things |
| **Drink sources** | Shop (basic refills) + crafting (special effects) |
| **Breeding partners** | Random NPC adult or another player's adult online |
| **Breeding output** | New egg; stats averaged from both parents |
| **Breeding timing** | Adults only (endgame) |
| **Breeding frequency** | Once per pet per lifetime |
| **Post-breeding** | Player chooses when; parent departs on hatch, can visit child later |
| **Shiny inheritance** | Boosted odds only if both parents are shiny |
| **Parent vs. ghost visits** | Parents visit their child only; ghosts visit the player regardless of current pet |
| **Stat → minigame mapping** | Decoupled — all minigames drop random stat items |
| **Minigame roster** | 8 games: Button Masher, Endless Runner, Memory, Lullaby, Sorting, Survivor, Flappy Bird, Match-3 |
| **Fruit/seed stat system** | Cut — stat gain covered by food, minigame items, and fey blessings |
| **Garden purpose** | Passive coin generation + cooking/crafting ingredients |
| **Evolution tree** | Defined — pending code verification |

### Unresolved ⚠️

| Topic | Notes |
|---|---|
| **Teen refusal system** | How often? What does the player do about it? |
| **Egg stage** | What does the player actually do during this phase? |
| **Daily enrichment checklist** | Visible to player or internal only? |
| **School & jobs** | Active minigames, idle system, or flavor only? |
| **Property owning** | Scope and purpose TBD |
| **Fishing minigame** | Full design TBD |
| **More world areas?** | Beach, school, event zones? |

### Suggested Next Steps (Priority Order)

1. **Prototype the core needs loop** — hunger / thirst / happiness / health; validate drain rates
2. **Design the teen refusal system** — affects daily engagement loop
3. **Define the egg stage** — first thing new players experience
4. **Define the full item shop catalogue and coin economy**
5. **Verify evolution tree against project code**
