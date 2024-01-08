import React from 'react';
import { Box, Breadcrumbs, Button, Typography } from '@mui/material';
import { Link, useParams } from 'react-router-dom';

function OrderConfirmation() {
	const { orderNumber } = useParams();

	return (
		<Box
			sx={{
				display: 'flex',
				flexGrow: 1,
				flexShrink: 1,
				flexBasis: '100%'
			}}
		>
			<Box sx={{ px: 3, py: 3, flexBasis: '100%' }}>
				<Breadcrumbs sx={{mb: 1}} separator="›" aria-label="breadcrumb">
					<Link underline="hover" color="inherit" to="/">
						Home
					</Link>
					<Typography color="text.primary">Order Confirmation</Typography>
				</Breadcrumbs>
				<Typography variant='h4' component="h1">Order Confirmation</Typography>
				<Typography variant='p' component="p" my={2}>Your order number is <strong>{orderNumber}</strong>.</Typography>
				<Typography variant='p' component="p" my={2}>You will be notified about changing the order status by email.</Typography>
				<Button
							component={Link}
							size="large"
							variant="outlined"
							color="primary"
							to="/"
							sx={{ mr: 1 }}
						>
							Return to Shopping
						</Button>
				
			</Box>
		</Box>
	);
}

export default OrderConfirmation;

