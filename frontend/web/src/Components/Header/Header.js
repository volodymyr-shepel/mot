import * as React from 'react';
import { AppBar, Box, Button, Toolbar, Typography } from '@mui/material';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import { useSelector } from 'react-redux';
import { Link } from 'react-router-dom';

function Header() {
	const cartItems = useSelector((state) => state.cart?.items || []);

	const totalQuantity = cartItems.reduce((total, item) => total + item.quantityToOrder, 0);

  return (
    <Box sx={{ flexGrow: 0 }}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant='h5' component="div" 
						sx={{ 
						flexGrow: 1,
						textAlign: 'left'
						}}
					>
            <Button component={Link} variant="inherit" sx={{textTransform: 'none', fontSize: 'inherit'}} to='/'>Market of Things</Button>
          </Typography>
          <Button color="inherit">Login</Button>
		  		<Button component={Link} to="/cart"
            size="large"
            edge="start"
            color="inherit"
            aria-label="Cart"
            sx={{ ml: 2 }}
          >
            <ShoppingCartIcon sx={{ mr: 1 }} />Cart ({totalQuantity})
          </Button>
        </Toolbar>
      </AppBar>
    </Box>
  );
}

export default Header;
