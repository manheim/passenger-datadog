# encoding: UTF-8
require 'spec_helper'

describe PassengerDatadog do
  let(:Statsd) { double(Statsd) }
  let(:statsd) { instance_double(Statsd) }

  context 'passenger not running' do
    before { allow(described_class).to receive(:`).and_return('') }

    it 'does not send stats to datadog' do
      expect(Statsd).not_to receive(:new)

      described_class.run
    end
  end

  context 'passenger 4' do
    before { allow(described_class).to receive(:`).and_return(File.read('spec/fixtures/passenger_4_status.xml')) }

    it 'sends stats to datadog' do
      allow(Statsd).to receive(:new).and_return(statsd)
      allow(statsd).to receive(:batch).and_yield(statsd)

      expect(statsd).to receive(:gauge).with('passenger.pool.used', '5')
      expect(statsd).to receive(:gauge).with('passenger.pool.max', '20')
      expect(statsd).to receive(:gauge).with('passenger.request_queue', '0')
      expect(statsd).to receive(:gauge).with('passenger.capacity_used', '')
      expect(statsd).to receive(:gauge).with('passenger.processes_being_spawned', '')
      expect(statsd).to receive(:gauge).with('passenger.enabled_process_count', '5')
      expect(statsd).to receive(:gauge).with('passenger.disabling_process_count', '0')
      expect(statsd).to receive(:gauge).with('passenger.disabled_process_count', '0')
      expect(statsd).to receive(:gauge).with('passenger.processed', '149', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '554312', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '548660', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '549560', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '548660', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '952668', :tags => ['passenger-process:0'])

      expect(statsd).to receive(:gauge).with('passenger.processed', '273', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '547088', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '541420', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '542326', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '541420', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '963948', :tags => ['passenger-process:1'])

      expect(statsd).to receive(:gauge).with('passenger.processed', '139', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '533704', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '258196', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '394044', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '258196', :tags => ['passenger-process:2'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '887132', :tags => ['passenger-process:2'])

      expect(statsd).to receive(:gauge).with('passenger.processed', '135', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '1', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '559972', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '284396', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '420259', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '284396', :tags => ['passenger-process:3'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '915564', :tags => ['passenger-process:3'])

      expect(statsd).to receive(:gauge).with('passenger.processed', '236', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '548696', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '543068', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '543957', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '543068', :tags => ['passenger-process:4'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '964668', :tags => ['passenger-process:4'])
      described_class.run
    end
  end

  context 'passenger 5' do
    before { allow(described_class).to receive(:`).and_return(File.read('spec/fixtures/passenger_5_status.xml')) }

    it 'sends stats to datadog' do
      allow(Statsd).to receive(:new).and_return(statsd)
      allow(statsd).to receive(:batch).and_yield(statsd)

      expect(statsd).to receive(:gauge).with('passenger.pool.used', '2')
      expect(statsd).to receive(:gauge).with('passenger.pool.max', '5')
      expect(statsd).to receive(:gauge).with('passenger.request_queue', '0')
      expect(statsd).to receive(:gauge).with('passenger.capacity_used', '2')
      expect(statsd).to receive(:gauge).with('passenger.processes_being_spawned', '0')
      expect(statsd).to receive(:gauge).with('passenger.enabled_process_count', '2')
      expect(statsd).to receive(:gauge).with('passenger.disabling_process_count', '0')
      expect(statsd).to receive(:gauge).with('passenger.disabled_process_count', '0')
      expect(statsd).to receive(:gauge).with('passenger.processed', '2', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '409596', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '126456', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '267231', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '126456', :tags => ['passenger-process:0'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '812632', :tags => ['passenger-process:0'])

      expect(statsd).to receive(:gauge).with('passenger.processed', '3', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.sessions', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.busyness', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.concurrency', '1', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.cpu', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.rss', '407972', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.private_dirty', '124832', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.pss', '265607', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.swap', '0', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.real_memory', '124832', :tags => ['passenger-process:1'])
      expect(statsd).to receive(:gauge).with('passenger.vmsize', '812536', :tags => ['passenger-process:1'])

      described_class.run
    end
  end
end
