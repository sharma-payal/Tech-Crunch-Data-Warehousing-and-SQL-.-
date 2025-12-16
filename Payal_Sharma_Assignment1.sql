-- ================================================================
-- RECIPE DATABASE CASE STUDY - COMPLETE ASSIGNMENT
-- Student: PAYAL SHARMA
-- Assignment: Part 2 - SQL Script (All 3 Parts)
-- ================================================================
-- This file contains all three parts of the assignment:
-- PART 1: Insert two new recipes into the database
-- PART 2: Write ONE query to retrieve all info about the two new recipes
-- PART 3: Write a SELECT query with specific columns and sorting
-- ================================================================

USE `recipes`;

-- ################################################################
-- PART 1: INSERT TWO NEW RECIPES INTO THE DATABASE
-- ################################################################
-- Insert information about two completely new recipes
-- into all four tables: categories, ingredients, recipe_main, and rec_ingredients
-- New recipes: 1) Cinnamon Rolls  2) Banana Shake

-- ----------------------------------------------------------------
-- PART 1A: Insert new category for beverages
-- ----------------------------------------------------------------
-- Since we have a Banana Shake (beverage), we need to add a new category
-- Current categories are: Entree (id=1), Desserts (id=2)
-- We'll add Beverages (let AUTO_INCREMENT assign the category_id)

INSERT INTO `categories` (category_name) 
VALUES ('Beverages');

-- ----------------------------------------------------------------
-- PART 1B: Insert new ingredients needed for our recipes
-- ----------------------------------------------------------------
-- These ingredients don't exist in the current database
-- Current max ingredient_id is 19, so we'll start from 20

INSERT INTO `ingredients` (ingredient_id, ingred_name) VALUES
(20, 'Warm milk'),
(21, 'Active dry yeast'),
(22, 'Brown sugar'),
(23, 'Ground cinnamon'),
(24, 'Cream cheese'),
(25, 'Powdered sugar'),
(26, 'Ripe bananas'),
(27, 'Cold milk'),
(28, 'Ice cubes'),
(29, 'Honey');

-- ----------------------------------------------------------------
-- PART 1C: Insert the two new recipes into recipe_main
-- ----------------------------------------------------------------
-- Recipe IDs will auto-increment from 3 onwards
-- Current recipes: Chicken Marsala (id=1), Absolute Brownies (id=2)

-- Recipe 1: Cinnamon Rolls (recipe_id will be 3)
INSERT INTO `recipe_main` 
(recipe_id, rec_title, category_id, recipe_desc, prep_time, cook_time, servings, difficulty, directions)
VALUES 
(3, 'Cinnamon Rolls', 2, 'Soft and fluffy homemade cinnamon rolls with cream cheese frosting', 
 30, 25, 12, 3, 
 'Warm the milk to 110 degrees F. Dissolve yeast in warm milk and let sit for 5 minutes. Mix in sugar, butter, eggs, salt and flour. Knead dough for 5 minutes until smooth. Place in greased bowl, cover and let rise for 1 hour. Roll out dough into rectangle. Spread with softened butter and sprinkle with brown sugar and cinnamon mixture. Roll up tightly and cut into 12 slices. Place in greased pan and let rise 30 minutes. Bake at 350 degrees F for 25 minutes until golden. For frosting: beat cream cheese with butter, powdered sugar and vanilla until smooth. Spread on warm rolls.');

-- Recipe 2: Banana Shake (recipe_id will be 4)
-- Note: category_id = 3 is the Beverages category we just inserted
INSERT INTO `recipe_main` 
(recipe_id, rec_title, category_id, recipe_desc, prep_time, cook_time, servings, difficulty, directions)
VALUES 
(4, 'Banana Shake', 3, 'Creamy and delicious banana milkshake', 
 5, 0, 2, 1, 
 'Peel the ripe bananas and cut into chunks. Add bananas, cold milk, honey and vanilla extract to a blender. Add ice cubes. Blend on high speed for 1-2 minutes until smooth and creamy. Pour into glasses and serve immediately. Optional: garnish with banana slices or a sprinkle of cinnamon on top.');

-- ----------------------------------------------------------------
-- PART 1D: Insert recipe ingredients into rec_ingredients
-- ----------------------------------------------------------------
-- This table links recipes to their ingredients with amounts
-- Format: (rec_ingredient_id, recipe_id, amount, ingredient_id)

-- Ingredients for Cinnamon Rolls (recipe_id = 3)
-- rec_ingredient_id will auto-increment from 17 onwards
INSERT INTO `rec_ingredients` (recipe_id, amount, ingredient_id) VALUES
(3, 1.00, 20),   -- 1 cup Warm milk
(3, 2.25, 21),   -- 2.25 tsp Active dry yeast
(3, 0.50, 11),   -- 0.5 cup White sugar
(3, 0.33, 5),    -- 0.33 cup Butter
(3, 2.00, 12),   -- 2 Eggs
(3, 1.00, 15),   -- 1 tsp Salt
(3, 4.00, 2),    -- 4 cups Flour
(3, 0.75, 22),   -- 0.75 cup Brown sugar
(3, 2.00, 23),   -- 2 tbsp Ground cinnamon
(3, 8.00, 24),   -- 8 oz Cream cheese
(3, 1.50, 25);   -- 1.5 cups Powdered sugar

-- Ingredients for Banana Shake (recipe_id = 4)
INSERT INTO `rec_ingredients` (recipe_id, amount, ingredient_id) VALUES
(4, 2.00, 26),   -- 2 Ripe bananas
(4, 2.00, 27),   -- 2 cups Cold milk
(4, 2.00, 29),   -- 2 tbsp Honey
(4, 1.00, 13),   -- 1 tsp Vanilla extract
(4, 6.00, 28);   -- 6 Ice cubes

-- ================================================================
-- END OF PART 1
-- ================================================================


-- ################################################################
-- PART 2: QUERY TO RETRIEVE ALL INFORMATION ABOUT THE TWO NEW RECIPES
-- ################################################################
-- INSTRUCTIONS GIVEN: Write ONE SQL query that returns all information 
-- on ONLY the two new recipes (Cinnamon Rolls and Banana Shake)
-- The query should show information from all four tables.
-- It's okay if rows are duplicated due to multiple ingredients.

-- This query uses INNER JOINs to connect all four tables
-- and filters to show only recipes with recipe_id >= 3 (our new recipes)

SELECT 
    -- Columns from recipe_main(rm) table 
    rm.recipe_id,
    rm.rec_title,
    rm.recipe_desc,
    rm.prep_time,
    rm.cook_time,
    rm.servings,
    rm.difficulty,
    rm.directions,
    
    -- Columns from categories(c) table
    c.category_id,
    c.category_name,
    
    -- Columns from rec_ingredients(ri) table
    ri.rec_ingredient_id,
    ri.amount,
    
    -- Columns from ingredients(i) table
    i.ingredient_id,
    i.ingred_name

FROM recipe_main rm

-- JOIN to categories table to get category information
INNER JOIN categories c 
    ON rm.category_id = c.category_id

-- JOIN to rec_ingredients table to get ingredient amounts for each recipe
INNER JOIN rec_ingredients ri 
    ON rm.recipe_id = ri.recipe_id

-- JOIN to ingredients table to get ingredient names
INNER JOIN ingredients i 
    ON ri.ingredient_id = i.ingredient_id

-- Filter to show ONLY the two new recipes (recipe_id 3 and 4)
WHERE rm.recipe_id IN (3, 4)

-- Optional: Order by recipe name and then ingredient name for readability
ORDER BY rm.rec_title, i.ingred_name;

-- ================================================================
-- END OF PART 2
-- Note(instrcutions provided): This query will show duplicate rows for recipe information
-- because each recipe has multiple ingredients. This is expected!
-- ================================================================


-- ################################################################
-- PART 3: SELECT QUERY WITH SPECIFIC COLUMNS AND SORTING
-- ################################################################
-- Instructions: Write a SELECT query that shows:
-- - Recipe name
-- - Category name  
-- - Ingredient name
-- - Ingredient amount
-- Sort by: Category (DESC), Recipe name (ASC), Ingredient name (DESC)

-- This query works for ALL recipes in the database (not just the new ones)
-- It uses INNER JOINs to combine the four tables and selects only the required columns

SELECT 
    rm.rec_title AS 'Recipe Name',           -- Recipe name from recipe_main
    c.category_name AS 'Category Name',      -- Category name from categories
    i.ingred_name AS 'Ingredient Name',      -- Ingredient name from ingredients
    ri.amount AS 'Ingredient Amount'         -- Amount from rec_ingredients

FROM recipe_main rm

-- JOIN to categories table to get category names
INNER JOIN categories c 
    ON rm.category_id = c.category_id

-- JOIN to rec_ingredients to connect recipes with their ingredients
INNER JOIN rec_ingredients ri 
    ON rm.recipe_id = ri.recipe_id

-- JOIN to ingredients table to get ingredient names
INNER JOIN ingredients i 
    ON ri.ingredient_id = i.ingredient_id

-- Sort the results according to assignment requirements:
ORDER BY 
    c.category_name DESC,      -- 1st: Category name in descending order (Z to A)
    rm.rec_title ASC,          -- 2nd: Recipe name in ascending order (A to Z)
    i.ingred_name DESC;        -- 3rd: Ingredient name in descending order (Z to A)

-- ================================================================
-- END OF PART 3
-- ================================================================

-- ================================================================
-- END OF COMPLETE ASSIGNMENT
-- ================================================================
