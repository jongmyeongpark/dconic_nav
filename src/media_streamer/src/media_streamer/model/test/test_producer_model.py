
import pytest

from ..producer_model import ProducerModel

class TestProducerModel:

    def test_register_producer(self):

        producer_model = ProducerModel()

        producer_model.register_producer("producer_name")

        assert producer_model._producers["producer_name"] == {}

    def test_on_registered(self):

        producer_model = ProducerModel()

        producer_model.register_producer("producer_name")
