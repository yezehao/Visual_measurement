## neural network
Net(
  (conv1): Conv2d(1, 10, kernel_size=(5, 5), stride=(1, 1))
  (conv2): Conv2d(10, 20, kernel_size=(5, 5), stride=(1, 1))
  (conv2_drop): Dropout2d(p=0.5, inplace=False)
  (fc1): Linear(in_features=320, out_features=50, bias=True)
  (fc2): Linear(in_features=50, out_features=10, bias=True)
)

## train
Test set: Avg. loss: 0.2104, Accuracy: 9396/10000 (94%)

## test
Test set: Avg. loss: 0.0533, Accuracy: 9831/10000 (98%)