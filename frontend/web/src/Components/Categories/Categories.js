import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import Button from '@mui/material/Button';
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { setSelectedCategory, setCategories } from './../../store/categorySlice';
import { getCategoryData } from './../../store/categoryData';

function Categories() {
  const dispatch = useDispatch();
  const categories = useSelector((state) => state.category.categories);
  const selectedCategory = useSelector((state) => state.category.selectedCategory);

  useEffect(() => {
    const fetchData = () => {
      try {
        const data = getCategoryData();

        dispatch(setCategories(data.categories));
        if (!selectedCategory) {
          dispatch(setSelectedCategory(data.categories[0]));
        }
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, [dispatch, selectedCategory]);


  const handleCategoryClick = (category) => {
    dispatch(setSelectedCategory(category));
  };

  return (
    <Box
		sx={{
			flexGrow: 1,
			flexShrink: 1,
			flexBasis: '100%'
		}}
	>
		<Container sx={{ py: 8 }} maxWidth="xl">
			<Grid container spacing={4}>
				{categories.map((category) => (
				(category.products) &&
					<Grid item key={category.id} xs={12} sm={6} md={4}>
						<Card variant="outlined">
							<Button component={Link} to={`/category/${category.id}`} onClick={() => handleCategoryClick(category)} variant="h5"
								sx={{ 
									px: '20px',
									py: '40px',
									width: '100%',
									height: '100%',
								}}
							>
								{category.categoryName}
							</Button>
						</Card>
					</Grid>
				))}
			</Grid>
		</Container>
    </Box>
  );
}

export default Categories;
