import { createSlice } from '@reduxjs/toolkit';

const orderSlice = createSlice({
  name: 'order',
  initialState: {
    orderNumber: null,
  },
  reducers: {
    setOrderNumber: (state, action) => {
			state.orderNumber = action.payload;
    },
    clearOrderNumber: (state) => {
      state.orderNumber = null;
    },
  },
});

export const { setOrderNumber, clearOrderNumber } = orderSlice.actions;
export default orderSlice.reducer;
