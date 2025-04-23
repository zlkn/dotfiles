import pytest
from dapt import DApt

@pytest.fixture
def dapt():
    """A fresh DApt instance for each test."""
    return DApt()

def test_init_method_exists_and_returns_none(dapt):
    # The init() method should be callable and, by default, return None
    assert callable(dapt.init)
    assert dapt.init() is None

@pytest.mark.parametrize("config", [
    ({'foo': 'bar'}),          # simple dict
    ({'count': 0, 'verbose': True}),
    ({}),                      # empty config
])
def test_plan_accepts_various_configs_and_returns_none(dapt, config):
    # plan() should accept a dict and, by default, return None
    result = dapt.plan(config)
    assert result is None

def test_apply_returns_none_by_default(dapt):
    # apply() should be callable and, by default, return None
    assert callable(dapt.apply)
    assert dapt.apply() is None

def test_full_workflow_sequence(dapt):
    """
    A sanity-check of the typical call sequence:
      1. init()
      2. plan(config)
      3. apply()
    Each step should complete without raising.
    """
    # Step 1
    assert dapt.init() is None

    # Step 2
    sample_config = {'dry_run': False}
    assert dapt.plan(sample_config) is None

    # Step 3
    assert dapt.apply() is None

